import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/auth_provider.dart';
import '../../widgets/general_widgets/custom_back_button.dart';
import '../../widgets/general_widgets/custom_button.dart';
import '../../widgets/general_widgets/custom_text_field.dart';
import '../../widgets/general_widgets/padded_screen_widget.dart';

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

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 5.h);
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var titleMedium = textTheme.titleMedium;

    var sizedBox3 = SizedBox(height: 3.h);

    return Scaffold(
      body: ScaffoldMessenger(
        key: _scaffoldKey,
        child: PaddedScreenWidget(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                    title: 'Password ',
                    hint: '',
                    isObscure: true,
                    isVisibilityShown: true,
                    inputAction: TextInputAction.done,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, '/ForgotPasswordScreen');
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
                    onTap: signInUser,
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
      ),
    );
  }

  void signInUser() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid == false) {
      return;
    } else {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      final response = await authProvider.signInUSer(
        loginDetail: emailController.text.trim(),
        password: passwordController.text.trim(),
        context: context,
        scaffoldKey: _scaffoldKey,
      );

      if (mounted) {
        if (response == true) {
          Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/',
            (route) => false,
          );
        } else {
          Navigator.pop(context);
        }
      }
    }
  }
}
