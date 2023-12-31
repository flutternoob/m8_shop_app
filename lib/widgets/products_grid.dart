import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:m8_shop_app/providers/products.dart';
import 'package:m8_shop_app/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool? showFavorites;

  const ProductsGrid(
    this.showFavorites, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products =
        showFavorites! ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
          value: products[index],
          child: const ProductItem(),
        );
      },
    );
  }
}
