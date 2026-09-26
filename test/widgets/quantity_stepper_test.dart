import 'package:berlin_demo/theme.dart';
import 'package:berlin_demo/widgets/quantity_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<double> countHeight(WidgetTester tester, int quantity) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: buildTheme(),
        home: Scaffold(
          body: Center(
            child: QuantityStepper(
              quantity: quantity,
              onIncrement: () {},
              onDecrement: () {},
            ),
          ),
        ),
      ),
    );
    return tester.getSize(find.text('$quantity')).height;
  }

  testWidgets('keeps wide and negative counts on one line', (tester) async {
    final singleDigitHeight = await countHeight(tester, 1);

    expect(await countHeight(tester, -10), singleDigitHeight);
    expect(await countHeight(tester, 1000), singleDigitHeight);
  });
}
