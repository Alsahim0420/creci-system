import 'package:flutter/material.dart';

// Factory Pattern - Creates different payment types
abstract class PaymentMethod {
  String get name;
  IconData get icon;
  String get description;
  Color get color;
}

class CreditCardPayment implements PaymentMethod {
  @override
  String get name => 'Credit Card';
  @override
  IconData get icon => Icons.credit_card;
  @override
  String get description => 'Visa, Mastercard, American Express';
  @override
  Color get color => Colors.blue;
}

class PayPalPayment implements PaymentMethod {
  @override
  String get name => 'PayPal';
  @override
  IconData get icon => Icons.account_balance_wallet;
  @override
  String get description => 'Fast and secure PayPal checkout';
  @override
  Color get color => Colors.blue[900]!;
}

class ApplePayPayment implements PaymentMethod {
  @override
  String get name => 'Apple Pay';
  @override
  IconData get icon => Icons.apple;
  @override
  String get description => 'Quick and secure Apple Pay';
  @override
  Color get color => Colors.grey[900]!;
}

class GooglePayPayment implements PaymentMethod {
  @override
  String get name => 'Google Pay';
  @override
  IconData get icon => Icons.g_mobiledata;
  @override
  String get description => 'Fast checkout with Google Pay';
  @override
  Color get color => Colors.red;
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

class FactoryExample extends StatefulWidget {
  const FactoryExample({Key? key}) : super(key: key);

  @override
  State<FactoryExample> createState() => _FactoryExampleState();
}

class _FactoryExampleState extends State<FactoryExample> {
  late PaymentMethod _selectedPayment;

  @override
  void initState() {
    super.initState();
    _selectedPayment = PaymentFactory.createPayment('creditcard');
  }

  void _selectPayment(String type) {
    setState(() {
      _selectedPayment = PaymentFactory.createPayment(type);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Factory Pattern - Different Payment Methods',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        Text(
          'Select Payment Method:',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: PaymentFactory.getAvailableMethods()
              .map((method) {
            final payment = PaymentFactory.createPayment(method);
            final isSelected = payment.name == _selectedPayment.name;
            return ElevatedButton(
              onPressed: () => _selectPayment(method),
              style: ElevatedButton.styleFrom(
                backgroundColor: isSelected
                    ? payment.color
                    : Colors.grey[300],
                foregroundColor: isSelected ? Colors.white : Colors.black,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(payment.icon),
                  const SizedBox(width: 8),
                  Text(payment.name),
                ],
              ),
            );
          })
              .toList(),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _selectedPayment.color.withAlpha(20),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _selectedPayment.color, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    _selectedPayment.icon,
                    size: 32,
                    color: _selectedPayment.color,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _selectedPayment.name,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                              color: _selectedPayment.color,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _selectedPayment.description,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Proceeding with ${_selectedPayment.name}...'),
                        backgroundColor: _selectedPayment.color,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedPayment.color,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text('Pay Now'),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.orange.withAlpha(20),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.info, color: Colors.orange[700]),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'The factory creates the right payment method based on type. Client doesn\'t need to know concrete classes.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
