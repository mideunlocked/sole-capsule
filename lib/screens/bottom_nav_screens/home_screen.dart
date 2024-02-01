import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/box_widgets/add_box_tile.dart';
import '../../widgets/box_widgets/box_tile.dart';
import '../../widgets/general_widgets/padded_screen_widget.dart';

class HomeSceen extends StatelessWidget {
  const HomeSceen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    return SafeArea(
      child: PaddedScreenWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Home',
                  style: textTheme.bodyLarge,
                ),
                Text(
                  'My Boxes',
                  style: textTheme.bodySmall?.copyWith(
                    color: Colors.black54,
                  ),
                )
              ],
            ),
            SizedBox(height: 3.h),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 3.h,
                  crossAxisSpacing: 5.w,
                  childAspectRatio: 0.9,
                ),
                itemCount: 3,
                itemBuilder: (ctx, index) =>
                    index == 2 ? const AddBoxTile() : const BoxTile(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
