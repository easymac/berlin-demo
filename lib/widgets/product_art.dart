import 'package:flutter/material.dart';

import '../models/product.dart';

/// A product's picture: its icon on a gradient of its accent colour.
class ProductArt extends StatelessWidget {
  const ProductArt({
    super.key,
    required this.product,
    this.iconSize = 64,
    this.borderRadius = 16,
  });

  final Product product;
  final double iconSize;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.lerp(product.color, Colors.white, 0.3)!,
            product.color,
          ],
        ),
      ),
      child: Center(
        child: Icon(
          product.icon,
          size: iconSize,
          color: Colors.white,
          shadows: const [Shadow(color: Colors.black26, blurRadius: 12)],
        ),
      ),
    );
  }
}
