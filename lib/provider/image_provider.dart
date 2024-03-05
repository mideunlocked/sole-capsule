import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AppImageProvider with ChangeNotifier {
  FirebaseAuth authInstance = FirebaseAuth.instance;
  FirebaseStorage storageInstance = FirebaseStorage.instance;
  FirebaseFirestore cloudInstance = FirebaseFirestore.instance;

  Future<String?> uploadProfileImage(File imageFile) async {
    try {
      String? uid = authInstance.currentUser?.uid;
      if (uid == null) {
        throw Exception("User not authenticated");
      }

      String path = "users/$uid";
      Reference storageRef = storageInstance.ref().child(path);

      UploadTask uploadTask = storageRef.putFile(imageFile);

      TaskSnapshot snapshot = await uploadTask;

      String imageUrl = await snapshot.ref.getDownloadURL();

      await authInstance.currentUser?.updatePhotoURL(imageUrl);

      return imageUrl;
    } catch (e) {
      print("Profile image upload error: $e");
      notifyListeners();
      return null;
    }
  }
}
