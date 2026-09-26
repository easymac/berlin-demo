# Storebird

A Shorebird merch store used on stage to demonstrate [Shorebird](https://shorebird.dev) code push. It has no backend: the catalog, payment card and shipping address are hard-coded, and placing an order charges nothing.

## Layout

- `lib/models/cart.dart` holds all cart logic: quantities, line totals, subtotal, shipping, VAT and total. Money is stored as integer euro cents.
- `lib/money.dart` formats euro cents for display.
- `lib/data/` holds the catalog and the demo customer.
- `lib/screens/` has the catalog, checkout and order confirmation screens; `lib/widgets/` has the pieces they are built from.
- The cart reaches the widget tree through `CartScope`, an `InheritedNotifier`.

## Running

```sh
flutter run
flutter test
```

## Demo

Ship a release to a device, change some Dart code, then ship the change as a patch:

```sh
shorebird release ios
shorebird patch ios
```
