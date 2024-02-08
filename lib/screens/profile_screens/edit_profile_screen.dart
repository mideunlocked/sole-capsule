import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:sole_capsule/widgets/general_widgets/custom_button.dart';
import 'package:sole_capsule/widgets/general_widgets/custom_text_field.dart';
import 'package:sole_capsule/widgets/general_widgets/profile_image_selector.dart';

import '../../models/users.dart';
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

  @override
  void dispose() {
    super.dispose();

    fullNameCtr.dispose();
    emailCtr.dispose();
    numberCtr.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 3.h);

    return Scaffold(
      body: SafeArea(
        child: PaddedScreenWidget(
          child: Consumer<UserProvider>(
            builder: (context, user, child) {
              Users userData = user.user;

              fullNameCtr = TextEditingController(text: userData.fullName);
              emailCtr = TextEditingController(text: userData.email);
              numberCtr = TextEditingController(text: userData.phoneNumber);

              return Column(
                children: [
                  const CustomAppBar(title: 'Edit Profile'),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          sizedBox,
                          SelectProfileImageWidget(
                            imageUrl: userData.profileImage,
                          ),
                          sizedBox,
                          CustomTextField(
                            controller: fullNameCtr,
                            title: 'Full Name',
                            hint: 'Enter full name',
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
                          sizedBox,
                          sizedBox,
                          CustomButton(
                            onTap: () {},
                            label: 'Save',
                          ),
                          sizedBox,
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
