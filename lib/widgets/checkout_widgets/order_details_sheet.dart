import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/scaffold_messenger_helper.dart';
import '../../provider/cart_provider.dart';
import '../../provider/user_provider.dart';
import '../general_widgets/custom_button.dart';
import '../general_widgets/custom_icon_button.dart';
import '../general_widgets/padded_screen_widget.dart';
import 'discount_text_field.dart';
import 'order_details_tile.dart';

void showOrderDetailsSheet({
  required BuildContext context,
  required GlobalKey<ScaffoldMessengerState> scaffoldKey,
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
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (ctx) => OrderDetailsSheet(
        scaffoldKey: scaffoldKey,
      ),
    );
  }
}

class OrderDetailsSheet extends StatefulWidget {
  const OrderDetailsSheet({
    super.key,
    required this.scaffoldKey,
  });

  final GlobalKey<ScaffoldMessengerState> scaffoldKey;

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

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 2.h);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: PaddedScreenWidget(
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
              return OrderDetailsTile(
                title: 'Order Amounts',
                value: '\$${cartPvr.totalCartPrice}',
              );
            }),
            const OrderDetailsTile(
              title: 'Delivery Fee',
              value: 'Free',
            ),
            SizedBox(height: 2.h),
            DiscountTextField(controller: discountCodeCtr),
            SizedBox(height: 5.h),
            CustomButton(
              onTap: purchaseCart,
              label: 'Proceed to payment',
            ),
            sizedBox,
            Text(
              'OR pay with',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.black38,
                  ),
            ),
            sizedBox,
            CustomButton(
              onTap: purchaseCart,
              customWidget: SvgPicture.asset('assets/icons/gpay.svg'),
            ),
            sizedBox,
            CustomButton(
              onTap: purchaseCart,
              customWidget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Pay with ',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SvgPicture.asset('assets/icons/apple_pay.svg'),
                ],
              ),
            ),
            sizedBox,
          ],
        ),
      ),
    );
  }

  void purchaseCart() async {
    var cartPvr = Provider.of<CartProvider>(context, listen: false);

    Future.delayed(
        Duration.zero,
        () async =>
            await cartPvr.purchaseCartItems(scaffoldKey: widget.scaffoldKey));
  }
}
