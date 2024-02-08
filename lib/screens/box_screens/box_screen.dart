import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/box_widgets/box_screen_app_bar.dart';
import '../../widgets/box_widgets/delete_box_button.dart';
import '../../widgets/general_widgets/padded_screen_widget.dart';

class BoxScreen extends StatefulWidget {
  static const routeName = '/BoxScreen';

  const BoxScreen({super.key});

  @override
  State<BoxScreen> createState() => _BoxScreenState();
}

class _BoxScreenState extends State<BoxScreen> {
  bool _toggleBox = false;
  bool _toggleLight = false;

  void toggleBox(bool newToggle) {
    setState(() {
      _toggleBox = newToggle;
    });
  }

  void toggleLight(bool newToggle) {
    setState(() {
      _toggleLight = newToggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var titleLarge = textTheme.titleLarge;

    return Scaffold(
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
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 30.w,
                                child: Text(
                                  'Nike Box',
                                  style: titleLarge?.copyWith(
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                              ),
                              Text(
                                'Nike \nBox',
                                style: textTheme.titleMedium,
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          CupertinoSwitch(
                            value: _toggleBox,
                            activeColor: Colors.black,
                            onChanged: toggleBox,
                          ),
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
                        CupertinoSwitch(
                          value: _toggleLight,
                          activeColor: Colors.black,
                          onChanged: toggleLight,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const DeleteBoxButton(),
            SizedBox(height: 2.h)
          ],
        ),
      ),
    );
  }
}
