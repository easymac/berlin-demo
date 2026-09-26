import 'package:flutter/material.dart';

/// A − / count / + control. At a quantity of one, the − button shows a
/// delete icon, since pressing it removes the line.
class QuantityStepper extends StatelessWidget {
  const QuantityStepper({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: const StadiumBorder(),
        color: colorScheme.surfaceContainerHighest,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onDecrement,
            tooltip: 'Decrease quantity',
            visualDensity: VisualDensity.compact,
            icon: Icon(quantity == 1 ? Icons.delete_outline : Icons.remove),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 40),
            child: Text(
              '$quantity',
              textAlign: TextAlign.center,
              maxLines: 1,
              softWrap: false,
              style: textTheme.titleLarge?.copyWith(
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ),
          IconButton(
            onPressed: onIncrement,
            tooltip: 'Increase quantity',
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
