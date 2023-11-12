import 'package:flutter/material.dart';
import 'package:appsign/services/services.dart';
import 'package:appsign/widgets/widgets.dart';
import 'package:appsign/interface/input_decoration.dart';
import 'package:appsign/providers/lang_form_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class LangScreen extends StatelessWidget {
  const LangScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final langService = Provider.of<LangsService>(context);
    return ChangeNotifierProvider(
      create: (_) => LangFormProvider(langService.selectedLang),
      child: _LangScreenBody(langService: langService),
    );
  }
}

class _LangScreenBody extends StatelessWidget {
  const _LangScreenBody({
    Key? key,
    required this.langService,
  }) : super(key: key);

  final LangsService langService;

  @override
  Widget build(BuildContext context) {
    final langForm = Provider.of<LangFormProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Stack(
              children: [
                LangImage(url: langService.selectedLang.picture),
                Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios_new,
                        size: 40, color: Colors.white),
                  ),
                ),
                Positioned(
                  top: 60,
                  right: 20,
                  child: IconButton(
                    onPressed: () async {
                      //camara o galeria
                      final picker = new ImagePicker();
                      final XFile? pickedFile = await picker.pickImage(
                          source: ImageSource.camera,
                          //source: ImageSource.gallery,
                          imageQuality: 100);
                      if (pickedFile == null) {
                        print('No selecciono nada');
                        return;
                      }
                      //print('Tenemos imagen ${pickedFile.path}');
                      langService.updateSelectedLangImage(pickedFile.path);
                    },
                    icon: const Icon(Icons.camera_alt_outlined,
                        size: 40, color: Colors.white),
                  ),
                ),
              ],
            ),
            //const
            const _LangForm(),
            const SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: langService.isSaving
            ? CircularProgressIndicator(color: Colors.white)
            : Icon(Icons.save_rounded),
        onPressed: langService.isSaving
            ? null
            : () async {
                // guardar imagen
                if (!langForm.isValidForm()) return;

                final String? imageUrl = await langService.uploadImage();

                if (imageUrl != null) langForm.lang.picture = imageUrl;

                await langService.sabeOrCreateLang(langForm.lang);
              },
      ),
    );
  }
}

class _LangForm extends StatelessWidget {
  const _LangForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final langForm = Provider.of<LangFormProvider>(context);
    final lang = langForm.lang;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        //height: 300,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: langForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 30),
              TextFormField(
                initialValue: lang.name,
                onChanged: (value) => lang.name = value,
                //validator: (value) {
                //if (value == null || value.length < 1)
                //return 'nombre obligatorio';
                //},
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Escribir la palabra ABECEDARIO',
                    labelText: 'NOMBRE:'),
              ),
              const SizedBox(height: 30),
              TextFormField(
                initialValue: lang.letter,
                onChanged: (value) => lang.letter = value,
                //validator: (value) {
                //if (value == null || value.length < 1)
                //return 'nombre obligatorio';
                //},
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'ingresar en mayuscula (A, B, C, etc)',
                    labelText: 'LETRA DEL ABECEDARIO'),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 5),
                blurRadius: 5)
          ]);
}
