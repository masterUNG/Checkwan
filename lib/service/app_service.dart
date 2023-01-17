import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';

class AppService {
  Future<String?> uploadImageToFirebase(
      {required String path, required File file}) async {
    String? urlImage;
    String nameFile = 'image${Random().nextInt(1000000)}.jpg';
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference reference = firebaseStorage.ref().child('$path/$nameFile');
    UploadTask uploadTask = reference.putFile(file);
    await uploadTask.whenComplete(() async {
      urlImage = await reference.getDownloadURL();
    });
    return urlImage;
  }
}
