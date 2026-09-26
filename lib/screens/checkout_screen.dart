import 'package:flutter/material.dart';

import '../data/customer.dart';
import '../models/cart.dart';
import '../money.dart';
import '../widgets/address_card.dart';
import '../widgets/cart_line_tile.dart';
import '../widgets/cart_scope.dart';
import '../widgets/empty_cart_view.dart';
import '../widgets/order_summary.dart';
import '../widgets/payment_card_view.dart';
import '../widgets/section_header.dart';
import 'order_confirmation_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: cart.isEmpty
          ? EmptyCartView(onBrowse: () => Navigator.of(context).pop())
          : _CheckoutContents(cart: cart),
      bottomNavigationBar: cart.isEmpty
          ? null
          : _PlaceOrderBar(
              totalCents: cart.totalCents,
              onPressed: () => _placeOrder(context, cart),
            ),
    );
  }

  Future<void> _placeOrder(BuildContext context, Cart cart) async {
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (context) => OrderConfirmationScreen(
          totalCents: cart.totalCents,
          card: demoCard,
        ),
      ),
    );
    // Cleared once the confirmation screen closes, so this screen never shows
    // an empty cart while it animates away.
    cart.clear();
  }
}

class _CheckoutContents extends StatelessWidget {
  const _CheckoutContents({required this.cart});

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      children: [
        const SectionHeader('Your cart'),
        Card(
          child: Column(
            children: [
              for (final line in cart.lines)
                CartLineTile(
                  key: ValueKey(line.product.id),
                  line: line,
                  onIncrement: () => cart.addOne(line.product),
                  onDecrement: () => cart.removeOne(line.product),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        OrderSummary(cart: cart),
        const SectionHeader('Shipping to'),
        const AddressCard(address: demoAddress),
        const SectionHeader('Payment'),
        const PaymentCardView(card: demoCard),
      ],
    );
  }
}

class _PlaceOrderBar extends StatelessWidget {
  const _PlaceOrderBar({required this.totalCents, required this.onPressed});

  final int totalCents;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        border: Border(top: BorderSide(color: colorScheme.outlineVariant)),
      ),
      child: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: FilledButton(
          onPressed: onPressed,
          child: Text('Place order · ${formatEuros(totalCents)}'),
        ),
      ),
    );
  }
}
