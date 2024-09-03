import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/fonts_helper.dart';
import '../../provider/theme_mode_provider.dart';
import '../general_widgets/padded_screen_widget.dart';

class FontsDisplaySheet extends StatelessWidget {
  const FontsDisplaySheet({
    super.key,
    required this.name,
    required this.getFont,
    required this.fontFamily,
  });

  final String name;
  final String fontFamily;
  final Function(String) getFont;

  @override
  Widget build(BuildContext context) {
    var tmPvr = Provider.of<ThemeModeProvider>(context, listen: false);
    bool isLight = tmPvr.isLight;
    Color textColor = isLight ? Colors.black : Colors.white;

    return SizedBox.expand(
      child: PaddedScreenWidget(
        padTop: false,
        child: Column(
          children: [
            SizedBox(height: 2.h),
            Text(
              'Choose Font',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 1.h),
            const Divider(),
            Expanded(
              child: ListView(
                children: FontsHelper.titleFonts
                    .map(
                      (e) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: InkWell(
                          onTap: () {
                            getFont(e);
                            Navigator.pop(context);
                          },
                          child: Text(
                            name.isEmpty ? 'Pod name' : name,
                            style: GoogleFonts.getFont(
                              e,
                              color: fontFamily.isEmpty
                                  ? textColor
                                  : fontFamily == e
                                      ? textColor
                                      : textColor.withOpacity(0.3),
                              fontSize: fontFamily == e ? 17.sp : 14.sp,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
