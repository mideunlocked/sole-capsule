import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:sole_capsule/widgets/general_widget/padded_screen_widget.dart';

import '../helpers/firebase_constants.dart';
import '../models/users.dart';
import '../provider/user_provider.dart';
import '../widgets/general_widget/custom_button.dart';

class Home extends StatefulWidget {
  static const rouetName = '/';

  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = false;

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PaddedScreenWidget(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  backgroundColor: Colors.black38,
                ),
              )
            : Consumer<UserProvider>(builder: (context, userProvider, child) {
                Users user = userProvider.user;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Full name: ${user.fullName}'),
                    Text('username: ${user.username}'),
                    Text('email: ${user.email}'),
                    SizedBox(height: 5.h),
                    CustomButton(
                      onTap: getUserData,
                      label: 'Get user data',
                    ),
                    SizedBox(height: 2.h),
                    CustomButton(
                      label: 'Sign out',
                      onTap: () async =>
                          await FirebaseConstants.authInstance.signOut(),
                    ),
                  ],
                );
              }),
      ),
    );
  }

  void getUserData() async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    setState(() {
      isLoading = true;
    });

    await userProvider.getUser(scaffoldKey: _scaffoldKey);

    setState(() {
      isLoading = false;
    });
  }
}
