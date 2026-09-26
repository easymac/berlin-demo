import 'package:flutter/material.dart';

import '../models/cart.dart';
import '../money.dart';

class FreeShippingBanner extends StatelessWidget {
  const FreeShippingBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [colorScheme.primary, colorScheme.tertiary],
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Berlin conference collection',
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Free shipping from '
                  '${formatEuros(Cart.freeShippingThresholdCents)}',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onPrimary.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.local_shipping_outlined,
            size: 40,
            color: colorScheme.onPrimary,
          ),
        ],
      ),
    );
  }
}
