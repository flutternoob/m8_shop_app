import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:m8_shop_app/providers/cart.dart' show Cart;
import 'package:m8_shop_app/widgets/cart_item.dart';
import 'package:m8_shop_app/providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cart-screen";

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  Chip(
                    backgroundColor: Theme.of(context).primaryColor,
                    label: Text(
                      "\$${cart.totalAmount.toStringAsFixed(2)}",
                      style: TextStyle(
                          color:
                              Theme.of(context).textTheme.titleMedium!.color),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  OrderButton(cart: cart)
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (context, index) => CartItem(
                  cart.items.values.toList()[index].id,
                  cart.items.keys.toList()[index],
                  cart.items.values.toList()[index].title,
                  cart.items.values.toList()[index].quantity,
                  cart.items.values.toList()[index].price),
            ),
          )
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)? null: () async {
        setState(() {
          _isLoading = true;
        });
        await Provider.of<Orders>(context, listen: false).addOrder(
            widget.cart.items.values.toList(), widget.cart.totalAmount);
        setState(() {
          _isLoading = false;
        });
        widget.cart.clear();
      },
      style: TextButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
      child: _isLoading? const CircularProgressIndicator(): const Text(
        "Order Now",
      ),
    );
  }
}
