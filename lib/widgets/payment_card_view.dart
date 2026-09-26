import 'package:flutter/material.dart';

import '../models/payment_card.dart';

/// Draws a [PaymentCard] as a physical card.
class PaymentCardView extends StatelessWidget {
  const PaymentCardView({super.key, required this.card});

  final PaymentCard card;

  /// Width to height of an ISO/IEC 7810 ID-1 card.
  static const _aspectRatio = 85.6 / 53.98;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return AspectRatio(
      aspectRatio: _aspectRatio,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [const Color(0xFF14213D), colorScheme.primary],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                _Chip(),
                Spacer(),
                Icon(Icons.contactless_outlined, color: Colors.white),
              ],
            ),
            const Spacer(),
            Text(
              card.number,
              style: textTheme.titleLarge?.copyWith(
                color: Colors.white,
                letterSpacing: 1,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _LabeledValue(label: 'CARD HOLDER', value: card.holder),
                const Spacer(),
                _LabeledValue(label: 'EXPIRES', value: card.expiry),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        gradient: const LinearGradient(
          colors: [Color(0xFFF3D98B), Color(0xFFC9A64B)],
        ),
      ),
    );
  }
}

class _LabeledValue extends StatelessWidget {
  const _LabeledValue({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.labelSmall?.copyWith(
            color: Colors.white70,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 2),
        Text(value, style: textTheme.titleSmall?.copyWith(color: Colors.white)),
      ],
    );
  }
}
