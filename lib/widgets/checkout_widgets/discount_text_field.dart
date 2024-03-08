import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/app_colors.dart';
import '../../models/discount.dart';
import '../../provider/discount_provider.dart';
import '../../provider/theme_mode_provider.dart';
import '../general_widgets/custom_icon.dart';

class DiscountTextField extends StatefulWidget {
  const DiscountTextField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  State<DiscountTextField> createState() => _DiscountTextFieldState();
}

class _DiscountTextFieldState extends State<DiscountTextField> {
  bool isEmpty = false;
  bool isError = false;

  String errorMessage = '';

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () => resetDDiscount());
  }

  @override
  void dispose() {
    super.dispose();

    Future.delayed(Duration.zero, () => resetDDiscount());
  }

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Consumer<ThemeModeProvider>(
          builder: (context, tmPvr, child) {
            bool isLightMode = tmPvr.isLight;

            return TextFormField(
              controller: widget.controller,
              style: bodyMedium,
              textInputAction: TextInputAction.done,
              autovalidateMode: AutovalidateMode.always,
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
                  onTap: getDiscount,
                  child: Text(
                    'Apply',
                    style: bodyMedium,
                  ),
                ),
              ),
              validator: (value) {
                if (isEmpty) {
                  return 'Enter a discount code';
                }
                if (isError) {
                  return errorMessage;
                }

                return null;
              },
              onEditingComplete: () {
                getDiscount();
              },
            );
          },
        ),
        Consumer<DiscountProvider>(
          builder: (context, discountPvr, _) {
            Discount? discount = discountPvr.discount;

            return Visibility(
              visible: discount != null,
              child: Column(
                children: [
                  SizedBox(height: 0.5.h),
                  Text(
                    '${discount?.percentageOff}% discount as been added',
                    style: textTheme.bodySmall?.copyWith(
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  void getDiscount() async {
    if (widget.controller.text.isEmpty) {
      setState(() {
        isEmpty = true;
      });

      return;
    }

    setState(() {
      isEmpty = false;
    });

    var discountPvr = Provider.of<DiscountProvider>(context, listen: false);

    await discountPvr.getDiscount(
      code: widget.controller.text.trim(),
    );

    setState(() {
      errorMessage = discountPvr.errorMessage;
      isError = errorMessage.isNotEmpty;
    });
  }

  void resetDDiscount() {
    if (mounted) {
      var discountPvr = Provider.of<DiscountProvider>(context, listen: false);

      discountPvr.resetDiscount();
    }
  }
}
