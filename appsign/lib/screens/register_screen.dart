import 'package:flutter/material.dart';
import 'package:appsign/providers/login_form_provider.dart';
import 'package:appsign/widgets/widgets.dart';
import 'package:appsign/interface/input_decoration.dart';
import 'package:provider/provider.dart';
import 'package:appsign/services/services.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 275),
              CardContainer(
                  child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Text('CREAR CUENTA',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 30),
                  ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: const LoginsForm())
                ],
              )),
              const SizedBox(height: 50),
              TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, 'login'),
                  style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          Colors.indigo.withOpacity(0.1)),
                      shape: MaterialStateProperty.all(const StadiumBorder())),
                  child: const Text(
                    '¿Ya tienes una cuenta?',
                    style: TextStyle(fontSize: 18, color: Colors.black38),
                  )),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginsForm extends StatelessWidget {
  const LoginsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'kar92@gmail.com',
                  labelText: 'Ingrese su correo electronico',
                  prefixIcon: Icons.alternate_email_rounded),
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'el valor ingresado no es valido';
              },
            ),
            const SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: '*****',
                  labelText: 'Ingrese su contraseña',
                  prefixIcon: Icons.lock_clock_outlined),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                if (value != null && value.length >= 8) return null;
                return 'ingrese 8 caracteres';
              },
            ),
            const SizedBox(height: 30),
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.deepPurple,
                onPressed: loginForm.isLoading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();
                        final authService =
                            Provider.of<AuthService>(context, listen: false);
                        if (!loginForm.isValidForm()) return;
                        loginForm.isLoading = true;

                        // validar si el login es correcto
                        final String? errorMessage = await authService
                            .createUser(loginForm.email, loginForm.password);

                        if (errorMessage == null) {
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacementNamed(context, 'home');
                        } else {
                          //mostrar error en pantalla
                          print(errorMessage);
                          loginForm.isLoading = false;
                        }
                      },
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Text(
                      loginForm.isLoading ? 'espere' : 'Registrar',
                      style: const TextStyle(color: Colors.white),
                    )))
          ],
        ),
      ),
    );
  }
}
