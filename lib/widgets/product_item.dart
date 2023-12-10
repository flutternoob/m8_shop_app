import 'package:flutter/material.dart';
import 'package:m8_shop_app/providers/cart.dart';
import 'package:m8_shop_app/providers/product.dart';
import 'package:m8_shop_app/providers/auth.dart';
import 'package:m8_shop_app/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {

  const ProductItem({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final product = Provider.of<Product>(context);
    final Cart cart = Provider.of<Cart>(context, listen: false);
    final Auth authData = Provider.of<Auth>(context, listen: false);
    return Consumer<Product>(
      builder: (context, product, child) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            title: Text(
              product.title!,
              textAlign: TextAlign.center,
            ),
            leading: IconButton(
              icon: Icon((product.isFavorite!)? Icons.favorite: Icons.favorite_border),
              onPressed: () {
                product.toggleFavoriteStatus(authData.token as String, authData.userId);
              },
              color: Theme.of(context).hintColor,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                cart.addItem(product.id!, product.price!, product.title!);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text("Added item to cart"),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(label: "UNDO", onPressed: (){
                    cart.removeSingleItem(product.id!);
                  }),
                ),);
              },
              color: Theme.of(context).hintColor,
            ),
          ),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(ProductDetailScreen.routeName, arguments: product.id),
            child: Hero(
              tag: product.id!,
              child: FadeInImage(
                placeholder: AssetImage("images/product-placeholder.png"),
                image: NetworkImage(
                  product.imageUrl!,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
