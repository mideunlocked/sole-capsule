import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../models/order.dart';
import '../../models/product.dart';
import '../general_widgets/custom_shimmer.dart';
import '../general_widgets/product_image.dart';

class OrderSecondaryTile extends StatelessWidget {
  const OrderSecondaryTile({
    super.key,
    required this.order,
  });

  final Orders order;

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 1.5.h);

    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var customTextStyle = textTheme.bodyMedium?.copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
    );
    var statusStyle = TextStyle(
      fontSize: 12.5.sp,
    );

    var edgeInsets = EdgeInsets.symmetric(vertical: 1.h);

    return FutureBuilder(
      future: order.getOrderProduct(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const SizedBox();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: edgeInsets,
            child: CustomShimmer(
              height: 30.h,
              width: 100.w,
            ),
          );
        }
        if (snapshot.hasError) {
          return const SizedBox();
        }

        Product prod = snapshot.data!;

        return Padding(
          padding: edgeInsets,
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 4.w,
                vertical: 1.5.h,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProductImage(
                          imageUrl: prod.productImages.last,
                          height: 20.h,
                          width: 35.w,
                        ),
                        SizedBox(width: 5.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sizedBox,
                            Text(
                              prod.name,
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
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                '\$ ${order.calculateTotalPrice()}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            sizedBox,
                            Text(
                              'Color: White',
                              style: customTextStyle,
                            ),
                            sizedBox,
                            order.paymentMethod.contains('G')
                                ? SvgPicture.asset(
                                    'assets/icons/gpay_solid.svg')
                                : SvgPicture.asset(
                                    'assets/icons/apple_pay.svg',
                                    colorFilter: const ColorFilter.mode(
                                      Colors.black,
                                      BlendMode.modulate,
                                    ),
                                  ),
                          ],
                        ),
                      ],
                    ),
                    sizedBox,
                    const Divider(),
                    sizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Status:',
                          style: statusStyle,
                        ),
                        Text(
                          order.status,
                          style: statusStyle.copyWith(
                            color: statusColor(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Color statusColor() {
    if (order.status == 'Pending') {
      return Colors.orange;
    } else if (order.status == 'Shipped') {
      return Colors.red;
    }
    return Colors.green;
  }
}
