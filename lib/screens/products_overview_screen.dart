import 'package:flutter/material.dart' hide Badge;
import 'package:m8_shop_app/screens/cart_screen.dart';
import 'package:m8_shop_app/widgets/app_drawer.dart';
import 'package:m8_shop_app/widgets/badge.dart';
import 'package:provider/provider.dart';

import 'package:m8_shop_app/providers/product.dart';
import 'package:m8_shop_app/providers/products.dart';
import 'package:m8_shop_app/widgets/products_grid.dart';

import '../providers/cart.dart';

enum FilterOptions { favorites, all }

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showOnlyFavorites = false;
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void initState() {
    //Future.delayed(Duration.zero).then((value) => Provider.of<Products>(context).fetchAndSetProducts());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context)
          .fetchAndSetProducts()
          .then((_) => setState(() => _isLoading = false));
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //final Products productsContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("My Shop"),
        actions: [
          PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.favorites) {
                    //productsContainer.showFavoritesOnly();
                    _showOnlyFavorites = true;
                  } else {
                    //productsContainer.showAll();
                    _showOnlyFavorites = false;
                  }
                });
              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      value: FilterOptions.favorites,
                      child: Text(
                        "Only Favorites",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    PopupMenuItem(
                      value: FilterOptions.all,
                      child: Text(
                        "Show All",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ]),
          Consumer<Cart>(
              builder: (_, cart, ch) => Badge(
                    value: cart.itemCount.toString(),
                    child: ch,
                  ),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              )),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showOnlyFavorites),
    );
  }
}
