import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/app_colors.dart';
import '../../provider/theme_mode_provider.dart';
import 'build_pin_button.dart';
import 'passcode_indicator.dart';

class CustomPasscodeWidget extends StatefulWidget {
  const CustomPasscodeWidget({
    super.key,
    required this.getPassCode,
    this.errorText,
    this.additionalButtonFunction,
    this.showAdditionalButton = true,
  });

  final Function()? additionalButtonFunction;
  final Function(String) getPassCode;
  final bool showAdditionalButton;
  final String? errorText;

  @override
  State<CustomPasscodeWidget> createState() => _CustomPasscodeWidgetState();
}

class _CustomPasscodeWidgetState extends State<CustomPasscodeWidget> {
  String passcode = '';

  void inputCode(int code) => setState(() {
        if (passcode.length < 6) {
          passcode = passcode.toString() + code.toString();
        }
        if (passcode.length == 6) {
          widget.getPassCode(passcode);
        }
      });

  @override
  Widget build(BuildContext context) {
    var themePvr = Provider.of<ThemeModeProvider>(context, listen: false);

    bool isLight = themePvr.isLight;

    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PasscodeIndicator(
                  passcode: passcode,
                  index: 0,
                ),
                PasscodeIndicator(
                  passcode: passcode,
                  index: 1,
                ),
                PasscodeIndicator(
                  passcode: passcode,
                  index: 2,
                ),
                PasscodeIndicator(
                  passcode: passcode,
                  index: 3,
                ),
                PasscodeIndicator(
                  passcode: passcode,
                  index: 4,
                ),
                PasscodeIndicator(
                  passcode: passcode,
                  index: 5,
                ),
              ],
            ),
            SizedBox(height: 3.h),
            Visibility(
              visible: widget.errorText != null,
              child: Column(
                children: [
                  Text(
                    widget.errorText ?? '',
                    style: const TextStyle(color: Colors.red),
                  ),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BuildPinButton(number: 1, onPressed: inputCode),
                BuildPinButton(number: 2, onPressed: inputCode),
                BuildPinButton(number: 3, onPressed: inputCode),
              ],
            ),
            SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BuildPinButton(number: 4, onPressed: inputCode),
                BuildPinButton(number: 5, onPressed: inputCode),
                BuildPinButton(number: 6, onPressed: inputCode),
              ],
            ),
            SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BuildPinButton(number: 7, onPressed: inputCode),
                BuildPinButton(number: 8, onPressed: inputCode),
                BuildPinButton(number: 9, onPressed: inputCode),
              ],
            ),
            SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: widget.additionalButtonFunction,
                  child: Icon(
                    Icons.fingerprint_rounded,
                    size: 25.sp,
                    // color: Colors.,
                  ),
                ),
                BuildPinButton(number: 0, onPressed: inputCode),
                TextButton(
                  onPressed: () => setState(() {
                    if (passcode.isNotEmpty) {
                      passcode = passcode.substring(0, passcode.length - 1);
                    }
                  }),
                  child: Icon(
                    Icons.backspace_rounded,
                    color: isLight ? Colors.red : AppColors.tetiary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
