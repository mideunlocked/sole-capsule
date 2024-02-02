import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/general_widgets/padded_screen_widget.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
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
    var bodyLarge = textTheme.bodyLarge;

    var sizedBox = SizedBox(height: 3.h);
    return SafeArea(
      child: PaddedScreenWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Shop',
                  style: bodyLarge,
                ),
                CircleAvatar(
                  maxRadius: 15.sp,
                  backgroundColor: const Color(0xFFD9D9D9),
                  child: SvgPicture.asset(
                    'assets/icons/cart.svg',
                    height: 3.h,
                    width: 3.w,
                  ),
                ),
              ],
            ),
            sizedBox,
            SearchTextField(
              searchController: searchController,
              bodyMedium: bodyMedium,
            ),
            sizedBox,
            Row(
              children: [
                Text(
                  '52,082+ Items',
                  style: bodyLarge,
                ),
                const Spacer(),
                SearchActions(
                  label: 'Sort',
                  icon: 'top_bottom',
                  onTap: () {},
                ),
                SizedBox(width: 5.w),
                SearchActions(
                  label: 'Filter',
                  icon: 'filter',
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(height: 3.h),
            Expanded(
              child: GridView.builder(
                // itemCount: 2,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 3.h,
                  crossAxisSpacing: 5.w,
                  childAspectRatio: 0.4,
                ),
                itemBuilder: (ctx, index) => Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      width: 100.w,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        vertical: 2.h,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sole Capsule',
                            style: bodyLarge?.copyWith(fontSize: 15.sp),
                          ),
                          SizedBox(height: 1.h),
                          const Text(
                            'Autumn And Winter Casual cotton-padded jacket',
                          ),
                          SizedBox(height: 1.h),
                          const Text(
                            '₹499',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/sole-capsule.appspot.com/o/sole-capsule.jpeg?alt=media&token=6ea04961-11d7-48a4-9bbd-a37924f6b27d',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchActions extends StatelessWidget {
  const SearchActions({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final String icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Row(
        children: [
          Text(label),
          SizedBox(width: 1.h),
          SvgPicture.asset('assets/icons/$icon.svg'),
        ],
      ),
    );
  }
}

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
