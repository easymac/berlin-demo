import '../models/address.dart';
import '../models/payment_card.dart';

/// 4242 4242 4242 4242 is Stripe's documented test card number, not a real
/// card.
const demoCard = PaymentCard(
  holder: 'Sandy Piper',
  number: '4242 4242 4242 4242',
  expiry: '12/29',
);

const demoAddress = Address(
  name: 'Sandy Piper',
  street: 'Musterstraße 12',
  postalCode: '10115',
  city: 'Berlin',
  country: 'Germany',
);
