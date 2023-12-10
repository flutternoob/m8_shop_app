import 'package:flutter/material.dart';
import 'package:m8_shop_app/helpers/custom_route.dart';
import 'package:m8_shop_app/providers/auth.dart';
import 'package:m8_shop_app/providers/cart.dart';
import 'package:m8_shop_app/providers/orders.dart';
import 'package:m8_shop_app/screens/cart_screen.dart';
import 'package:m8_shop_app/screens/splash_screen.dart';

import 'package:provider/provider.dart';

import 'package:m8_shop_app/screens/products_overview_screen.dart';
import 'package:m8_shop_app/screens/product_detail_screen.dart';
import 'package:m8_shop_app/screens/orders_screen.dart';
import 'package:m8_shop_app/screens/user_products_screen.dart';
import 'package:m8_shop_app/screens/edit_product_screen.dart';
import 'package:m8_shop_app/screens/auth_screen.dart';
import 'package:m8_shop_app/providers/products.dart';
import 'package:m8_shop_app/providers/product.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (context) => Products(),
          update: (context, auth, previousProducts) => Products(
              (auth.token == null ? "" : auth.token as String),
              auth.userId,
              previousProducts == null ? [] : previousProducts.items),
        ),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (context) => Orders(),
          update: (context, auth, previousOrder) => Orders(auth.token as String,
              auth.userId, previousOrder == null ? [] : previousOrder.orders),
        ),
      ],
      child: Consumer<Auth>(builder: (context, auth, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            hintColor: Colors.deepOrange,
            fontFamily: "Lato",
            textTheme: const TextTheme(
              titleMedium: TextStyle(color: Colors.black),
              titleSmall: TextStyle(color: Colors.black),
              bodyMedium: TextStyle(color: Colors.black),
            ),
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.android: CustomPageTransitionBuilder(),
              TargetPlatform.iOS: CustomPageTransitionBuilder()
            }),
          ),
          home: auth.isAuth == true
              ? const ProductsOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (context, authResultSnapshot) {
                    if (authResultSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return SplashScreen();
                    }
                    return AuthScreen();
                  }),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(Product(
                id: "", title: "", description: "", price: 0, imageUrl: ""))
          },
        );
      }),
    );
  }
}
