import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sole_capsule/helpers/calculate_discount.dart';

import '../../models/product.dart';
import '../../widgets/general_widgets/custom_app_bar.dart';
import '../../widgets/general_widgets/custom_button.dart';
import '../../widgets/general_widgets/padded_screen_widget.dart';

class ProductScreen extends StatefulWidget {
  static const routeName = '/ProductScreen';

  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int currentImage = 0;
  String currentImageUrl = '';
  int currentColor = 0;

  final pgCtr = PageController();

  @override
  void dispose() {
    super.dispose();

    pgCtr.dispose();
  }

  void scrollImage(int newImage) {
    setState(() {
      currentImage = newImage;
    });
  }

  void setCurrentImage(String newImageUrl) {
    currentImageUrl = newImageUrl;
  }

  void setCurrentColor(int newColor) {
    setState(() {
      currentColor = newColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    Product prod = ModalRoute.of(context)!.settings.arguments as Product;

    var sizedBox = SizedBox(height: 2.h);

    var textTheme = Theme.of(context).textTheme;

    var labelStyle = textTheme.labelMedium?.copyWith(
      fontSize: 13.sp,
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 0.5.h),
            const PaddedScreenWidget(
              child: CustomAppBar(
                title: '',
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 3.h),
                      SizedBox(
                        height: 28.h,
                        width: 100.w,
                        child: PageView.builder(
                          controller: pgCtr,
                          itemCount: prod.productImages.length,
                          physics: const BouncingScrollPhysics(),
                          onPageChanged: scrollImage,
                          itemBuilder: (ctx, index) {
                            String image = prod.productImages[index].toString();
                            setCurrentImage(image);

                            return ProdImageTile(
                              image: image,
                              pgCtr: pgCtr,
                              prod: prod,
                              index: index,
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: prod.productImages.map((e) {
                          bool isCurrent =
                              e.toString().contains(currentImageUrl);

                          return ImageIndicator(
                            isCurrent: isCurrent,
                          );
                        }).toList(),
                      ),
                      sizedBox,
                      PaddedScreenWidget(
                        child: SizedBox(
                          height: 5.h,
                          width: 100.w,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: prod.colors.length,
                            itemBuilder: (ctx, index) {
                              int color = prod.colors[index];
                              bool isCurrent = color == currentColor;

                              return IconButton(
                                onPressed: () {
                                  setCurrentColor(color);
                                },
                                icon: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: isCurrent
                                        ? Border.all(
                                            color: Colors.black45,
                                            width: 1,
                                          )
                                        : null,
                                    color: Colors.grey.shade200,
                                  ),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.circle_rounded,
                                    size: 20.sp,
                                    color: Color(color),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      sizedBox,
                      PaddedScreenWidget(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              prod.name,
                              style: textTheme.titleSmall?.copyWith(
                                fontSize: 19.sp,
                              ),
                            ),
                            Text(
                              prod.description,
                              style: textTheme.bodyMedium?.copyWith(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            sizedBox,
                            Row(
                              children: [
                                Text(
                                  '\$${prod.price}',
                                  style: labelStyle?.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.black38,
                                  ),
                                ),
                                Text(
                                  ' \$${CalculateDiscount.calculateDiscount(
                                    prod.price,
                                    prod.discount ?? 0,
                                  )} ',
                                  style: labelStyle,
                                ),
                                Text(
                                  ' ${prod.discount}% Off',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                  ),
                                )
                              ],
                            ),
                            sizedBox,
                            Text(
                              'Product Details',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              prod.productDetails,
                              style: TextStyle(
                                fontSize: 10.sp,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            CustomButton(
                              color: const Color(0xFFDBDBDB),
                              label: 'Add to cart',
                              onTap: () {},
                            ),
                            sizedBox,
                            CustomButton(
                              onTap: () {},
                              label: 'Buy Now',
                            ),
                            sizedBox,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageIndicator extends StatelessWidget {
  const ImageIndicator({
    super.key,
    required this.isCurrent,
  });

  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.5.w),
      child: Icon(
        Icons.circle_rounded,
        color: isCurrent ? Colors.black : Colors.grey,
        size: isCurrent ? 10.sp : 6.sp,
      ),
    );
  }
}

class ProdImageTile extends StatelessWidget {
  const ProdImageTile({
    super.key,
    required this.image,
    required this.pgCtr,
    required this.prod,
    required this.index,
  });

  final String image;
  final PageController pgCtr;
  final Product prod;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              image,
              fit: BoxFit.cover,
              height: 28.h,
              width: 100.w,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProdImageViewHandler(
                  icon: Icons.arrow_circle_left_rounded,
                  onTap: () {
                    pgCtr.previousPage(
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeOut,
                    );
                  },
                  visible: index != 0,
                ),
                ProdImageViewHandler(
                  icon: Icons.arrow_circle_right_rounded,
                  onTap: () {
                    pgCtr.nextPage(
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeIn,
                    );
                  },
                  visible: index != prod.productImages.length - 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProdImageViewHandler extends StatelessWidget {
  const ProdImageViewHandler({
    super.key,
    required this.icon,
    this.onTap,
    required this.visible,
  });

  final bool visible;
  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: IconButton(
        onPressed: onTap,
        icon: Icon(
          icon,
          color: Colors.grey.shade300,
        ),
      ),
    );
  }
}
