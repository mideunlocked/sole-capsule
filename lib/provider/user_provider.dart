import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sole_capsule/models/delivery_details.dart';

import '../helpers/firebase_constants.dart';
import '../helpers/get_user_id.dart';
import '../helpers/scaffold_messenger_helper.dart';
import '../models/users.dart';
import '../widgets/general_widgets/loader_widget.dart';

class UserProvider with ChangeNotifier {
  String uid = UserId.getUid();

  Users _user = const Users(
    id: '',
    email: '',
    boxes: [],
    fullName: '',
    password: '',
    username: '',
    profileImage: '',
    phoneNumber: '',
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
    try {
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
      showScaffoldMessenger(
        scaffoldKey: scaffoldKey,
        textContent: 'Error getting user profile, please try again.',
      );
      return await Future.error(e);
    }
  }

  Future<void> updateDeliveryDetails({
    required DeliveryDetails details,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
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
