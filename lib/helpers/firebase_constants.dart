import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseConstants {
  static final cloudInstance = FirebaseFirestore.instance;
  static final authInstance = FirebaseAuth.instance;
  static final storageInstance = FirebaseStorage.instance;

  static const String userPath = 'users';
  static const String productsPath = 'products';
}
