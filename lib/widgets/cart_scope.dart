import 'package:flutter/widgets.dart';

import '../models/cart.dart';

/// Makes the [Cart] available to every screen.
class CartScope extends InheritedNotifier<Cart> {
  const CartScope({super.key, required Cart cart, required super.child})
    : super(notifier: cart);

  /// The cart, rebuilding [context] whenever it changes. Use in `build`.
  static Cart of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<CartScope>();
    assert(scope != null, 'No CartScope above this widget.');
    return scope!.notifier!;
  }

  /// The cart, without rebuilding [context] when it changes. Use in callbacks.
  static Cart read(BuildContext context) {
    final scope = context.getInheritedWidgetOfExactType<CartScope>();
    assert(scope != null, 'No CartScope above this widget.');
    return scope!.notifier!;
  }
}
