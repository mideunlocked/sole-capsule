import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../widgets/general_widgets/custom_app_bar.dart';
import '../widgets/general_widgets/custom_button.dart';
import '../widgets/general_widgets/padded_screen_widget.dart';

class CheckOutScreen extends StatelessWidget {
  static const routeName = '/CheckOutScreen';

  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var customTextStyle = textTheme.bodyMedium?.copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
    );

    var sizedBox = SizedBox(height: 3.h);
    var sizedBox2 = SizedBox(height: 1.5.h);

    return Scaffold(
      body: SafeArea(
        child: PaddedScreenWidget(
          child: Column(
            children: [
              const CustomAppBar(
                title: 'Checkout',
              ),
              sizedBox,
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const CustomIcon(
                            icon: 'pin',
                          ),
                          SizedBox(width: 3.w),
                          Text(
                            'Delivery Address',
                            style: customTextStyle,
                          ),
                        ],
                      ),
                      sizedBox2,
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 3.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 60.w,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Address:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 1.h),
                                    const Text(
                                      '216 St Paul\'s Rd, London N1 2LL, UK',
                                      maxLines: 1,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const Text('Contact : +44-784232'),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const CustomIcon(icon: 'edit'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      sizedBox,
                      Text(
                        'Shopping List',
                        style: customTextStyle,
                      ),
                      sizedBox2,
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 3.h),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      'https://firebasestorage.googleapis.com/v0/b/sole-capsule.appspot.com/o/sole-capsule.jpeg?alt=media&token=6ea04961-11d7-48a4-9bbd-a37924f6b27d',
                                      height: 20.h,
                                      width: 35.w,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 5.w),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      sizedBox2,
                                      Text(
                                        'Sole Capsule',
                                        style: customTextStyle,
                                      ),
                                      SizedBox(height: 1.h),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 5.w,
                                          vertical: 1.h,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black12,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: const Text(
                                          '\$ 34.00',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              sizedBox2,
                              const Divider(),
                              sizedBox2,
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Total Order (1) :'),
                                  Text(
                                    '\$34.00',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              sizedBox2,
              CustomButton(
                label: 'Checkout',
                onTap: () {},
              ),
              sizedBox,
            ],
          ),
        ),
      ),
    );
  }
}

class CustomIcon extends StatelessWidget {
  const CustomIcon({
    super.key,
    required this.icon,
  });

  final String icon;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/$icon.svg',
      height: 3.h,
      width: 3.w,
      // ignore: deprecated_member_use
      color: Colors.black,
    );
  }
}
