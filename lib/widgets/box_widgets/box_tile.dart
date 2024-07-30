import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/box.dart';
import '../../provider/ble_provider.dart';
import '../../provider/box_provider.dart';
import '../../provider/theme_mode_provider.dart';
import '../../services/remove_bg.dart';

class BoxTile extends StatelessWidget {
  const BoxTile({
    super.key,
    required this.box,
    required this.scaffoldKey,
  });

  final Box box;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    var tmPvr = Provider.of<ThemeModeProvider>(context, listen: false);
    bool isLightMode = tmPvr.isLight;
    var borderRadius = BorderRadius.circular(20);

    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        '/BoxScreen',
        arguments: box,
      ),
      onLongPress: () => pickPodImage(context),
      borderRadius: borderRadius,
      child: Consumer<BleProvider>(builder: (context, blePvr, child) {
        return Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              decoration: BoxDecoration(
                border: isLightMode
                    ? Border.all(
                        color: const Color(0xFFE4E4E4),
                      )
                    : null,
                borderRadius: borderRadius,
                color: isLightMode
                    ? const Color(0xFFF9F9F9)
                    : const Color(0xFF14191D),
              ),
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: box.id,
                    child: box.imagePath.isNotEmpty
                        ? Image.file(
                            File(box.imagePath),
                            height: 10.h,
                            width: 30.w,
                            fit: BoxFit.cover,
                          )
                        : SvgPicture.asset(
                            isLightMode
                                ? 'assets/images/box.svg'
                                : 'assets/images/box2.svg',
                          ),
                  ),
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
                          style: box.fontFamily.isEmpty
                              ? null
                              : GoogleFonts.getFont(box.fontFamily),
                        ),
                      ),
                      Consumer<BoxProvider>(
                        builder: (context, boxPrv, child) {
                          return CupertinoSwitch(
                            value: box.isOpen,
                            activeColor:
                                isLightMode ? Colors.black : Colors.white,
                            thumbColor:
                                isLightMode ? Colors.white : Colors.black,
                            trackColor: isLightMode ? null : Colors.grey,
                            onChanged: (_) => boxPrv.toggleBoxOpen(
                              id: box.id,
                              context: context,
                              scaffoldKey: scaffoldKey,
                              status: box.isOpen ? 0 : 1,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Visibility(
              visible: box.isConnected,
              child: Positioned(
                top: 2.h,
                right: 4.w,
                child: const Icon(
                  Icons.bluetooth_connected_rounded,
                  color: Colors.blue,
                ),
              ),
            ),
            Visibility(
              visible: box.isLightOn == true,
              replacement: const SizedBox.expand(),
              child: Container(
                height: 100.h,
                width: 100.w,
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: const [0.0, 0.3],
                    colors: [
                      isLightMode ? Colors.amber : Colors.amber.shade100,
                      isLightMode
                          ? const Color(0xFFF9F9F9).withOpacity(0.1)
                          : Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  void pickPodImage(BuildContext context) async {
    var boxPvr = Provider.of<BoxProvider>(context, listen: false);

    File file = File('');
    XFile? pickedImage;

    pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      file = File(pickedImage.path);
    }

    File fileRemoveBg = await RemoveBackground.getSavedFilePath(file);

    await boxPvr.updatePodImage(
      imagePath: fileRemoveBg.path,
      id: box.id,
    );
  }
}
