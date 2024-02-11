import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/box.dart';
import '../../provider/box_provider.dart';

class BoxTile extends StatelessWidget {
  const BoxTile({
    super.key,
    required this.box,
  });

  final Box box;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        '/BoxScreen',
        arguments: box,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFE4E4E4),
          ),
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xFFF9F9F9),
        ),
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/box.svg'),
            SizedBox(height: 3.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 15.w,
                  child: Text(
                    box.name,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Consumer<BoxProvider>(
                  builder: (context, boxPrv, child) {
                    return CupertinoSwitch(
                      value: box.isOpen,
                      activeColor: Colors.black,
                      onChanged: (_) => boxPrv.toggleBoxOpen(
                        id: box.id,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
