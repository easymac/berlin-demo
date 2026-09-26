/// A postal address in German format.
class Address {
  const Address({
    required this.name,
    required this.street,
    required this.postalCode,
    required this.city,
    required this.country,
  });

  final String name;
  final String street;
  final String postalCode;
  final String city;
  final String country;
}
