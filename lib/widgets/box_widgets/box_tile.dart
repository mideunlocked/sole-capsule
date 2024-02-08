import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class BoxTile extends StatefulWidget {
  const BoxTile({
    super.key,
  });

  @override
  State<BoxTile> createState() => _BoxTileState();
}

class _BoxTileState extends State<BoxTile> {
  bool _toggleBox = false;

  void toggleBox(bool newToggle) {
    setState(() {
      _toggleBox = newToggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/BoxScreen'),
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
                const Text('Box 1'),
                CupertinoSwitch(
                  value: _toggleBox,
                  activeColor: Colors.black,
                  onChanged: toggleBox,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
