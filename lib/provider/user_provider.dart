// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../helpers/firebase_constants.dart';
import '../helpers/get_user_id.dart';
import '../helpers/scaffold_messenger_helper.dart';
import '../main.dart';
import '../models/delivery_details.dart';
import '../models/user_details.dart';
import '../models/users.dart';
import '../widgets/general_widgets/loader_widget.dart';
import 'image_provider.dart';

class UserProvider with ChangeNotifier {
  final context = MainApp.navigatorKey.currentState?.overlay?.context;

  Users _user = const Users(
    id: '',
    boxes: [],
    userDetails: UserDetails(
      email: '',
      fullName: '',
      password: '',
      username: '',
      profileImage: '',
      phoneNumber: '',
    ),
    deliveryDetails: DeliveryDetails(
      name: '',
      city: '',
      state: '',
      email: '',
      number: '',
      country: '',
      pinCode: '',
      address: '',
    ),
  );

  Users get user => _user;

  Future<void> getUser({
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    String uid = UserId.getUid();

    try {
      DocumentSnapshot userSnapshot = await FirebaseConstants.cloudInstance
          .collection(FirebaseConstants.userPath)
          .doc(uid)
          .get();

      print(uid);
      print(userSnapshot.id);

      if (userSnapshot.exists) {
        print(userSnapshot.exists);
        Map<String, dynamic> data = userSnapshot.data() as Map<String, dynamic>;

        print(data);

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
      showScaffoldMessenger(
        scaffoldKey: scaffoldKey,
        textContent: 'Error getting user profile, please try again.',
      );
      return await Future.error(e);
    }
  }

  Future<void> updateUserDetails({
    required File profileImage,
    required UserDetails userDetails,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    showCustomLoader();
    String uid = UserId.getUid();

    try {
      String? profileImageUrl = '';

      if (profileImage.existsSync()) {
        profileImageUrl =
            await AppImageProvider().uploadProfileImage(profileImage);
      }

      print('Profile image url $profileImageUrl');

      await FirebaseConstants.cloudInstance
          .collection(FirebaseConstants.userPath)
          .doc(uid)
          .set(
        {
          'userDetails': userDetails.toJson(
            pProfileImage: profileImageUrl ?? '',
            encryptedPassword: user.userDetails.password,
          ),
        },
        SetOptions(merge: true),
      ).then((_) async {
        await getUser(scaffoldKey: scaffoldKey);

        showScaffoldMessenger(
          scaffoldKey: scaffoldKey,
          textContent: 'User details updated',
          bkgColor: Colors.green,
        );

        if (context!.mounted) {
          Navigator.pop(context!);
        }
      }).catchError((e) {
        if (context!.mounted) {
          Navigator.pop(context!);
        }
        print('Update user details error: $e');
        showScaffoldMessenger(
          scaffoldKey: scaffoldKey,
          textContent: 'Failed to update user details, try again',
        );
      });
    } catch (e) {
      if (context!.mounted) {
        Navigator.pop(context!);
      }
      print('Update user details error: $e');
      showScaffoldMessenger(
        scaffoldKey: scaffoldKey,
        textContent: 'Failed to update user details, try again',
      );
    }
  }

  Future<void> updateDeliveryDetails({
    required DeliveryDetails details,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    String uid = UserId.getUid();

    showCustomLoader();

    try {
      await FirebaseConstants.cloudInstance
          .collection(FirebaseConstants.userPath)
          .doc(uid)
          .set(
        {
          'deliveryDetails': details.toJSon(),
        },
        SetOptions(merge: true),
      ).then((_) async {
        await getUser(scaffoldKey: scaffoldKey);

        showScaffoldMessenger(
          scaffoldKey: scaffoldKey,
          textContent: 'Delivery details updated',
          bkgColor: Colors.green,
        );
      }).catchError((e) {
        print('Update delivery details error: $e');
        showScaffoldMessenger(
          scaffoldKey: scaffoldKey,
          textContent: 'Failed to update delivery details, try again',
        );
      });
    } catch (e) {
      print('Update delivery details error: $e');
      showScaffoldMessenger(
        scaffoldKey: scaffoldKey,
        textContent: 'Failed to update delivery details, try again',
      );
    }
  }
}
