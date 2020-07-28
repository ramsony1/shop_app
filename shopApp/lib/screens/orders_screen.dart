import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

//   @override
//   _OrdersScreenState createState() => _OrdersScreenState();
// }

//class _OrdersScreenState extends State<OrdersScreen> {
  //var _isloading = false;

  // @override
  //void initState() {
  // Future.delayed(Duration.zero).then((_) async {
  //   setState(() {
  //     _isloading = true;
  //   });
  //   //you can use the provider without Future delay if listen is false
  //   await Provider.of<Orders>(context, listen: false).fetchAndOrders();
  //   setState(() {
  //     _isloading = false;
  //   });
  // });

  //Alternative

  //_isloading = true;

  //you can use the provider without Future delay if listen is false
  // Provider.of<Orders>(context, listen: false).fetchAndOrders().then((_) {
  //   setState(() {
  //     _isloading = false;
  //   });
  // });

  //super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    print('building orders');
    //final orderData = Provider.of<Orders>(context); to avoid infinity lood
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
        ),
        drawer: AppDrawer(),
        //Altenative to initState -> FutureBuilder()
        body: FutureBuilder(
          future: Provider.of<Orders>(context, listen: false).fetchAndOrders(),
          builder: (context, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (dataSnapshot.error != null) {
                return Center(
                  child: Text('An error occurred!'),
                ); //...Do handlimg error stuff
              } else {
                return Consumer<Orders>(
                  builder: (context, orderData, child) => ListView.builder(
                    itemCount: orderData.orders.length,
                    itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
                  ),
                );
              }
            }
          },
        ));
  }
}
