import 'package:flutter/material.dart';

import '../data/catalog.dart';
import '../models/product.dart';
import '../widgets/cart_button.dart';
import '../widgets/cart_scope.dart';
import '../widgets/free_shipping_banner.dart';
import '../widgets/product_card.dart';
import 'checkout_screen.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('Storebird'),
            actions: [
              _CartAction(onPressed: () => _openCheckout(context)),
              const SizedBox(width: 8),
            ],
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(child: FreeShippingBanner()),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.72,
              ),
              itemCount: catalog.length,
              itemBuilder: (_, index) {
                final product = catalog[index];
                return _CatalogItem(
                  product: product,
                  onAdd: () => _addToCart(context, product),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _addToCart(BuildContext context, Product product) {
    CartScope.read(context).addOne(product);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('${product.name} added to cart'),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: 'View cart',
            onPressed: () => _openCheckout(context),
          ),
        ),
      );
  }

  void _openCheckout(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (context) => const CheckoutScreen()),
    );
  }
}

// _CartAction and _CatalogItem read the cart so that CatalogScreen does not:
// a change to the cart rebuilds them, not the whole screen.

class _CartAction extends StatelessWidget {
  const _CartAction({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CartButton(
      itemCount: CartScope.of(context).itemCount,
      onPressed: onPressed,
    );
  }
}

class _CatalogItem extends StatelessWidget {
  const _CatalogItem({required this.product, required this.onAdd});

  final Product product;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return ProductCard(
      product: product,
      quantityInCart: CartScope.of(context).quantityOf(product),
      onAdd: onAdd,
    );
  }
}
