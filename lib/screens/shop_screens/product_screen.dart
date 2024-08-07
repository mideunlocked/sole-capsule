// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../../helpers/calculate_discount.dart';
import '../../models/cart.dart';
import '../../models/product.dart';
import '../../provider/cart_provider.dart';
import '../../provider/theme_mode_provider.dart';
import '../../widgets/checkout_widgets/order_details_sheet.dart';
import '../../widgets/general_widgets/custom_app_bar.dart';
import '../../widgets/general_widgets/custom_button.dart';
import '../../widgets/general_widgets/padded_screen_widget.dart';
import '../../widgets/orders_widgets/order_tile.dart';
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

  int quantity = 1;

  final pgCtr = PageController();

  @override
  void dispose() {
    super.dispose();

    pgCtr.dispose();
    _controller.dispose();
  }

  void scrollImage(int newImage) => setState(() => currentImage = newImage);

  void setCurrentImage(String newImageUrl) => currentImageUrl = newImageUrl;

  void setCurrentColor(int newColor) => setState(() => currentColor = newColor);

  void increaseQuantity() => setState(() => quantity++);
  void decreaseQuantity() => setState(() => quantity > 1 ? quantity-- : null);

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, initVideoPlayer);
  }

  void initVideoPlayer() async {
    String videoUrl = '';
    Product prod = ModalRoute.of(context)!.settings.arguments as Product;
    setState(() {
      videoUrl = prod.productImages[1];
    });

    _controller = VideoPlayerController.networkUrl(
      Uri.parse(videoUrl),
    );

    await _controller.initialize().then((_) {
      setState(() {});
      _controller.play();
      _controller.setLooping(true);
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
      body: ScaffoldMessenger(
        key: _scaffoldKey,
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
                          if (index == 1) {
                            return InkWell(
                              onTap: () {
                                if (_controller.value.isPlaying) {
                                  _controller.pause();
                                  return;
                                }
                                _controller.play();
                              },
                              child: AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: VideoPlayer(_controller),
                              ),
                            );
                          }

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
                        bool isCurrent = e.toString().contains(currentImageUrl);

                        return ImageIndicator(
                          isCurrent: isCurrent,
                        );
                      }).toList(),
                    ),
                    sizedBox,
                    sizedBox,
                    PaddedScreenWidget(
                      child: Row(
                        children: [
                          SizedBox(
                            height: 5.h,
                            width: 50.w,
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
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              QuantityButton(
                                icon: Icons.remove_rounded,
                                onTap: decreaseQuantity,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
                                child: Text(quantity.toString()),
                              ),
                              QuantityButton(
                                icon: Icons.add_rounded,
                                onTap: increaseQuantity,
                              ),
                            ],
                          ),
                        ],
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
                              Consumer<ThemeModeProvider>(
                                builder: (context, tmPvr, child) {
                                  bool isLightMode = tmPvr.isLight;

                                  return Text(
                                    '\$${prod.price}',
                                    style: labelStyle?.copyWith(
                                      decoration: TextDecoration.lineThrough,
                                      color: isLightMode
                                          ? Colors.black38
                                          : Colors.white38,
                                    ),
                                  );
                                },
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
                              label:
                                  checkCart ? 'Added to cart' : 'Add to cart',
                              onTap: () async => checkCart
                                  ? cartPvr.notifyAlreadyInCart(
                                      scaffoldKey: _scaffoldKey,
                                      context: context,
                                    )
                                  : await cartPvr.addToCart(
                                      scaffoldKey: _scaffoldKey,
                                      context: context,
                                      cart: Cart(
                                        id: (cartPvr.cartItems.length - 1)
                                            .toString(),
                                        color: currentColor,
                                        prodId: prod.id,
                                        quantity: quantity,
                                      ),
                                    ),
                            );
                          }),
                          sizedBox,
                          Consumer<CartProvider>(
                              builder: (context, cartPvr, _) {
                            cartPvr.putDirectCart(
                              cart: Cart(
                                id: (cartPvr.cartItems.length - 1).toString(),
                                color: currentColor,
                                prodId: prod.id,
                                quantity: quantity,
                              ),
                            );

                            return CustomButton(
                              onTap: () => showOrderDetailsSheet(
                                context: context,
                                scaffoldKey: _scaffoldKey,
                                directBuy: true,
                              ),
                              label: 'Buy Now',
                            );
                          }),
                          sizedBox,
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
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
