import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/general_widget/custom_back_button.dart';
import '../../widgets/general_widget/custom_button.dart';
import '../../widgets/general_widget/custom_text_field.dart';
import '../../widgets/general_widget/loader_widget.dart';
import '../../widgets/general_widget/padded_screen_widget.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/LoginScreen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
  }

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
                  'Welcome Back!',
                  style: titleMedium?.copyWith(fontSize: 20.sp),
                ),
                SizedBox(height: 0.5.h),
                const Text(
                  'Sign in to your SoleCapsule account to reconnect with your smart home.',
                  style: TextStyle(color: Colors.black54),
                ),
                sizedBox,
                CustomTextField(
                  controller: emailController,
                  title: 'Email',
                  hint: 'example@email.com',
                  inputType: TextInputType.emailAddress,
                ),
                sizedBox3,
                CustomTextField(
                  controller: passwordController,
                  title: 'Password',
                  hint: '',
                  isObscure: true,
                  isVisibilityShown: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/ForgotPasswordScreen');
                      },
                      child: Text(
                        'Forgot password?',
                        style: textTheme.bodyMedium,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  onTap: () {
                    showCustomLoader(context: context);
                  },
                  label: 'Login',
                ),
                sizedBox3,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don’t have an account? '),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, '/CreateAccountScreen');
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
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
