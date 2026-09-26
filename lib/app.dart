import 'package:flutter/material.dart';

import 'models/cart.dart';
import 'screens/catalog_screen.dart';
import 'theme.dart';
import 'widgets/cart_scope.dart';

class ShopApp extends StatelessWidget {
  const ShopApp({super.key, required this.cart});

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return CartScope(
      cart: cart,
      child: MaterialApp(
        title: 'Storebird',
        debugShowCheckedModeBanner: false,
        theme: buildTheme(),
        home: const CatalogScreen(),
      ),
    );
  }
}
