import 'package:flutter/material.dart';

import '../models/cart.dart';
import '../money.dart';
import 'product_art.dart';
import 'quantity_stepper.dart';

class CartLineTile extends StatelessWidget {
  const CartLineTile({
    super.key,
    required this.line,
    required this.onIncrement,
    required this.onDecrement,
  });

  final CartLine line;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox.square(
            dimension: 72,
            child: ProductArt(
              product: line.product,
              iconSize: 32,
              borderRadius: 14,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(line.product.name, style: textTheme.titleMedium),
                const SizedBox(height: 2),
                Text(
                  '${formatEuros(line.product.priceCents)} each',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                QuantityStepper(
                  quantity: line.quantity,
                  onIncrement: onIncrement,
                  onDecrement: onDecrement,
                ),
              ],
            ),
          ),
          Text(formatEuros(line.totalCents), style: textTheme.titleMedium),
        ],
      ),
    );
  }
}
