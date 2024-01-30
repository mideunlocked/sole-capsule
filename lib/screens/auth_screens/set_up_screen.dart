import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/app_contants.dart';
import '../../provider/auth_provider.dart';
import '../../widgets/general_widget/custom_button.dart';
import '../../widgets/general_widget/custom_text_field.dart';
import '../../widgets/general_widget/padded_screen_widget.dart';

class SetUpScreen extends StatefulWidget {
  static const routeName = '/SetUpScreen';

  const SetUpScreen({super.key});

  @override
  State<SetUpScreen> createState() => _SetUpScreenState();
}

class _SetUpScreenState extends State<SetUpScreen> {
  bool usernameAvailable = false;
  bool isLoading = false;
  bool isChecked = false;

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  final usernameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    usernameController.dispose();
  }

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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                Consumer<AuthProvider>(builder: (ctx, provider, child) {
                  return CustomTextField(
                    controller: usernameController,
                    title: 'Username',
                    hint: 'example',
                    inputAction: TextInputAction.done,
                    onChanged: (value) async {
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
                              color:
                                  usernameAvailable ? Colors.green : Colors.red,
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
                SizedBox(height: 20.h),
                CustomButton(
                  onTap: continueUserSetUp,
                  label: 'Complete Sign Up',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void searchUsername(String username) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    await authProvider.checkUsername(username: username);
  }

  void continueUserSetUp() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final response = await authProvider.updateUserInfo(
      scaffoldKey: _scaffoldKey,
      profileImage: '',
      username: usernameController.text.trim(),
    );

    if (response == true) {
      if (mounted) {
        Navigator.pop(context);
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/',
          (route) => false,
        );
      }
    } else {
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }
}
