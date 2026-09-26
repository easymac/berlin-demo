import 'package:flutter/material.dart';

/// App bar button that opens the cart, badged with the number of items in it.
class CartButton extends StatelessWidget {
  const CartButton({
    super.key,
    required this.itemCount,
    required this.onPressed,
  });

  final int itemCount;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      tooltip: 'Cart',
      icon: Badge.count(
        count: itemCount,
        isLabelVisible: itemCount > 0,
        child: const Icon(Icons.shopping_bag_outlined),
      ),
    );
  }
}
