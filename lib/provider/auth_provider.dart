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
      showCustomLoader();
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
      ).then((value) => showScaffoldMessenger(
                scaffoldKey: scaffoldKey,
                textContent: 'User data updated',
                bkgColor: Colors.green,
              ));

      return true;
    } catch (e) {
      showScaffoldMessenger(
        scaffoldKey: scaffoldKey,
        textContent: 'An error occured, please try again.',
      );

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
          .where('username', isEqualTo: username)
          .get();

      return snapshot.docs.isEmpty;
    } catch (e) {
      print('Check username error: $e');
      return false;
    }
  }

  Future<dynamic> signInUSer({
    required String loginDetail,
    required String password,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    showCustomLoader();
    try {
      if (loginDetail.contains(".com") != true) {
        QuerySnapshot snap = await FirebaseConstants.cloudInstance
            .collection("users")
            .where("username", isEqualTo: loginDetail)
            .get();

        await FirebaseConstants.authInstance.signInWithEmailAndPassword(
          email: snap.docs[0]["email"],
          password: password,
        );

        return true;
      } else {
        await FirebaseConstants.authInstance.signInWithEmailAndPassword(
          email: loginDetail,
          password: password,
        );

        return true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email/username.');
        showScaffoldMessenger(
          scaffoldKey: scaffoldKey,
          textContent: 'No user found for that email/username.',
        );
        return false;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        showScaffoldMessenger(
          scaffoldKey: scaffoldKey,
          textContent: 'Wrong password provided for that user.',
        );
        return false;
      } else if (e.code == "INVALID_LOGIN_CREDENTIALS") {
        print("Invalid login credentials");
        showScaffoldMessenger(
          scaffoldKey: scaffoldKey,
          textContent:
              'Invalid login credentials. Please check credetials and try again',
        );
        return false;
      } else {
        print(e);
        showScaffoldMessenger(
          scaffoldKey: scaffoldKey,
          textContent: e.message.toString(),
        );
        return false;
      }
    } catch (e) {
      print("Sign in error: $e");

      showScaffoldMessenger(
        scaffoldKey: scaffoldKey,
        textContent: "Sign in error: $e",
      );
      return e;
    }
  }

  Future<dynamic> resetPassword({
    required String email,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    showCustomLoader();
    try {
      FirebaseConstants.authInstance.sendPasswordResetEmail(email: email).then(
            (value) => showScaffoldMessenger(
              scaffoldKey: scaffoldKey,
              textContent: 'Reset password email as been sent to your inbox',
              bkgColor: Colors.green,
            ),
          );

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        showScaffoldMessenger(
          scaffoldKey: scaffoldKey,
          textContent: 'No user found for that email.',
        );
        return false;
      } else {
        print(e);
        showScaffoldMessenger(
          scaffoldKey: scaffoldKey,
          textContent: e.message.toString(),
        );
        return false;
      }
    } catch (e) {
      print("Resest password error: $e");
      showScaffoldMessenger(
        scaffoldKey: scaffoldKey,
        textContent: 'Resest password error: $e',
      );
      return false;
    }
  }

  Future<dynamic> changePassword(
      String currentPassword, String newPassword) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Re-authenticate the user with their current password.
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPassword,
        );

        await user.reauthenticateWithCredential(credential);

        // If reauthentication is successful, update the password.
        await user.updatePassword(newPassword).then((value) {
          EncryptData.encryptAES(newPassword);
          FirebaseConstants.cloudInstance
              .collection("users")
              .doc(user.uid)
              .update({
            "password": EncryptData.encrypted?.base64,
          });
        });

        // Password updated successfully.
        print("Password changed successfully");
        return true;
      } else {
        // User is not signed in.
        print("User not signed in.");
        return "User not signed in.";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return "The password provided is too weak.";
      } else if (e.code == "requires-recent-login") {
        print(
            "This operation is sensitive and requires recent authentication. Log in again before retrying this request.");
        return "This operation is sensitive and requires recent authentication. Log in again before retrying this request.";
      } else {
        print(e);
        return e.message;
      }
    } catch (e) {
      notifyListeners();

      print("Change password error: $e");
      return e.toString();
    }
  }
}
