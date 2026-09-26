/// A payment card as shown at checkout. Display only; nothing is charged.
class PaymentCard {
  const PaymentCard({
    required this.holder,
    required this.number,
    required this.expiry,
  });

  final String holder;

  /// The card number in groups of four, e.g. `4242 4242 4242 4242`.
  final String number;

  /// Month and year, e.g. `12/29`.
  final String expiry;

  String get lastFourDigits => number.substring(number.length - 4);
}
