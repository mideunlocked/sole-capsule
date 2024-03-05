import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:sole_capsule/widgets/general_widgets/custom_button.dart';
import 'package:sole_capsule/widgets/general_widgets/custom_text_field.dart';
import 'package:sole_capsule/widgets/general_widgets/profile_image_selector.dart';

import '../../models/user_details.dart';
import '../../models/users.dart';
import '../../provider/auth_provider.dart';
import '../../provider/user_provider.dart';
import '../../widgets/general_widgets/custom_app_bar.dart';
import '../../widgets/general_widgets/padded_screen_widget.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/EditProfileScreen';

  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  var fullNameCtr = TextEditingController();
  var emailCtr = TextEditingController();
  var numberCtr = TextEditingController();
  var usernameCtr = TextEditingController();
  String profileImageUrl = '';

  File profileImageFile = File('');

  bool usernameAvailable = false;
  bool isLoading = false;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();

    getUserDetails();
  }

  @override
  void dispose() {
    super.dispose();

    fullNameCtr.dispose();
    emailCtr.dispose();
    numberCtr.dispose();
    usernameCtr.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 3.h);
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    return Scaffold(
      body: ScaffoldMessenger(
        key: _scaffoldKey,
        child: SafeArea(
          child: PaddedScreenWidget(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const CustomAppBar(title: 'Edit Profile'),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          sizedBox,
                          SelectProfileImageWidget(
                            imageUrl: profileImageUrl,
                            getProfileImage: getProfileImage,
                          ),
                          sizedBox,
                          CustomTextField(
                            controller: fullNameCtr,
                            title: 'Full Name',
                            hint: 'Enter full name',
                          ),
                          sizedBox,
                          Consumer<AuthProvider>(
                              builder: (ctx, provider, child) {
                            return CustomTextField(
                              controller: usernameCtr,
                              title: 'Username',
                              hint: 'example',
                              inputAction: TextInputAction.done,
                              onChanged: (value) async {
                                print(value);
                                bool isAvailable = await provider.checkUsername(
                                  username: value,
                                );

                                setState(() {
                                  isChecked = true;
                                  usernameAvailable = isAvailable;
                                });
                              },
                            );
                          }),
                          SizedBox(height: 0.5.h),
                          !isChecked
                              ? const SizedBox()
                              : Row(
                                  children: [
                                    Visibility(
                                      visible: isLoading,
                                      replacement: Icon(
                                        usernameAvailable
                                            ? Icons.check_circle_rounded
                                            : Icons.cancel_rounded,
                                        color: usernameAvailable
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                      child: SizedBox(
                                        height: 1.5.h,
                                        width: 3.w,
                                        child: CircularProgressIndicator(
                                          color: Colors.grey.shade300,
                                          backgroundColor: Colors.grey.shade200,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 2.w),
                                    Text(
                                      usernameAvailable
                                          ? 'username available'
                                          : 'username already in use',
                                      style: textTheme.bodySmall?.copyWith(
                                          color: usernameAvailable
                                              ? Colors.green
                                              : Colors.red),
                                    ),
                                  ],
                                ),
                          sizedBox,
                          CustomTextField(
                            controller: emailCtr,
                            title: 'Email Address',
                            hint: 'Enter email address',
                          ),
                          sizedBox,
                          CustomTextField(
                            controller: numberCtr,
                            title: 'Phone Number',
                            hint: 'Enter phone number',
                          ),
                          sizedBox,
                          sizedBox,
                          CustomButton(
                            onTap: updateUserDetails,
                            label: 'Save',
                          ),
                          sizedBox,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getProfileImage(File file) {
    setState(() => profileImageFile = file);
  }

  void getUserDetails() {
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    Users userData = userProvider.user;
    UserDetails userDetails = userData.userDetails;

    setState(() {
      fullNameCtr = TextEditingController(text: userDetails.fullName);
      emailCtr = TextEditingController(text: userDetails.email);
      numberCtr = TextEditingController(text: userDetails.phoneNumber);
      usernameCtr = TextEditingController(text: userDetails.username);
      profileImageUrl = userDetails.profileImage;
    });
  }

  void updateUserDetails() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid == false) {
      return;
    } else {
      var userProvider = Provider.of<UserProvider>(context, listen: false);

      await userProvider.updateUserDetails(
        profileImage: profileImageFile,
        userDetails: UserDetails(
          email: emailCtr.text.trim(),
          fullName: fullNameCtr.text.trim(),
          username: usernameCtr.text.trim(),
          password: '',
          phoneNumber: numberCtr.text.trim(),
          profileImage: '',
        ),
        scaffoldKey: _scaffoldKey,
      );
    }
  }
}
