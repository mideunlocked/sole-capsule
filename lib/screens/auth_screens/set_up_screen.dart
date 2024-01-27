import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:sole_capsule/widgets/general_widget/custom_text_field.dart';

import '../../helpers/app_contants.dart';
import '../../widgets/general_widget/custom_back_button.dart';
import '../../widgets/general_widget/custom_button.dart';
import '../../widgets/general_widget/padded_screen_widget.dart';

class SetUpScreen extends StatefulWidget {
  static const routeName = '/SetUpScreen';

  const SetUpScreen({super.key});

  @override
  State<SetUpScreen> createState() => _SetUpScreenState();
}

class _SetUpScreenState extends State<SetUpScreen> {
  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 5.h);
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var titleMedium = textTheme.titleMedium;

    return Scaffold(
      body: SafeArea(
        child: PaddedScreenWidget(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomBackButton(),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/LoginScreen');
                      },
                      child: Text(
                        'Login Instead',
                        style: textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
                sizedBox,
                Text(
                  'Set up your profile',
                  style: titleMedium?.copyWith(fontSize: 20.sp),
                ),
                SizedBox(height: 0.5.h),
                const Text(
                  'Personalize your SoleCapsule experience by adding a unique username and profile picture.',
                  style: TextStyle(color: Colors.black54),
                ),
                sizedBox,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFB7B7B7),
                    ),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25.sp,
                        backgroundColor: Colors.grey.shade300,
                        child: SvgPicture.asset(AppConstants.personIcon),
                      ),
                      SizedBox(width: 3.w),
                      const Text(
                        'Click to upload profile picture',
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                sizedBox,
                CustomTextField(
                  controller: TextEditingController(),
                  title: 'Username',
                  hint: 'example',
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  onTap: () {},
                  label: 'Complete Sign Up',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
