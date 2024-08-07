import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/box.dart';
import '../../provider/box_provider.dart';
import '../../provider/theme_mode_provider.dart';
import '../../widgets/box_widgets/box_screen_app_bar.dart';
import '../../widgets/box_widgets/color_selector_bottom_sheet.dart';
import '../../widgets/general_widgets/padded_screen_widget.dart';

class BoxScreen extends StatefulWidget {
  static const routeName = '/BoxScreen';

  const BoxScreen({super.key});

  @override
  State<BoxScreen> createState() => _BoxScreenState();
}

class _BoxScreenState extends State<BoxScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    Box box = ModalRoute.of(context)!.settings.arguments as Box;

    var of = Theme.of(context);
    var textTheme = of.textTheme;

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/');

        throw 0;
      },
      child: Scaffold(
        body: ScaffoldMessenger(
          key: _scaffoldKey,
          child: Stack(
            children: [
              Consumer<ThemeModeProvider>(builder: (context, tmPvr, child) {
                bool isLightMode = tmPvr.isLight;
                return Visibility(
                  visible: box.isLightOn == true,
                  replacement: const SizedBox.expand(),
                  child: Container(
                    height: 100.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: const [0.0, 0.3],
                        colors: [
                          isLightMode ? Colors.amber : Colors.amber.shade100,
                          isLightMode
                              ? tmPvr.themeMode.scaffoldBackgroundColor
                              : Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                );
              }),
              SizedBox(
                height: 100.h,
                width: 100.w,
                child: Consumer<ThemeModeProvider>(
                    builder: (context, tmPvr, child) {
                  bool isLightMode = tmPvr.isLight;

                  bool noCustomFont = box.fontFamily.isEmpty;

                  return Column(
                    children: [
                      SizedBox(height: 2.h),
                      PaddedScreenWidget(
                        child: BoxAppBar(
                          id: box.id,
                          name: box.name,
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 3.h),
                              Padding(
                                padding: EdgeInsets.only(right: 5.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 30.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              SizedBox(
                                                width: 30.w,
                                                child: Text(
                                                  box.name,
                                                  style: noCustomFont
                                                      ? textTheme.titleLarge
                                                          ?.copyWith(
                                                          color: isLightMode
                                                              ? Colors
                                                                  .grey.shade300
                                                              : Colors.white24,
                                                          fontSize: 30.sp,
                                                        )
                                                      : GoogleFonts.getFont(
                                                              box.fontFamily)
                                                          .copyWith(
                                                          color: isLightMode
                                                              ? Colors
                                                                  .grey.shade300
                                                              : Colors.white24,
                                                          fontSize: 30.sp,
                                                        ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 5.w),
                                                child: SizedBox(
                                                  width: 30.w,
                                                  child: Text(
                                                    box.name.splitMapJoin(
                                                      ' ',
                                                      onMatch: (p0) => '\n',
                                                    ),
                                                    style: noCustomFont
                                                        ? textTheme.titleSmall
                                                        : GoogleFonts.getFont(
                                                                box.fontFamily)
                                                            .copyWith(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 20.sp,
                                                            // color: Colors.black,
                                                          ),
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
                                              activeColor: isLightMode
                                                  ? Colors.black
                                                  : Colors.white,
                                              thumbColor: isLightMode
                                                  ? Colors.white
                                                  : Colors.black,
                                              trackColor: isLightMode
                                                  ? null
                                                  : Colors.grey,
                                              onChanged: (_) async =>
                                                  await boxPvr.toggleBoxOpen(
                                                      id: box.id,
                                                      context: context,
                                                      scaffoldKey: _scaffoldKey,
                                                      status:
                                                          box.isOpen ? 0 : 1),
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                    Hero(
                                      tag: box.id,
                                      child: box.imagePath.isNotEmpty
                                          ? Image.file(
                                              File(box.imagePath),
                                              height: 20.h,
                                              width: 30.w,
                                              fit: BoxFit.scaleDown,
                                            )
                                          : SvgPicture.asset(
                                              isLightMode
                                                  ? 'assets/images/box.svg'
                                                  : 'assets/images/box2.svg',
                                              height: 25.h,
                                              width: 30.w,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5.h),
                              PaddedScreenWidget(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Light',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w500),
                                    ),
                                    Consumer<BoxProvider>(
                                        builder: (context, boxPvr, _) {
                                      return CupertinoSwitch(
                                        value: box.isLightOn,
                                        activeColor: isLightMode
                                            ? Colors.black
                                            : Colors.white,
                                        thumbColor: isLightMode
                                            ? Colors.white
                                            : Colors.black,
                                        trackColor:
                                            isLightMode ? null : Colors.grey,
                                        onChanged: (_) async =>
                                            await boxPvr.toggleLight(
                                                id: box.id,
                                                context: context,
                                                scaffoldKey: _scaffoldKey,
                                                status: box.isLightOn ? 0 : 1),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                              Consumer<BoxProvider>(
                                  builder: (context, boxPvr, _) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    PaddedScreenWidget(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          SizedBox(height: 5.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Brightness',
                                                style: textTheme.bodyMedium
                                                    ?.copyWith(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                '${box.lightIntensity.toInt()}%',
                                                style: textTheme.bodyMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                      divisions: 8,
                                      activeColor: isLightMode
                                          ? Colors.black
                                          : Colors.white,
                                      thumbColor: isLightMode
                                          ? Colors.black
                                          : Colors.white,
                                      inactiveColor: Colors.white,
                                      onChanged: (value) async {
                                        await boxPvr.changeIntensity(
                                          id: box.id,
                                          intensity: value,
                                          context: context,
                                          scaffoldKey: _scaffoldKey,
                                        );
                                      },
                                      allowedInteraction:
                                          SliderInteraction.slideThumb,
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
                                          ?.copyWith(
                                              fontWeight: FontWeight.w500),
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
                              SizedBox(height: 10.h),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showColorSelector(
    BuildContext context, {
    required Box box,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => ColorSelectorBottomSheet(
        boxId: box.id,
        lightColor: box.lightColor,
        scaffoldKey: _scaffoldKey,
      ),
    );
  }
}
