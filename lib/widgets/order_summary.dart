import 'package:flutter/material.dart';

import '../models/cart.dart';
import '../money.dart';

/// Subtotal, shipping, total and included VAT for the cart.
///
/// Takes the whole [Cart] rather than the values it shows, because it shows
/// nearly all of them.
class OrderSummary extends StatelessWidget {
  const OrderSummary({super.key, required this.cart});

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final shipping = cart.shippingCents == 0
        ? 'Free'
        : formatEuros(cart.shippingCents);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _SummaryRow(
              label: 'Subtotal',
              value: formatEuros(cart.subtotalCents),
            ),
            _SummaryRow(label: 'Shipping', value: shipping),
            if (cart.centsUntilFreeShipping > 0)
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Add ${formatEuros(cart.centsUntilFreeShipping)} more '
                  'for free shipping',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
              ),
            const Divider(height: 24),
            _SummaryRow(
              label: 'Total',
              value: formatEuros(cart.totalCents),
              style: textTheme.titleLarge,
            ),
            _SummaryRow(
              label: 'Includes ${Cart.vatPercent}% VAT',
              value: formatEuros(cart.vatCents),
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value, this.style});

  final String label;
  final String value;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? Theme.of(context).textTheme.bodyLarge;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value, style: style),
        ],
      ),
    );
  }
}
