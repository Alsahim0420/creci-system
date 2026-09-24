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
