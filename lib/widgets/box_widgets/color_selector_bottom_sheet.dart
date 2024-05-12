import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/box_provider.dart';
import '../../provider/theme_mode_provider.dart';
import '../general_widgets/padded_screen_widget.dart';
import 'available_color_tile.dart';
import 'delete_box_sheet_button.dart';

class ColorSelectorBottomSheet extends StatefulWidget {
  const ColorSelectorBottomSheet({
    super.key,
    required this.boxId,
    required this.lightColor,
  });

  final String boxId;
  final Color lightColor;

  @override
  State<ColorSelectorBottomSheet> createState() =>
      _ColorSelectorBottomSheetState();
}

class _ColorSelectorBottomSheetState extends State<ColorSelectorBottomSheet> {
  Color _selectedColor = Colors.transparent;

  void selectColor(Color newColor) => setState(() => _selectedColor = newColor);

  @override
  void initState() {
    _selectedColor = widget.lightColor;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      width: 100.w,
      child: PaddedScreenWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Color',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Consumer<ThemeModeProvider>(builder: (context, themePvr, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pick available colors',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: themePvr.isLight
                              ? Colors.black26
                              : Colors.white54,
                        ),
                  ),
                  SizedBox(height: 2.h),
                  Divider(
                    color: themePvr.isLight ? Colors.black26 : Colors.white,
                  ),
                ],
              );
            }),
            SizedBox(height: 2.h),
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 4.h,
                  childAspectRatio: 0.8,
                ),
                children: [
                  AvailableColorTile(
                    color: Colors.white,
                    activeColor: _selectedColor,
                    selectColor: selectColor,
                  ),
                  AvailableColorTile(
                    color: Colors.purple,
                    activeColor: _selectedColor,
                    selectColor: selectColor,
                  ),
                  AvailableColorTile(
                    color: Colors.purpleAccent,
                    activeColor: _selectedColor,
                    selectColor: selectColor,
                  ),
                  AvailableColorTile(
                    color: Colors.red,
                    activeColor: _selectedColor,
                    selectColor: selectColor,
                  ),
                  AvailableColorTile(
                    color: Colors.redAccent,
                    activeColor: _selectedColor,
                    selectColor: selectColor,
                  ),
                  AvailableColorTile(
                    color: Colors.blue,
                    activeColor: _selectedColor,
                    selectColor: selectColor,
                  ),
                  AvailableColorTile(
                    color: Colors.blueAccent,
                    activeColor: _selectedColor,
                    selectColor: selectColor,
                  ),
                  AvailableColorTile(
                    color: Colors.blueGrey,
                    activeColor: _selectedColor,
                    selectColor: selectColor,
                  ),
                  AvailableColorTile(
                    color: Colors.lightBlue,
                    activeColor: _selectedColor,
                    selectColor: selectColor,
                  ),
                  AvailableColorTile(
                    color: Colors.lightBlueAccent,
                    activeColor: _selectedColor,
                    selectColor: selectColor,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DeleteBoxSheetButton(
                  onTap: () => Navigator.pop(context),
                  label: 'Cancel',
                ),
                DeleteBoxSheetButton(
                  onTap: setNewColor,
                  label: 'Set color',
                  backgroundColor: Colors.black,
                  isInverted: true,
                ),
              ],
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  void setNewColor() {
    var boxProvider = Provider.of<BoxProvider>(context, listen: false);

    boxProvider.changeLightColor(id: widget.boxId, color: _selectedColor);

    Navigator.pop(context);
  }
}
