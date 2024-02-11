import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/box.dart';
import '../../provider/box_provider.dart';
import '../../widgets/box_widgets/box_screen_app_bar.dart';
import '../../widgets/box_widgets/delete_box_button.dart';
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

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/');

        throw 0;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 2.h),
              const PaddedScreenWidget(
                child: BoxAppBar(),
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
                          children: [
                            Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                SizedBox(
                                  width: 30.w,
                                  child: Text(
                                    box.name,
                                    style: titleLarge?.copyWith(
                                      color: Colors.grey.shade200,
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
                                      style: textTheme.titleMedium,
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
                                activeColor: Colors.black,
                                onChanged: (_) =>
                                    boxPvr.toggleBoxOpen(id: box.id),
                              );
                            }),
                          ],
                        ),
                        SvgPicture.asset(
                          'assets/images/box.svg',
                          height: 30.h,
                          width: 30.w,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    PaddedScreenWidget(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Light',
                            style: textTheme.bodyLarge,
                          ),
                          Consumer<BoxProvider>(builder: (context, boxPvr, _) {
                            return CupertinoSwitch(
                              value: box.isLightOn,
                              activeColor: Colors.black,
                              onChanged: (_) => boxPvr.toggleLight(id: box.id),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              DeleteBoxButton(
                boxId: box.id,
              ),
              SizedBox(height: 2.h)
            ],
          ),
        ),
      ),
    );
  }
}
