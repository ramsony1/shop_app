import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/widgets/app_drawer.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final ordersData = context.watch<Orders>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Orders',
        ),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: ordersData.orders.length,
        itemBuilder: (context, i) => OrderItem(
          ordersData.orders[i],
        ),
      ),
    );
  }
}
