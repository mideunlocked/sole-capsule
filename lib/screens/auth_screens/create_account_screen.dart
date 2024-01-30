import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/users.dart';
import '../../provider/auth_provider.dart';
import '../../widgets/general_widget/custom_back_button.dart';
import '../../widgets/general_widget/custom_button.dart';
import '../../widgets/general_widget/custom_text_field.dart';
import '../../widgets/general_widget/padded_screen_widget.dart';

class CreateAccountScreen extends StatefulWidget {
  static const routeName = '/CreateAccountScreen';

  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool isPasswordsSame = false;

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confPassController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confPassController.dispose();
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
        child: SafeArea(
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
                      'Let’s get you started',
                      style: titleMedium?.copyWith(fontSize: 20.sp),
                    ),
                    SizedBox(height: 0.5.h),
                    const Text(
                      'Join the SoleCapsule community! Create your account now to unlock a world of smart living.',
                      style: TextStyle(color: Colors.black54),
                    ),
                    sizedBox,
                    CustomTextField(
                      controller: fullNameController,
                      title: 'Full Name',
                      hint: 'John Doe',
                    ),
                    sizedBox3,
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
                    sizedBox,
                    CustomButton(
                      onTap: createNewUser,
                      label: 'Continue',
                    ),
                    sizedBox3,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account? '),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, '/LoginScreen');
                          },
                          child: Text(
                            'Login',
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
      ),
    );
  }

  void createNewUser() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid == false) {
      return;
    } else {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      Users user = Users(
        id: '',
        email: emailController.text.trim(),
        devices: [],
        fullName: fullNameController.text.trim(),
        password: passwordController.text.trim(),
        username: '',
        profileImage: '',
      );

      final response = await authProvider.createUserEmailPassword(
        user: user,
        scaffoldKey: _scaffoldKey,
      );

      if (mounted) {
        if (response == true) {
          Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/SetUpScreen',
            (route) => false,
          );
        } else {
          Navigator.pop(context);
        }
      }
    }
  }
}
