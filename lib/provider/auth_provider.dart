import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helpers/encrypt_data.dart';
import '../helpers/firebase_constants.dart';
import '../helpers/get_user_id.dart';
import '../helpers/scaffold_messenger_helper.dart';
import '../models/users.dart';
import '../widgets/general_widget/loader_widget.dart';

class AuthProvider with ChangeNotifier {
  Future<dynamic> createUserEmailPassword({
    required Users user,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    try {
      showCustomLoader();

      await EncryptData.encryptAES(user.password);

      await FirebaseConstants.authInstance
          .createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      )
          .then((value) {
        String uid = value.user?.uid ?? '';
        FirebaseConstants.cloudInstance
            .collection(FirebaseConstants.userPath)
            .doc(uid)
            .set(
              user.toJson(uid, user: user),
            );
      });

      notifyListeners();

      showScaffoldMessenger(
        scaffoldKey: scaffoldKey,
        textContent: 'User account succesfully created',
        bkgColor: Colors.green,
      );

      await Future.delayed(
        const Duration(seconds: 1),
      );

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        showScaffoldMessenger(
          scaffoldKey: scaffoldKey,
          textContent: "The password provided is too weak.",
        );
        return false;
      } else if (e.code == 'email-already-in-use') {
        print('An account already exists with that email.');
        showScaffoldMessenger(
          scaffoldKey: scaffoldKey,
          textContent: 'An account already exists with that email.',
        );
        return false;
      } else {
        print(e);
        showScaffoldMessenger(
          scaffoldKey: scaffoldKey,
          textContent: e.toString(),
        );
        return false;
      }
    } catch (e) {
      notifyListeners();

      print("Create user error: $e");
      return e.toString();
    }
  }

  Future<dynamic> updateUserInfo({
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
    required String username,
    required String profileImage,
  }) async {
    try {
      String uid = UserId.getUid();

      await FirebaseConstants.cloudInstance
          .collection(FirebaseConstants.userPath)
          .doc(uid)
          .set(
            {
              'username': username,
              'profileImage': profileImage,
            },
            SetOptions(merge: true),
          )
          .then((value) => showScaffoldMessenger(
                scaffoldKey: scaffoldKey,
                textContent: 'User data updated',
                bkgColor: Colors.green,
              ))
          .catchError(
            (err) => showScaffoldMessenger(
                scaffoldKey: scaffoldKey,
                textContent: 'An error occured, please try again.'),
          );
    } catch (e) {
      notifyListeners();

      print("Sign up error: $e");
      return e.toString();
    }
  }

  Future<bool> checkUsername({
    required String username,
  }) async {
    try {
      QuerySnapshot snapshot = await FirebaseConstants.cloudInstance
          .collection(FirebaseConstants.userPath)
          .get();

      return snapshot.docs.any(
        (element) => element['username'] == username,
      );
    } catch (e) {
      print('Check username error: $e');
      return false;
    }
  }
}
