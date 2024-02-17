import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../general_widgets/custom_shimmer.dart';

class ShopShimmerGridView extends StatelessWidget {
  const ShopShimmerGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 3.h,
        crossAxisSpacing: 5.w,
        childAspectRatio: 0.4,
      ),
      itemCount: 10,
      itemBuilder: (_, i) => CustomShimmer(
        height: 100.h,
        width: 100.w,
      ),
    );
  }
}
