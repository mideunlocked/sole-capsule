import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/scaffold_messenger_helper.dart';
import '../../provider/cart_provider.dart';
import '../../provider/discount_provider.dart';
import '../../provider/theme_mode_provider.dart';
import '../../provider/user_provider.dart';
import '../general_widgets/custom_button.dart';
import '../general_widgets/custom_icon_button.dart';
import '../general_widgets/padded_screen_widget.dart';
import 'discount_text_field.dart';
import 'order_details_tile.dart';

void showOrderDetailsSheet({
  required BuildContext context,
  required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  bool directBuy = false,
}) {
  var userPvr = Provider.of<UserProvider>(context, listen: false);

  bool writtenDetails = userPvr.user.deliveryDetails.address.isEmpty;

  if (writtenDetails) {
    showScaffoldMessenger(
      scaffoldKey: scaffoldKey,
      textContent:
          'Delivery address not added, kindly fill delivery address to purchase',
      bkgColor: Colors.grey,
      snackBarAction: SnackBarAction(
        label: 'Go to',
        textColor: Colors.red,
        onPressed: () => Navigator.pushNamed(
          context,
          '/CheckOutDetailsScreen',
        ),
      ),
    );
  } else {
    var tmPvr = Provider.of<ThemeModeProvider>(context, listen: false);

    bool isLightMode = tmPvr.isLight;

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: isLightMode ? Colors.white : const Color(0xFF21272C),
      isScrollControlled: true,
      builder: (ctx) => OrderDetailsSheet(
        scaffoldKey: scaffoldKey,
        directBuy: directBuy,
      ),
    );
  }
}

class OrderDetailsSheet extends StatefulWidget {
  const OrderDetailsSheet({
    super.key,
    required this.scaffoldKey,
    required this.directBuy,
  });

  final GlobalKey<ScaffoldMessengerState> scaffoldKey;
  final bool directBuy;

  @override
  State<OrderDetailsSheet> createState() => _OrderDetailsSheetState();
}

class _OrderDetailsSheetState extends State<OrderDetailsSheet> {
  final discountCodeCtr = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    discountCodeCtr.dispose();
  }

  String currency = 'USD';
  List<String> currencies = [
    'USD',
    'EUR',
    'CAD',
    'GBP',
  ];

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 2.h);
    bool isLight =
        Provider.of<ThemeModeProvider>(context, listen: false).isLight;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: PaddedScreenWidget(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              sizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order Payment Details',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  CustomIconButton(
                    icon: 'close',
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
              sizedBox,
              Consumer<CartProvider>(builder: (context, cartPvr, _) {
                double? price = widget.directBuy
                    ? cartPvr.directCart.totalCartPrice()
                    : cartPvr.totalCartPrice;

                return Consumer<DiscountProvider>(
                    builder: (context, discountPvr, _) {
                  return OrderDetailsTile(
                    title: 'Order Amount',
                    value: '\$$price',
                    subValue:
                        '  \$${discountPvr.discount?.calculateDiscountPrice(price: price.toString())}',
                  );
                });
              }),
              const OrderDetailsTile(
                title: 'Delivery Fee',
                value: 'Free',
              ),
              SizedBox(height: 2.h),
              DiscountTextField(controller: discountCodeCtr),
              SizedBox(height: 2.h),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: const Color(0xFFB7B7B7),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 0.8.h, horizontal: 3.w),
                child: DropdownButton(
                  dropdownColor: !isLight ? const Color(0xFF14191D) : null,
                  value: currency,
                  items: currencies
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => setState(() => currency = value ?? ''),
                  isExpanded: true,
                  underline: const SizedBox.shrink(),
                ),
              ),
              SizedBox(height: 5.h),
              Consumer<CartProvider>(builder: (context, cartPvr, _) {
                return CustomButton(
                  onTap: () => purchaseCart(paymentMethod: 'Cash In'),
                  label: 'Proceed to payment',
                  isLoading: cartPvr.isLoading,
                );
              }),
              sizedBox,
            ],
          ),
        ),
      ),
    );
  }

  void purchaseCart({
    required String paymentMethod,
  }) async {
    var cartPvr = Provider.of<CartProvider>(context, listen: false);

    if (!widget.directBuy) {
      await cartPvr.purchaseCartItems(
        scaffoldKey: widget.scaffoldKey,
        paymentMethod: paymentMethod,
        currency: currency,
      );
    } else {
      await cartPvr.purchaseDirectCart(
        scaffoldKey: widget.scaffoldKey,
        paymentMethod: paymentMethod,
        currency: currency,
      );
    }
  }
}
