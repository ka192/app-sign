// ignore: unnecessary_import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:appsign/models/models.dart';
import 'package:appsign/screens/screens.dart';

import 'package:appsign/services/services.dart';
import 'package:appsign/widgets/widgets.dart';

//import 'package:appsign/models/lang.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final langService = Provider.of<LangsService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);
    if (langService.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
          title: const Text('LISTA ABECEDARIO LENGUAJE DE SEÑAS'),

          //colocar un boton al inicio
          //leading: IconButton(
          //icon: Icon(Icons.login_rounded),
          //onPressed: () {},
          //),
          //finaliza colocacion de boton lado izquierdo de arriba

          // coloca boton al inicio lado derecho acontinuacion
          actions: [
            IconButton(
              icon: Icon(Icons.login_rounded),
              onPressed: () {
                authService.logout();
                Navigator.pushReplacementNamed(context, 'login');
              },
            ),
          ]
          //aqui finaliza colocacion de boton a la derecha
          ),
      body: ListView.builder(
          itemCount: langService.langs.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
                onTap: () {
                  langService.selectedLang = langService.langs[index].copy();
                  Navigator.pushNamed(context, 'income');
                },
                child: LengCard(
                  lang: langService.langs[index],
                ),
              )),
      floatingActionButton: FloatingActionButton(
        // ignore: prefer_const_constructors
        child: Icon(Icons.add),
        onPressed: () {
          // ignore: unnecessary_new
          langService.selectedLang = new Lang(letter: '', name: '');
          Navigator.pushNamed(context, 'income');
        },
      ),
    );
  }
}
