import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;

class FirebaseMediaService {
  Future<String> uploadMedia(File imageFile) async {
    try {
      String fileName = path.basename(imageFile.path);
      Reference storageReference =
          FirebaseStorage.instance.ref().child('images/$fileName');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      await uploadTask.whenComplete(() {
        if (kDebugMode) print('Image uploaded');
      });
      String downloadURL = await storageReference.getDownloadURL();
      return downloadURL;
    } catch (e, stacktrace) {
      if (kDebugMode) {
        print('Error uploading image: $e');
        print('Stack trace: $stacktrace');
      }
      return '';
    }
  }

  Future<List<String>> uploadMultipleMedia(List<File> imageFiles) async {
    List<String> downloadURLs = [];

    try {
      for (File imageFile in imageFiles) {
        String fileName = path.basename(imageFile.path);
        Reference storageReference =
            FirebaseStorage.instance.ref().child('images/$fileName');
        UploadTask uploadTask = storageReference.putFile(imageFile);
        await uploadTask.whenComplete(() {
          if (kDebugMode) print('Image uploaded');
        });
        // Get the download URL
        String downloadURL = await storageReference.getDownloadURL();
        downloadURLs.add(downloadURL);
      }
    } catch (e, stacktrace) {
      if (kDebugMode) {
        print('Error uploading image: $e');
        print('Stack trace: $stacktrace');
      }
      return [];
    }

    return downloadURLs;
  }

  Future<String> uploadProfile(File imageFile) async {
    try {
      String fileName = path.basename(imageFile.path);
      Reference storageReference =
          FirebaseStorage.instance.ref().child('profilePicture/$fileName');

      UploadTask uploadTask = storageReference.putFile(imageFile);

      await uploadTask.whenComplete(() {
        if (kDebugMode) print('Image uploaded');
      });

      String downloadURL = await storageReference.getDownloadURL();
      if (kDebugMode) print("uploaded");
      return downloadURL;
    } catch (e) {
      if (kDebugMode) print('Error uploading image: $e');
      return '';
    }
  }
}
