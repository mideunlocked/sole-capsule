import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:sole_capsule/helpers/calculate_discount.dart';
import 'package:sole_capsule/models/cart.dart';

import '../../models/product.dart';
import '../../provider/cart_provider.dart';
import '../../widgets/general_widgets/custom_app_bar.dart';
import '../../widgets/general_widgets/custom_button.dart';
import '../../widgets/general_widgets/padded_screen_widget.dart';
import '../../widgets/product_widgets/image_indicator.dart';
import '../../widgets/product_widgets/product_image_tile.dart';

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

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    Product prod = ModalRoute.of(context)!.settings.arguments as Product;

    var sizedBox = SizedBox(height: 2.h);

    var textTheme = Theme.of(context).textTheme;

    var labelStyle = textTheme.labelMedium?.copyWith(
      fontSize: 13.sp,
    );

    return Scaffold(
      body: ScaffoldMessenger(
        key: _scaffoldKey,
        child: SafeArea(
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
                              String image =
                                  prod.productImages[index].toString();
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
                              Consumer<CartProvider>(
                                  builder: (context, cartPvr, _) {
                                bool checkCart =
                                    cartPvr.alreadyInCart(prodId: prod.id);

                                return CustomButton(
                                  isLoading: cartPvr.isLoading,
                                  color: const Color(0xFFDBDBDB),
                                  icon: checkCart ? Icons.check_rounded : null,
                                  label: checkCart
                                      ? 'Added to cart'
                                      : 'Add to cart',
                                  onTap: () async => checkCart
                                      ? cartPvr.notifyAlreadyInCart(
                                          scaffoldKey: _scaffoldKey)
                                      : await cartPvr.addToCart(
                                          scaffoldKey: _scaffoldKey,
                                          cart: Cart(
                                            id: (cartPvr.cartItems.length - 1)
                                                .toString(),
                                            color: currentColor,
                                            prodId: prod.id,
                                            quantity: 1,
                                          ),
                                        ),
                                );
                              }),
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
      ),
    );
  }
}
