import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../helpers/app_colors.dart';
import '../../provider/theme_mode_provider.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({
    super.key,
    this.onChanged,
  });

  final Function(String)? onChanged;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    var bodyMedium = textTheme.bodyMedium;

    return Consumer<ThemeModeProvider>(builder: (context, tmPvr, child) {
      bool isLightMode = tmPvr.isLight;

      var outlineInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: isLightMode ? Colors.black : Colors.white60,
        ),
      );

      return TextField(
        controller: searchController,
        textInputAction: TextInputAction.search,
        style: bodyMedium,
        cursorColor: isLightMode ? AppColors.secondary : Colors.white,
        decoration: InputDecoration(
          hintText: 'Search any product',
          hintStyle: bodyMedium?.copyWith(
            color: isLightMode ? Colors.black26 : Colors.white54,
          ),
          border: outlineInputBorder,
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          suffixIcon: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/search.svg',
              // ignore: deprecated_member_use
              color: isLightMode ? null : Colors.white,
            ),
          ),
        ),
        onChanged: widget.onChanged,
      );
    });
  }
}
