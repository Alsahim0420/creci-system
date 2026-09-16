import 'package:flutter/material.dart';

// Strategy interface
abstract class PricingStrategy {
  String get name;
  double calculatePrice(double basePrice);
  String get description;
}

// Concrete strategies
class RegularPricingStrategy implements PricingStrategy {
  @override
  String get name => 'Regular';
  @override
  String get description => 'No discount';
  @override
  double calculatePrice(double basePrice) => basePrice;
}

class StudentDiscountStrategy implements PricingStrategy {
  @override
  String get name => 'Student';
  @override
  String get description => '20% off';
  @override
  double calculatePrice(double basePrice) => basePrice * 0.8;
}

class BulkDiscountStrategy implements PricingStrategy {
  @override
  String get name => 'Bulk';
  @override
  String get description => '30% off (10+ items)';
  @override
  double calculatePrice(double basePrice) => basePrice * 0.7;
}

class SeniorCitizenStrategy implements PricingStrategy {
  @override
  String get name => 'Senior Citizen';
  @override
  String get description => '25% off';
  @override
  double calculatePrice(double basePrice) => basePrice * 0.75;
}

// Context
class ShoppingCart {
  late PricingStrategy _strategy;
  double basePrice = 0;

  ShoppingCart() {
    _strategy = RegularPricingStrategy();
  }

  void setPricingStrategy(PricingStrategy strategy) {
    _strategy = strategy;
  }

  double getTotalPrice() => _strategy.calculatePrice(basePrice);
  String getStrategyName() => _strategy.name;
  String getStrategyDescription() => _strategy.description;
}

class StrategyExample extends StatefulWidget {
  const StrategyExample({Key? key}) : super(key: key);

  @override
  State<StrategyExample> createState() => _StrategyExampleState();
}

class _StrategyExampleState extends State<StrategyExample> {
  final ShoppingCart _cart = ShoppingCart();
  final List<PricingStrategy> _strategies = [
    RegularPricingStrategy(),
    StudentDiscountStrategy(),
    BulkDiscountStrategy(),
    SeniorCitizenStrategy(),
  ];

  @override
  void initState() {
    super.initState();
    _cart.basePrice = 100.0;
    _cart.setPricingStrategy(_strategies[0]);
  }

  void _selectStrategy(PricingStrategy strategy) {
    setState(() {
      _cart.setPricingStrategy(strategy);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Strategy Pattern - Interchangeable Algorithms',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.withAlpha(20),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Base Price: \$${_cart.basePrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Select Pricing Strategy:',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _strategies
              .map((strategy) => ElevatedButton(
                    onPressed: () => _selectStrategy(strategy),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          strategy.name == _cart.getStrategyName()
                              ? Colors.green
                              : Colors.grey[300],
                      foregroundColor:
                          strategy.name == _cart.getStrategyName()
                              ? Colors.white
                              : Colors.black,
                    ),
                    child: Text(strategy.name),
                  ))
              .toList(),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green.withAlpha(20),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.green, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _cart.getStrategyName(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Colors.green),
                      ),
                      Text(
                        _cart.getStrategyDescription(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Final Price:',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        '\$${_cart.getTotalPrice().toStringAsFixed(2)}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Purchase with ${_cart.getStrategyName()}: \$${_cart.getTotalPrice().toStringAsFixed(2)}',
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Checkout'),
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
                  'Strategies (pricing algorithms) can be swapped at runtime without changing client code.',
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
