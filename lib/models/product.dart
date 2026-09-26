import 'package:flutter/widgets.dart';

/// An item for sale in the store. Two products are equal when their [id]s are.
class Product {
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.priceCents,
    required this.icon,
    required this.color,
  });

  final String id;
  final String name;
  final String description;

  /// Price in euro cents, including VAT.
  final int priceCents;

  /// Drawn on the product's artwork.
  final IconData icon;

  /// Accent colour for the product's artwork.
  final Color color;

  @override
  bool operator ==(Object other) => other is Product && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
