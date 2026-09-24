// Abstract Factory - Creates families of related objects

// Theme components
abstract class Button {
  String render();
}

abstract class ThemeTextField {
  String render();
}

// Light theme components
class LightButton implements Button {
  @override
  String render() => '[Light Button] black text on white background';
}

class LightTextField implements ThemeTextField {
  @override
  String render() => '[Light Input] black border, white fill';
}

// Dark theme components
class DarkButton implements Button {
  @override
  String render() => '[Dark Button] white text on black background';
}

class DarkTextField implements ThemeTextField {
  @override
  String render() => '[Dark Input] white border, grey fill';
}

// Abstract factory
abstract class UIFactory {
  Button createButton();
  ThemeTextField createTextField();
}

// Concrete factories
class LightThemeFactory implements UIFactory {
  @override
  Button createButton() => LightButton();

  @override
  ThemeTextField createTextField() => LightTextField();
}

class DarkThemeFactory implements UIFactory {
  @override
  Button createButton() => DarkButton();

  @override
  ThemeTextField createTextField() => DarkTextField();
}
