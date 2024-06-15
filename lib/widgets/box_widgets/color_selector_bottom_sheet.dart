import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/box_provider.dart';
import '../../provider/theme_mode_provider.dart';
import 'delete_box_sheet_button.dart';

class ColorSelectorBottomSheet extends StatefulWidget {
  const ColorSelectorBottomSheet({
    super.key,
    required this.boxId,
    required this.lightColor,
    required this.scaffoldKey,
  });

  final String boxId;
  final Color lightColor;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey;

  @override
  State<ColorSelectorBottomSheet> createState() =>
      _ColorSelectorBottomSheetState();
}

class _ColorSelectorBottomSheetState extends State<ColorSelectorBottomSheet> {
  Color _selectedColor = Colors.red;

  void selectColor(Color newColor) => setState(() => _selectedColor = newColor);

  @override
  void initState() {
    _selectedColor = widget.lightColor;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var themePvr = Provider.of<ThemeModeProvider>(context, listen: false);

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: Container(
        height: 60.h,
        width: 100.w,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
        decoration: BoxDecoration(
          color: themePvr.isLight
              ? Theme.of(context).scaffoldBackgroundColor
              : const Color(0xFF21272C),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            SizedBox(height: 2.h),
            ColorPicker(
              pickerAreaBorderRadius: BorderRadius.circular(500),
              pickerColor: _selectedColor,
              onColorChanged: (color) => setState(() => _selectedColor = color),
              hexInputBar: false,
              labelTypes: const [],
            ),
            DeleteBoxSheetButton(
              onTap: setNewColor,
              label: 'Set color',
              backgroundColor: Colors.black,
              isInverted: true,
            ),
          ],
        ),
      ),
    );
  }

  void setNewColor() async {
    var boxProvider = Provider.of<BoxProvider>(context, listen: false);

    await boxProvider.changeLightColor(
      id: widget.boxId,
      color: _selectedColor,
      context: context,
      scaffoldKey: widget.scaffoldKey,
    );

    if (mounted) Navigator.pop(context);
  }
}
