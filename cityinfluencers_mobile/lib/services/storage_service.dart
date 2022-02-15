import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  //uploaden van afbeelding naar firebase
  Future<void> uploadFile(
    String filePath,
    String fileName,
  ) async {
    File file = File(filePath);

    try {
      await storage.ref('flutter-storage/$fileName').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  //afhalen van afbeelding URL uit firebase
  Future<String> getFile(String fileName) async {
    String downloadUrl = "";
    try {
      downloadUrl =
          await storage.ref('flutter-storage/$fileName').getDownloadURL();
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
    return downloadUrl;
  }
}
