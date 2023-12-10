import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:m8_shop_app/providers/cart.dart';

class CartItem extends StatelessWidget {
  final String? id;
  final String? productId;
  final double? price;
  final int? quantity;
  final String? title;

  const CartItem(this.id, this.productId, this.title, this.quantity, this.price,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        padding: const EdgeInsets.only(right: 20),
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId!);
      },
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text("Are you sure?"),
            content: Text("Do you want to remove the item from the cart?", style: Theme.of(context).textTheme.bodyMedium,),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text("Yes"),
              )
            ],
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
              leading: CircleAvatar(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: FittedBox(child: Text("\$$price")),
                ),
              ),
              title: Text(title!, style: Theme.of(context).textTheme.bodyMedium,),
              subtitle: Text(
                  "Total: \$${(price! * quantity!.toDouble()).toStringAsPrecision(5)}"),
              trailing: Text("$quantity x")),
        ),
      ),
    );
  }
}
