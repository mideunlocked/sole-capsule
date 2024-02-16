import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../models/product.dart';
import '../../provider/cart_provider.dart';
import '../../provider/product_provider.dart';
import '../../widgets/general_widgets/padded_screen_widget.dart';
import '../../widgets/shop_widgets/search_actions.dart';
import '../../widgets/shop_widgets/search_text_field.dart';
import '../../widgets/shop_widgets/shop_grid_tile.dart';
import '../../widgets/shop_widgets/shop_screen_app_bar.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  bool isInitial = false;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();

    getDatas();
  }

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    var bodyLarge = textTheme.bodyLarge;

    var sizedBox = SizedBox(height: 3.h);

    return SafeArea(
      child: PaddedScreenWidget(
        child: RefreshIndicator(
          onRefresh: () async => getDatas(),
          color: Colors.black,
          backgroundColor: Colors.grey.shade200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),
              const ShoppingScreenAppBar(),
              sizedBox,
              SearchTextField(
                onChanged: searchProducts,
              ),
              sizedBox,
              Row(
                children: [
                  Consumer<ProductProvider>(builder: (context, productPvr, _) {
                    return Text(
                      '${productPvr.productCount} Item(s)',
                      style: bodyLarge,
                    );
                  }),
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
                child: Consumer<ProductProvider>(
                  builder: (context, productPvr, child) =>
                      productPvr.products.isEmpty
                          ? child!
                          : GridView(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 3.h,
                                crossAxisSpacing: 5.w,
                                childAspectRatio: 0.4,
                              ),
                              children: productPvr.products.where((e) {
                                if (e.name.toLowerCase().contains(
                                      searchQuery.toLowerCase(),
                                    )) {
                                  return true;
                                }
                                return false;
                              }).map(
                                (Product product) {
                                  return ShopGridTile(
                                    product: product,
                                  );
                                },
                              ).toList(),
                            ),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 3.h,
                      crossAxisSpacing: 5.w,
                      childAspectRatio: 0.4,
                    ),
                    itemCount: 10,
                    itemBuilder: (_, i) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade100,
                      highlightColor: Colors.grey.shade50,
                      child: Container(
                        height: 100.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
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

  void searchProducts(String query) => setState(() => searchQuery = query);

  void getDatas() async {
    var productPvr = Provider.of<ProductProvider>(context, listen: false);
    var cartPvr = Provider.of<CartProvider>(context, listen: false);

    await productPvr.getProducts(
      scaffoldKey: _scaffoldKey,
    );

    if (!isInitial) {
      await cartPvr.getCartItems(
        scaffoldKey: _scaffoldKey,
      );
    }

    isInitial = true;
  }
}
