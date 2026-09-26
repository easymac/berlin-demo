/// Formats an amount in euro cents for display, e.g. `2490` as `€24.90`.
String formatEuros(int cents) {
  final sign = cents < 0 ? '-' : '';
  final absolute = cents.abs();
  final euros = absolute ~/ 100;
  final twoDigitCents = (absolute % 100).toString().padLeft(2, '0');
  return '$sign€$euros.$twoDigitCents';
}
