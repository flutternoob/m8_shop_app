import 'package:flutter/material.dart';
import 'package:m8_shop_app/helpers/custom_route.dart';
import 'package:provider/provider.dart';
import 'package:m8_shop_app/screens/edit_product_screen.dart';

import 'package:m8_shop_app/screens/orders_screen.dart';
import 'package:m8_shop_app/screens/user_products_screen.dart';
import 'package:m8_shop_app/providers/auth.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text("Hello Friend"),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text("Shop"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed("/");
            },
          ),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text("Orders"),
            onTap: () {
              //Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
              Navigator.of(context).pushReplacement(CustomRoute(builder: (context) => OrdersScreen(),),);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text("Manage Products"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Logout"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed("/");
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
          /*ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("Edit Product"),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),*/
        ],
      ),
    );
  }
}
