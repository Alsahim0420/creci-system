import 'package:flutter/material.dart';

// Component
abstract class Coffee {
  String getDescription();
  double getCost();
}

// Concrete component
class SimpleCoffee implements Coffee {
  @override
  String getDescription() => 'Simple Coffee';
  @override
  double getCost() => 2.0;
}

// Decorator
abstract class CoffeeDecorator implements Coffee {
  final Coffee coffee;
  CoffeeDecorator(this.coffee);
}

// Concrete decorators
class MilkDecorator extends CoffeeDecorator {
  MilkDecorator(Coffee coffee) : super(coffee);
  @override
  String getDescription() => '${coffee.getDescription()}, Milk';
  @override
  double getCost() => coffee.getCost() + 0.5;
}

class SugarDecorator extends CoffeeDecorator {
  SugarDecorator(Coffee coffee) : super(coffee);
  @override
  String getDescription() => '${coffee.getDescription()}, Sugar';
  @override
  double getCost() => coffee.getCost() + 0.25;
}

class VanillaDecorator extends CoffeeDecorator {
  VanillaDecorator(Coffee coffee) : super(coffee);
  @override
  String getDescription() => '${coffee.getDescription()}, Vanilla';
  @override
  double getCost() => coffee.getCost() + 0.75;
}

class WhipCreamDecorator extends CoffeeDecorator {
  WhipCreamDecorator(Coffee coffee) : super(coffee);
  @override
  String getDescription() => '${coffee.getDescription()}, Whip Cream';
  @override
  double getCost() => coffee.getCost() + 1.0;
}

class DecoratorExample extends StatefulWidget {
  const DecoratorExample({Key? key}) : super(key: key);

  @override
  State<DecoratorExample> createState() => _DecoratorExampleState();
}

class _DecoratorExampleState extends State<DecoratorExample> {
  bool _hasMilk = false;
  bool _hasSugar = false;
  bool _hasVanilla = false;
  bool _hasWhipCream = false;

  Coffee _buildCoffee() {
    Coffee coffee = SimpleCoffee();
    if (_hasMilk) coffee = MilkDecorator(coffee);
    if (_hasSugar) coffee = SugarDecorator(coffee);
    if (_hasVanilla) coffee = VanillaDecorator(coffee);
    if (_hasWhipCream) coffee = WhipCreamDecorator(coffee);
    return coffee;
  }

  @override
  Widget build(BuildContext context) {
    final coffee = _buildCoffee();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Decorator Pattern - Add features dynamically',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        Text(
          'Choose your toppings:',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilterChip(
              label: const Text('Milk (+\$0.50)'),
              selected: _hasMilk,
              onSelected: (value) => setState(() => _hasMilk = value),
            ),
            FilterChip(
              label: const Text('Sugar (+\$0.25)'),
              selected: _hasSugar,
              onSelected: (value) => setState(() => _hasSugar = value),
            ),
            FilterChip(
              label: const Text('Vanilla (+\$0.75)'),
              selected: _hasVanilla,
              onSelected: (value) => setState(() => _hasVanilla = value),
            ),
            FilterChip(
              label: const Text('Whip Cream (+\$1.00)'),
              selected: _hasWhipCream,
              onSelected: (value) => setState(() => _hasWhipCream = value),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.brown.withAlpha(20),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.brown),
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
                        'Your Coffee:',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        coffee.getDescription(),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Total Price:',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$${coffee.getCost().toStringAsFixed(2)}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Colors.green),
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
                        content: Text(
                          'Ordered: ${coffee.getDescription()} - \$${coffee.getCost().toStringAsFixed(2)}',
                        ),
                      ),
                    );
                  },
                  child: const Text('Order Now'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
