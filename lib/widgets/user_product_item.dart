import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:m8_shop_app/screens/edit_product_screen.dart';
import 'package:m8_shop_app/providers/products.dart';
import 'package:m8_shop_app/providers/product.dart';

class UserProductItem extends StatelessWidget {
  final String? id;
  final String? title;
  final String? imageUrl;
  final String? description;
  final double? price;

  const UserProductItem(
      this.id, this.title, this.imageUrl, this.description, this.price,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(
        title!,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl!),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProductScreen(
                      Product(
                          id: id,
                          title: title,
                          description: description,
                          price: price,
                          imageUrl: imageUrl),
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () async {
                try {
                  await Provider.of<Products>(context, listen: false)
                      .deleteProduct(id!);
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Deleting failed"),
                  ));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
