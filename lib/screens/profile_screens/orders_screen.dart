import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/app_colors.dart';
import '../../models/order.dart';
import '../../provider/order_provider.dart';
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
  void initState() {
    Future.delayed(
        Duration.zero,
        () => getOrders(
              isInitial: true,
            ));

    super.initState();
  }

  List<Orders> orders = [];

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => getOrders(),
        color: AppColors.secondary,
        child: ScaffoldMessenger(
          key: _scaffoldKey,
          child: SafeArea(
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
                          ? orders
                              .where((order) => order.status == 'Pending')
                              .map((e) => OrderSecondaryTile(order: e))
                              .toList()
                          : orders
                              .where((order) => order.status == 'Closed')
                              .map((e) => OrderSecondaryTile(order: e))
                              .toList(),
                    ),
                  ),
                ),
                Consumer<OrderProvider>(builder: (context, orderPvr, child) {
                  return Visibility(
                    visible: orderPvr.isLoading,
                    child: const LinearProgressIndicator(
                      backgroundColor: Color(0xFF14191D),
                      color: Colors.white54,
                      // minHeight: 1,
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getOrders({
    bool isInitial = false,
  }) async {
    var orderPvr = Provider.of<OrderProvider>(context, listen: false);

    await orderPvr.getOrders(scaffoldKey: _scaffoldKey);

    setState(() {
      orders = orderPvr.orders;
    });
  }
}
