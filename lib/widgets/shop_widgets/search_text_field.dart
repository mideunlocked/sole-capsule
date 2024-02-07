import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.searchController,
    required this.bodyMedium,
  });

  final TextEditingController searchController;
  final TextStyle? bodyMedium;

  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: Colors.black),
    );

    return TextField(
      controller: searchController,
      textInputAction: TextInputAction.search,
      style: bodyMedium,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: 'Search any product',
        hintStyle: bodyMedium?.copyWith(
          color: Colors.black26,
        ),
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        suffixIcon: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset('assets/icons/search.svg'),
        ),
      ),
    );
  }
}
