import 'package:flutter/material.dart';

import '../../models/order.dart';
import '../../widgets/general_widgets/custom_app_bar.dart';
import '../../widgets/general_widgets/padded_screen_widget.dart';
import '../../widgets/orders_widgets/order_secondary_tile.dart';
import '../../widgets/orders_widgets/orders_tab_tile.dart';

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
                  children: currentTab == 0
                      ? const [
                          OrderSecondaryTile(
                            order: Orders(
                              id: '0',
                              status: 'Pending',
                              prodId: '6WeMiMBHkZ1Q7cRP18nV',
                              price: 105,
                              color: 4294967295,
                              quantity: 2,
                              paymentMethod: '',
                            ),
                          ),
                        ]
                      : const [
                          OrderSecondaryTile(
                            order: Orders(
                              id: '0',
                              status: 'Closed',
                              prodId: '6WeMiMBHkZ1Q7cRP18nV',
                              price: 99,
                              color: 4294967295,
                              quantity: 1,
                              paymentMethod: '',
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
