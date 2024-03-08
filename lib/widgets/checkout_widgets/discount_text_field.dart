import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/app_colors.dart';
import '../../provider/theme_mode_provider.dart';
import '../general_widgets/custom_icon.dart';

class DiscountTextField extends StatelessWidget {
  const DiscountTextField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var bodyMedium = textTheme.bodyMedium;

    var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: Color(0xFFB7B7B7),
      ),
    );

    return Consumer<ThemeModeProvider>(builder: (context, tmPvr, child) {
      bool isLightMode = tmPvr.isLight;

      return TextField(
        controller: controller,
        style: bodyMedium,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          hintText: 'Discount Code',
          hintStyle: bodyMedium?.copyWith(
            color: isLightMode ? Colors.black38 : Colors.white54,
          ),
          border: outlineInputBorder,
          enabledBorder: outlineInputBorder,
          errorBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder.copyWith(
            borderSide: BorderSide(
              color: isLightMode ? AppColors.secondary : Colors.white,
            ),
          ),
          prefixIcon: const IconButton(
            onPressed: null,
            icon: CustomIcon(
              icon: 'discount',
              isPlane: false,
            ),
          ),
          suffix: InkWell(
            onTap: () {},
            child: Text(
              'Apply',
              style: bodyMedium,
            ),
          ),
        ),
      );
    });
  }
}
