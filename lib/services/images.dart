import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImageService {

  void addImages() {
    var storage = FirebaseStorage.instance;
    List<String> listOfImage = [
      'assets/images/blackGirl.png',
    ];
    listOfImage.forEach((img) async {

      String imageName = img
          .substring(img.lastIndexOf("/"), img.lastIndexOf("."))
          .replaceAll("/", "");

      String path = img.substring(img.indexOf("/") + 1, img.lastIndexOf("/"));

      final Directory systemTempDir = Directory.systemTemp;
      final byteData = await rootBundle.load(img);
      final file = File('${systemTempDir.path}/$imageName.jpeg');
      await file.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
      TaskSnapshot taskSnapshot =
      await storage.ref('$path/$imageName').putFile(file);
      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      print(downloadUrl);
      await FirebaseFirestore.instance
          .collection(path)
          .add({"url": downloadUrl, "name": imageName});
    });
    print('finished.............');
  }

}