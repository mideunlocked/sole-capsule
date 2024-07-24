import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/auth_provider.dart';
import '../../widgets/general_widgets/custom_back_button.dart';
import '../../widgets/general_widgets/custom_button.dart';
import '../../widgets/general_widgets/custom_text_field.dart';
import '../../widgets/general_widgets/padded_screen_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/ForgotPasswordScreen';

  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
  }

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 5.h);
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var titleMedium = textTheme.titleMedium;

    return Scaffold(
      body: PaddedScreenWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2.h),
            const CustomBackButton(),
            SizedBox(height: 3.h),
            Text(
              'Forgot Your Password?',
              style: titleMedium?.copyWith(fontSize: 20.sp),
            ),
            SizedBox(height: 0.5.h),
            const Text(
              'We\'ve got you covered. Enter your email address, and we\'ll send you a link to reset your password.',
              style: TextStyle(color: Colors.black54),
            ),
            sizedBox,
            CustomTextField(
              controller: emailController,
              title: 'Email',
              hint: 'example@email.com',
              inputType: TextInputType.emailAddress,
              inputAction: TextInputAction.done,
            ),
            const Spacer(),
            CustomButton(
              onTap: sendResetEmail,
              label: 'Submit',
            ),
            sizedBox,
          ],
        ),
      ),
    );
  }

  Future<dynamic> sendResetEmail() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    await authProvider.resetPassword(
      email: emailController.text.trim(),
      scaffoldKey: _scaffoldKey,
    );

    if (mounted) {
      Navigator.pop(context);
    }
  }
}
