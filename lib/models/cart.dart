import 'dart:math';

import 'package:flutter/foundation.dart';

import 'product.dart';

/// One row of the cart: a product and how many of it.
class CartLine {
  const CartLine({required this.product, required this.quantity});

  final Product product;
  final int quantity;

  int get totalCents => product.priceCents * quantity;
}

/// The shopping cart: which products the customer picked, and what they cost.
class Cart extends ChangeNotifier {
  /// Flat shipping fee for orders below [freeShippingThresholdCents].
  static const shippingFeeCents = 490;

  /// Orders with a subtotal of at least this amount ship for free.
  static const freeShippingThresholdCents = 5000;

  /// German VAT rate. Store prices already include it.
  static const vatPercent = 19;

  final Map<Product, int> _quantities = {};

  /// The cart's contents, in the order products were first added.
  List<CartLine> get lines => [
    for (final entry in _quantities.entries)
      CartLine(product: entry.key, quantity: entry.value),
  ];

  bool get isEmpty => _quantities.isEmpty;

  /// Total number of items, counting each unit of each product.
  int get itemCount =>
      _quantities.values.fold(0, (sum, quantity) => sum + quantity);

  int quantityOf(Product product) => _quantities[product] ?? 0;

  /// Adds one unit of [product].
  void addOne(Product product) {
    _quantities[product] = quantityOf(product) + 1;
    notifyListeners();
  }

  /// Removes one unit of [product], and its line once none are left.
  void removeOne(Product product) {
    final quantity = quantityOf(product) - 1;
    _quantities[product] = quantity;
    if (quantity <= 0) _quantities.remove(product);
    notifyListeners();
  }

  void clear() {
    _quantities.clear();
    notifyListeners();
  }

  int get subtotalCents => lines.fold(0, (sum, line) => sum + line.totalCents);

  int get shippingCents {
    if (isEmpty || subtotalCents >= freeShippingThresholdCents) return 0;
    return shippingFeeCents;
  }

  int get totalCents => subtotalCents + shippingCents;

  /// The VAT contained in [totalCents], shipping included.
  int get vatCents => (totalCents * vatPercent / (100 + vatPercent)).round();

  /// How much more the customer needs to spend to get free shipping.
  int get centsUntilFreeShipping =>
      max(0, freeShippingThresholdCents - subtotalCents);
}
