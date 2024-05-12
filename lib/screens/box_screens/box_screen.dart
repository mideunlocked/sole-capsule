import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/box.dart';
import '../../provider/box_provider.dart';
import '../../provider/theme_mode_provider.dart';
import '../../widgets/box_widgets/box_screen_app_bar.dart';
import '../../widgets/box_widgets/color_selector_bottom_sheet.dart';
import '../../widgets/general_widgets/padded_screen_widget.dart';

class BoxScreen extends StatelessWidget {
  static const routeName = '/BoxScreen';

  const BoxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Box box = ModalRoute.of(context)!.settings.arguments as Box;

    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var titleLarge = textTheme.titleLarge;

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/');

        throw 0;
      },
      child: Scaffold(
        body: Consumer<ThemeModeProvider>(builder: (context, tmPvr, child) {
          bool isLightMode = tmPvr.isLight;

          return SafeArea(
            child: Column(
              children: [
                SizedBox(height: 2.h),
                PaddedScreenWidget(
                  child: BoxAppBar(
                    id: box.id,
                    name: box.name,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 3.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    width: 30.w,
                                    child: Text(
                                      box.name,
                                      style: titleLarge?.copyWith(
                                        color: isLightMode
                                            ? Colors.grey.shade300
                                            : Colors.white24,
                                        fontSize: 30.sp,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5.w),
                                    child: SizedBox(
                                      width: 30.w,
                                      child: Text(
                                        box.name.splitMapJoin(
                                          ' ',
                                          onMatch: (p0) => '\n',
                                        ),
                                        style: textTheme.titleSmall,
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2.h),
                              Consumer<BoxProvider>(
                                  builder: (context, boxPvr, _) {
                                return CupertinoSwitch(
                                  value: box.isOpen,
                                  activeColor:
                                      isLightMode ? Colors.black : Colors.white,
                                  thumbColor:
                                      isLightMode ? Colors.white : Colors.black,
                                  trackColor: isLightMode ? null : Colors.grey,
                                  onChanged: (_) =>
                                      boxPvr.toggleBoxOpen(id: box.id),
                                );
                              }),
                            ],
                          ),
                          Hero(
                            tag: box.id,
                            child: SvgPicture.asset(
                              isLightMode
                                  ? 'assets/images/box.svg'
                                  : 'assets/images/box2.svg',
                              height: 30.h,
                              width: 30.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      PaddedScreenWidget(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Color',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 0.5.h),
                            InkWell(
                              onTap: () => showColorSelector(
                                context,
                                box: box,
                              ),
                              child: Image.asset(
                                'assets/images/color_wheel.png',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Consumer<BoxProvider>(builder: (context, boxPvr, _) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            PaddedScreenWidget(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(height: 5.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Intensity',
                                        style: textTheme.bodyMedium?.copyWith(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${box.lightIntensity.toInt()}%',
                                        style: textTheme.bodyMedium?.copyWith(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Slider(
                              value: box.lightIntensity,
                              min: 0,
                              max: 100,
                              activeColor:
                                  isLightMode ? Colors.black : Colors.white,
                              thumbColor:
                                  isLightMode ? Colors.black : Colors.white,
                              inactiveColor: Colors.white,
                              onChanged: (value) {
                                boxPvr.changeIntensity(
                                  id: box.id,
                                  intensity: value,
                                );
                              },
                              allowedInteraction: SliderInteraction.slideThumb,
                            ),
                            PaddedScreenWidget(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Off',
                                    style: textTheme.bodySmall,
                                  ),
                                  Text(
                                    '100%',
                                    style: textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  void showColorSelector(
    BuildContext context, {
    required Box box,
  }) {
    var themeProvider = Provider.of<ThemeModeProvider>(context, listen: false);

    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      backgroundColor: themeProvider.isLight
          ? Theme.of(context).scaffoldBackgroundColor
          : const Color(0xFF21272C),
      builder: (ctx) => ColorSelectorBottomSheet(
        boxId: box.id,
        lightColor: box.lightColor,
      ),
    );
  }
}
