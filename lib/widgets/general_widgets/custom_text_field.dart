import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/app_colors.dart';
import '../../helpers/check_password_strength.dart';
import '../../provider/theme_mode_provider.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.title,
    required this.hint,
    this.inputAction = TextInputAction.next,
    this.inputType = TextInputType.name,
    this.isObscure = false,
    this.isVisibilityShown = false,
    this.onChanged,
    this.maxLength,
  });

  final TextEditingController controller;
  final Function(String)? onChanged;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final String title;
  final String hint;
  final bool isObscure;
  final bool isVisibilityShown;
  final int? maxLength;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscured = false;

  @override
  void initState() {
    super.initState();

    isObscured = widget.isObscure;
  }

  void toggleObscure() {
    setState(() {
      isObscured = !isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    var bodyMedium = textTheme.bodyMedium;
    var errorStyle = textTheme.bodySmall?.copyWith(
      color: Colors.red,
    );

    var tmPvr = Provider.of<ThemeModeProvider>(context, listen: false);
    bool isLightMode = tmPvr.isLight;

    var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: isLightMode ? Colors.black : Colors.white60,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        SizedBox(height: 1.h),
        TextFormField(
          controller: widget.controller,
          textInputAction: widget.inputAction,
          keyboardType: widget.inputType,
          obscureText: isObscured,
          cursorColor: isLightMode ? AppColors.secondary : Colors.white,
          style: bodyMedium,
          enableSuggestions: !widget.isObscure,
          maxLength: widget.maxLength,
          buildCounter: (context,
                  {required currentLength, required isFocused, maxLength}) =>
              const SizedBox(),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: bodyMedium?.copyWith(
              color: isLightMode ? Colors.black38 : Colors.white54,
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.2.h),
            border: outlineInputBorder,
            enabledBorder: outlineInputBorder,
            errorBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder.copyWith(
              borderSide: BorderSide(
                color: isLightMode ? AppColors.secondary : Colors.white54,
              ),
            ),
            prefix: widget.title.contains('Username')
                ? Text(
                    '@',
                    style: TextStyle(
                      color: isLightMode ? AppColors.secondary : Colors.white,
                      fontStyle: FontStyle.italic,
                    ),
                  )
                : const SizedBox.shrink(),
            suffixIcon: Visibility(
              visible: widget.isVisibilityShown,
              child: IconButton(
                onPressed: toggleObscure,
                icon: Icon(
                  isObscured
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              ),
            ),
            suffixIconColor: isLightMode ? Colors.black : Colors.white,
            errorStyle: errorStyle,
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return '${widget.title} is required';
            }
            if (widget.title.contains('Password') &&
                value.length <= 7 &&
                widget.isVisibilityShown) {
              return 'Password must contain 8 characters or more';
            }
            if (widget.title.contains('Password') &&
                CheckPassword.checkPasswordStrength(value)) {
              return 'Password must contain Uppercase, lowercase, and any special character';
            }
            if (widget.title.contains('Email') && !value.contains('.com')) {
              return 'Email is incorrect';
            }

            return null;
          },
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
