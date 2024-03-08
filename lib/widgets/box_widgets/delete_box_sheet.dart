import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/box_provider.dart';
import '../../provider/theme_mode_provider.dart';
import '../general_widgets/padded_screen_widget.dart';
import 'delete_box_sheet_button.dart';

void showDeleteBoxSheet({
  required BuildContext context,
  required String boxId,
}) async {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    backgroundColor: Colors.transparent,
    builder: (ctx) => DeleteBoxSheet(
      boxId: boxId,
    ),
  );
}

class DeleteBoxSheet extends StatelessWidget {
  const DeleteBoxSheet({
    super.key,
    required this.boxId,
  });

  final String boxId;

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 3.h);

    var of = Theme.of(context);
    var textTheme = of.textTheme;

    return Consumer<ThemeModeProvider>(builder: (context, tmPvr, child) {
      bool isLightMode = tmPvr.isLight;

      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: 40.h,
          ),
          Container(
            height: 33.h,
            width: 100.w,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              color: isLightMode ? Colors.white : const Color(0xFF21272C),
            ),
            child: PaddedScreenWidget(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Are you sure you want to delete this box?',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(fontSize: 16.sp),
                  ),
                  sizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DeleteBoxSheetButton(
                        label: 'Cancel',
                        onTap: () => Navigator.pop(context),
                      ),
                      Consumer<BoxProvider>(builder: (context, boxPvr, _) {
                        return DeleteBoxSheetButton(
                          label: 'Delete',
                          isInverted: true,
                          onTap: () {
                            boxPvr.deleteBox(id: boxId);
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/',
                              (route) => false,
                            );
                          },
                        );
                      }),
                    ],
                  ),
                  sizedBox,
                  sizedBox,
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 24.h,
            child: Container(
              padding: EdgeInsets.all(5.sp),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 40.sp,
                backgroundColor: Colors.black,
                child: SvgPicture.asset(
                  'assets/icons/delete.svg',
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
