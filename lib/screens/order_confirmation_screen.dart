import 'package:flutter/material.dart';

import '../models/payment_card.dart';
import '../money.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({
    super.key,
    required this.totalCents,
    required this.card,
  });

  final int totalCents;
  final PaymentCard card;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Spacer(),
            CircleAvatar(
              radius: 48,
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              child: const Icon(Icons.check_rounded, size: 56),
            ),
            const SizedBox(height: 24),
            Text('Order placed', style: textTheme.headlineMedium),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'We charged ${formatEuros(totalCents)} to the card ending in '
                '${card.lastFourDigits}. Your merch is on its way.',
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const Spacer(),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Continue shopping'),
            ),
          ],
        ),
      ),
    );
  }
}
