import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/delivery_details.dart';
import '../../provider/theme_mode_provider.dart';
import '../../provider/user_provider.dart';
import '../general_widgets/custom_icon.dart';

class DeliveryPreviewCard extends StatelessWidget {
  const DeliveryPreviewCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeProvider>(
      builder: (context, tmPvr, child) {
        bool isLightMode = tmPvr.isLight;

        return Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: isLightMode ? null : Colors.white10,
          child: child!,
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
        child: Consumer<UserProvider>(builder: (context, userPvr, _) {
          DeliveryDetails details = userPvr.user.deliveryDetails;

          String shortAddress =
              '${details.address}, ${details.state}, ${details.country}';

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: 60.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Address:',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      shortAddress,
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text('Contact : ${details.number}'),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pushNamed(
                  context,
                  '/CheckOutDetailsScreen',
                ),
                icon: const CustomIcon(icon: 'edit'),
              ),
            ],
          );
        }),
      ),
    );
  }
}
