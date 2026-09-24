// Factory Pattern - Creates different payment types
abstract class PaymentMethod {
  String get name;
  String get description;
}

class CreditCardPayment implements PaymentMethod {
  @override
  String get name => 'Credit Card';
  @override
  String get description => 'Visa, Mastercard, American Express';
}

class PayPalPayment implements PaymentMethod {
  @override
  String get name => 'PayPal';
  @override
  String get description => 'Fast and secure PayPal checkout';
}

class ApplePayPayment implements PaymentMethod {
  @override
  String get name => 'Apple Pay';
  @override
  String get description => 'Quick and secure Apple Pay';
}

class GooglePayPayment implements PaymentMethod {
  @override
  String get name => 'Google Pay';
  @override
  String get description => 'Fast checkout with Google Pay';
}

// Factory - Creates appropriate payment method
class PaymentFactory {
  static PaymentMethod createPayment(String type) {
    switch (type) {
      case 'creditcard':
        return CreditCardPayment();
      case 'paypal':
        return PayPalPayment();
      case 'applepay':
        return ApplePayPayment();
      case 'googlepay':
        return GooglePayPayment();
      default:
        return CreditCardPayment();
    }
  }

  static List<String> getAvailableMethods() => [
        'creditcard',
        'paypal',
        'applepay',
        'googlepay',
      ];
}
