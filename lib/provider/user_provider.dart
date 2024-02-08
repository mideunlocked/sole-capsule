import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../helpers/firebase_constants.dart';
import '../helpers/get_user_id.dart';
import '../helpers/scaffold_messenger_helper.dart';
import '../models/users.dart';

class UserProvider with ChangeNotifier {
  Users _user = const Users(
    id: '',
    email: '',
    boxes: [],
    fullName: '',
    password: '',
    username: '',
    profileImage: '',
    phoneNumber: '',
  );

  Users get user => _user;

  Future<void> getUser({
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    try {
      String uid = UserId.getUid();

      DocumentSnapshot userSnapshot = await FirebaseConstants.cloudInstance
          .collection(FirebaseConstants.userPath)
          .doc(uid)
          .get();

      if (userSnapshot.exists) {
        Map<String, dynamic> data = userSnapshot.data() as Map<String, dynamic>;

        _user = Users.fromJson(json: data);
        notifyListeners();
      } else {
        showScaffoldMessenger(
          scaffoldKey: scaffoldKey,
          textContent: 'Error getting user profile, please try again.',
        );
      }
    } catch (e) {
      print('Get user error: $e');
      return await Future.error(e);
    }
  }
}
