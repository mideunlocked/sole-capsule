import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/general_widgets/custom_back_button.dart';
import '../../widgets/general_widgets/custom_button.dart';
import '../../widgets/general_widgets/custom_text_field.dart';
import '../../widgets/general_widgets/padded_screen_widget.dart';
import '../../widgets/general_widgets/successfull_sheet.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const routeName = '/ResetPasswordScreen';

  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final passwordController = TextEditingController();
  final confPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 5.h);
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var titleMedium = textTheme.titleMedium;

    var sizedBox3 = SizedBox(height: 3.h);

    return Scaffold(
      body: SafeArea(
        child: PaddedScreenWidget(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h),
                const CustomBackButton(),
                sizedBox,
                Text(
                  'Reset your password',
                  style: titleMedium?.copyWith(fontSize: 20.sp),
                ),
                SizedBox(height: 0.5.h),
                const Text(
                  'Enter your new password below to regain control of your smart home.',
                  style: TextStyle(color: Colors.black54),
                ),
                sizedBox,
                CustomTextField(
                  controller: passwordController,
                  title: 'Password',
                  hint: 'Something descrete..',
                  isObscure: true,
                  isVisibilityShown: true,
                ),
                sizedBox3,
                CustomTextField(
                  controller: confPassController,
                  title: 'Confirm Password',
                  hint: '',
                  isObscure: true,
                  inputAction: TextInputAction.done,
                ),
                SizedBox(height: 30.h),
                CustomButton(
                  onTap: () {
                    showSuccesfullSheet(
                      context: context,
                      buttonTitle: 'Login',
                      buttonFunction: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/LoginScreen', (route) => false);
                      },
                      successMessage: Column(
                        children: [
                          Text(
                            'Password Reset Done!',
                            style: titleMedium?.copyWith(fontSize: 20.sp),
                          ),
                          SizedBox(height: 0.5.h),
                          const Text(
                            'Your password has been reset successfully, you can now login with your new password.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    );
                  },
                  label: 'Submit',
                ),
                sizedBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
