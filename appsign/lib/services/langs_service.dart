import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:appsign/models/models.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

//import 'package:image_picker/image_picker.dart';

class LangsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-7686e-default-rtdb.firebaseio.com';

  final List<Lang> langs = [];
  late Lang selectedLang;

  final storage = new FlutterSecureStorage();

  File? newPictureFile;

  bool isLoading = true;
  bool isSaving = false;

  LangsService() {
    loadLangs();
  }

  Future<List<Lang>> loadLangs() async {
    this.isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, 'lang.json',
        {'auth': await storage.read(key: 'token') ?? ''});
    final resp = await http.get(url);

    final Map<String, dynamic> langsMap = json.decode(resp.body);

    langsMap.forEach((key, value) {
      final tempLang = Lang.fromMap(value);
      //final tempLang = Lang.fromMap(value);
      //tempLang.id = key;
      tempLang.id = key;
      //this.langs.add(tempLang);
      langs.add(tempLang);
    });

    this.isLoading = false;
    notifyListeners();

    return this.langs;

    //print(this.langs[0].letter);

    //todo: hacer el fecha del lenguaje
  }

  Future sabeOrCreateLang(Lang lang) async {
    isSaving = true;
    notifyListeners();

    if (lang.id == null) {
      //es necesario crear
      await this.createLang(lang);
    } else {
      //actualizar
      await this.updateLang(lang);
    }
    isSaving = false;
    notifyListeners();
  }

  Future<String> updateLang(Lang lang) async {
    final url = Uri.https(_baseUrl, 'lang/${lang.id}.json',
        {'auth': await storage.read(key: 'token') ?? ''});

    final resp = await http.put(url, body: lang.toJson());
    // ignore: unused_local_variable
    final decodedData = resp.body;
    //final decodedData = resp.body;
    //print(decodedData);
    //actualizar el listado de los productos

    final index = this.langs.indexWhere((element) => element.id == lang.id);
    this.langs[index] = lang;
    return lang.id!;
  }

  Future<String> createLang(Lang lang) async {
    final url = Uri.https(_baseUrl, 'lang.json',
        {'auth': await storage.read(key: 'token') ?? ''});
    final resp = await http.post(url, body: lang.toJson());
    final decodedData = json.decode(resp.body);

    lang.id = decodedData['name'];

    this.langs.add(lang);

    //print(decodedData);

    return lang.id!;
    //return '';
  }

  void updateSelectedLangImage(String path) {
    this.selectedLang.picture = path;

    this.newPictureFile = File.fromUri(Uri(path: path));

    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (this.newPictureFile == null) return null;

    this.isSaving = true;
    notifyListeners();

    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dwno4q4fu/image/upload?upload_preset=t1htu7t3');

    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file =
        await http.MultipartFile.fromPath('file', newPictureFile!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('algo salio mal');
      print(resp.body);
      return null;
    }

    this.newPictureFile = null;

    //print(resp.body);
    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
  }
}
