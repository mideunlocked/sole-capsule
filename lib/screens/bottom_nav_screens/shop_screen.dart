import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/general_widgets/padded_screen_widget.dart';
import '../../widgets/shop_widgets/search_actions.dart';
import '../../widgets/shop_widgets/search_text_field.dart';
import '../../widgets/shop_widgets/shop_grid_tile.dart';

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
                InkWell(
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/CartScreen',
                  ),
                  child: CircleAvatar(
                    maxRadius: 15.sp,
                    backgroundColor: const Color(0xFFD9D9D9),
                    child: SvgPicture.asset(
                      'assets/icons/cart.svg',
                      height: 3.h,
                      width: 3.w,
                    ),
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
                itemBuilder: (ctx, index) => const ShopGridTile(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
