import 'package:flutter/material.dart';
import 'package:m8_shop_app/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import 'package:m8_shop_app/providers/orders.dart' show Orders;

import 'package:m8_shop_app/widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = "/orders-screen";

  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  //bool _isLoading = false;

  Future? _ordersFuture;

  Future _obtainOrdersFuture() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  @override
  void initState() {
    /*Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
      setState(() {
        _isLoading = false;
      });
    });*/
    _ordersFuture = _obtainOrdersFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final Orders ordersData = Provider.of<Orders>(context);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("Your Orders"),
      ),
      body: FutureBuilder(
        future: _ordersFuture,
          builder: (context, dataSnapshot){
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (dataSnapshot.error != null) {
            return const Center(
              child: Text("An error occurred"),
            );
          } else {
            return Consumer<Orders>(
              builder: (context, ordersData, child) {
                return ListView.builder(
                  itemCount: ordersData.orders.length,
                  itemBuilder: (ctx, index) => OrderItem(ordersData.orders[index]),
                );
              }
            );
          }
      }),
      /*body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: ordersData.orders.length,
              itemBuilder: (ctx, index) => OrderItem(ordersData.orders[index]),
            ),*/
    );
  }
}
