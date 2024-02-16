import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      onChanged: widget.onChanged,
    );
  }
}
