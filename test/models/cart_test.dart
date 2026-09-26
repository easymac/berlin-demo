import 'package:berlin_demo/models/cart.dart';
import 'package:berlin_demo/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Product product(String id, {required int priceCents}) => Product(
  id: id,
  name: id,
  description: '',
  priceCents: priceCents,
  icon: Icons.star,
  color: Colors.blue,
);

final tee = product('tee', priceCents: 2000);
final mug = product('mug', priceCents: 1500);

void main() {
  late Cart cart;

  setUp(() => cart = Cart());

  test('starts empty and free of charge', () {
    expect(cart.isEmpty, isTrue);
    expect(cart.itemCount, 0);
    expect(cart.totalCents, 0);
    expect(cart.shippingCents, 0);
  });

  test('adding a product again increases its quantity', () {
    cart
      ..addOne(tee)
      ..addOne(tee)
      ..addOne(mug);

    expect(cart.quantityOf(tee), 2);
    expect(cart.itemCount, 3);
    expect(cart.lines.map((line) => line.product), [tee, mug]);
  });

  test('products with the same id share a line', () {
    cart
      ..addOne(tee)
      ..addOne(product('tee', priceCents: 2000));

    expect(cart.lines, hasLength(1));
    expect(cart.quantityOf(tee), 2);
  });

  test('line totals and subtotal multiply price by quantity', () {
    cart
      ..addOne(tee)
      ..addOne(tee)
      ..addOne(mug);

    expect(cart.lines.first.totalCents, 4000);
    expect(cart.subtotalCents, 5500);
  });

  test('removeOne decreases the quantity', () {
    cart
      ..addOne(tee)
      ..addOne(tee)
      ..removeOne(tee);

    expect(cart.quantityOf(tee), 1);
  });

  test('removeOne on the last unit removes the line', () {
    cart
      ..addOne(tee)
      ..removeOne(tee);

    expect(cart.isEmpty, isTrue);
    expect(cart.quantityOf(tee), 0);
    expect(cart.totalCents, 0);
  });

  test('removeOne on a product not in the cart does nothing', () {
    cart.removeOne(tee);

    expect(cart.isEmpty, isTrue);
  });

  test('charges shipping one cent below the free shipping threshold', () {
    cart.addOne(product('jacket', priceCents: 4999));

    expect(cart.shippingCents, Cart.shippingFeeCents);
    expect(cart.centsUntilFreeShipping, 1);
    expect(cart.totalCents, 5489);
  });

  test('ships for free at exactly the threshold', () {
    cart
      ..addOne(tee)
      ..addOne(mug)
      ..addOne(mug);

    expect(cart.subtotalCents, Cart.freeShippingThresholdCents);
    expect(cart.shippingCents, 0);
    expect(cart.centsUntilFreeShipping, 0);
    expect(cart.totalCents, 5000);
  });

  test('VAT is the 19% already included in the total', () {
    cart
      ..addOne(tee)
      ..addOne(tee)
      ..addOne(tee);

    // 6000 * 19 / 119 = 957.98
    expect(cart.totalCents, 6000);
    expect(cart.vatCents, 958);
  });

  test('VAT is included in the total, shipping included', () {
    cart.addOne(tee);

    // (2000 + 490) * 19 / 119 = 397.56
    expect(cart.totalCents, 2490);
    expect(cart.vatCents, 398);
  });

  test('VAT rounds to the nearest cent', () {
    cart.addOne(product('sticker', priceCents: 100));

    // (100 + 490) * 19 / 119 = 94.20
    expect(cart.totalCents, 590);
    expect(cart.vatCents, 94);
  });

  test('clear empties the cart', () {
    cart
      ..addOne(tee)
      ..clear();

    expect(cart.isEmpty, isTrue);
  });

  test('notifies listeners on every change', () {
    var notifications = 0;
    cart.addListener(() => notifications++);

    cart
      ..addOne(tee)
      ..removeOne(tee)
      ..clear();

    expect(notifications, 3);
  });
}
