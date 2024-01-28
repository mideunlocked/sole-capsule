import 'package:flutter/material.dart';

import '../models/users.dart';

class UserProvider with ChangeNotifier {
  Users user = const Users(
    id: '',
    email: '',
    devices: '',
    fullName: '',
    password: '',
    username: '',
    profileImage: '',
  );
}
