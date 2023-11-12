import 'package:appsign/models/models.dart';
import 'package:flutter/material.dart';

class LangFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Lang lang;
  LangFormProvider(this.lang);

  //updateAvaliability(bool value) {
  //print(value);
  //lang.name = value as String;
  //notifyListeners();
  //}

  bool isValidForm() {
    // ignore: avoid_print
    print(lang.name);
    // ignore: avoid_print
    print(lang.letter);
    return formKey.currentState?.validate() ?? false;
  }
}
