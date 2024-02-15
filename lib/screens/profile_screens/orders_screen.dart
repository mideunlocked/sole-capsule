import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sole_capsule/models/cart.dart';

import '../../widgets/general_widgets/custom_app_bar.dart';
import '../../widgets/general_widgets/padded_screen_widget.dart';
import '../../widgets/orders_widgets/order_tile.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/OrdersScreen';

  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int currentTab = 0;

  void toggleTab(int newTab) => setState(() => currentTab = newTab);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const PaddedScreenWidget(
              child: CustomAppBar(title: 'My Orders'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OrdersTabTile(
                  label: 'OPEN ORDERS',
                  tabIndex: 0,
                  currentIndex: currentTab,
                  toggleTab: toggleTab,
                ),
                OrdersTabTile(
                  label: 'CLOSED ORDERS',
                  tabIndex: 1,
                  currentIndex: currentTab,
                  toggleTab: toggleTab,
                ),
              ],
            ),
            Expanded(
              child: PaddedScreenWidget(
                child: ListView(
                  children: const [
                    OrderSecondaryTile(),
                    OrderSecondaryTile(),
                    OrderSecondaryTile(),
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

class OrderSecondaryTile extends StatelessWidget {
  const OrderSecondaryTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 4.w,
          vertical: 1.5.h,
        ),
        child: const OrderTile(
          cart: Cart(
            id: '',
            prodId: '',
            quantity: 0,
          ),
        ),
      ),
    );
  }
}

class OrdersTabTile extends StatelessWidget {
  const OrdersTabTile({
    super.key,
    required this.label,
    required this.tabIndex,
    required this.currentIndex,
    required this.toggleTab,
  });

  final String label;
  final int tabIndex;
  final int currentIndex;
  final Function(int) toggleTab;

  @override
  Widget build(BuildContext context) {
    bool isCurrent = tabIndex == currentIndex;
    Color color = isCurrent ? Colors.black : Colors.black26;

    return InkWell(
      onTap: () {
        toggleTab(tabIndex);
      },
      child: Container(
        width: 50.w,
        height: 8.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: BorderDirectional(
            bottom: BorderSide(
              color: color,
              width: isCurrent ? 2 : 1,
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: isCurrent ? FontWeight.w500 : null,
            color: color,
          ),
        ),
      ),
    );
  }
}
