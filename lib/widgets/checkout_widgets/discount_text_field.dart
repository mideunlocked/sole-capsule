import 'package:flutter/material.dart';

import '../../helpers/app_colors.dart';
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

    return TextField(
      controller: controller,
      style: bodyMedium,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        hintText: 'Discount Code',
        hintStyle: bodyMedium?.copyWith(color: Colors.black38),
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        errorBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder.copyWith(
          borderSide: const BorderSide(color: AppColors.secondary),
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
  }
}
