import 'package:berlin_demo/app.dart';
import 'package:berlin_demo/models/cart.dart';
import 'package:berlin_demo/screens/catalog_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// iPhone 17 Pro screen in physical pixels, at a device pixel ratio of 3.
const iPhone17ProSize = Size(1206, 2622);

void main() {
  testWidgets('add to cart, adjust quantity, and place the order', (
    tester,
  ) async {
    tester.view
      ..physicalSize = iPhone17ProSize
      ..devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(ShopApp(cart: Cart()));

    await tester.tap(find.byTooltip('Add Code Push Tee to cart'));
    await tester.pump();
    expect(cartBadge(tester).isLabelVisible, isTrue);

    await tester.tap(find.byTooltip('Cart'));
    await tester.pumpAndSettle();
    expect(find.text('Checkout'), findsOneWidget);
    // €24.90 tee + €4.90 shipping
    expect(find.text('Place order · €29.80'), findsOneWidget);

    await tester.tap(find.byTooltip('Increase quantity'));
    await tester.pump();
    // 2 tees: €49.80 + €4.90 shipping
    expect(find.text('Place order · €54.70'), findsOneWidget);

    await tester.tap(find.byTooltip('Decrease quantity'));
    await tester.pump();
    await tester.tap(find.byTooltip('Decrease quantity'));
    await tester.pump();
    expect(find.text('Your cart is empty'), findsOneWidget);

    await tester.tap(find.text('Browse the store'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Add Shorebird Hoodie to cart'));
    await tester.tap(find.byTooltip('Cart'));
    await tester.pumpAndSettle();

    // €59 hoodie ships free
    await tester.tap(find.text('Place order · €59.00'));
    await tester.pumpAndSettle();
    expect(find.text('Order placed'), findsOneWidget);
    expect(find.textContaining('€59.00'), findsOneWidget);

    await tester.tap(find.text('Continue shopping'));
    await tester.pumpAndSettle();
    expect(find.byType(CatalogScreen), findsOneWidget);
    expect(cartBadge(tester).isLabelVisible, isFalse);
  });
}

Badge cartBadge(WidgetTester tester) => tester.widget<Badge>(
  find.descendant(of: find.byTooltip('Cart'), matching: find.byType(Badge)),
);
