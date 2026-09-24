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
  MilkDecorator(super.coffee);
  @override
  String getDescription() => '${coffee.getDescription()}, Milk';
  @override
  double getCost() => coffee.getCost() + 0.5;
}

class SugarDecorator extends CoffeeDecorator {
  SugarDecorator(super.coffee);
  @override
  String getDescription() => '${coffee.getDescription()}, Sugar';
  @override
  double getCost() => coffee.getCost() + 0.25;
}

class VanillaDecorator extends CoffeeDecorator {
  VanillaDecorator(super.coffee);
  @override
  String getDescription() => '${coffee.getDescription()}, Vanilla';
  @override
  double getCost() => coffee.getCost() + 0.75;
}

class WhipCreamDecorator extends CoffeeDecorator {
  WhipCreamDecorator(super.coffee);
  @override
  String getDescription() => '${coffee.getDescription()}, Whip Cream';
  @override
  double getCost() => coffee.getCost() + 1.0;
}
