import 'package:flutter/material.dart';

// Abstract Factory - Creates families of related objects

// Theme components
abstract class Button {
  Widget build();
}

abstract class ThemeTextField {
  Widget build();
}

// Light theme components
class LightButton implements Button {
  @override
  Widget build() => ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          side: const BorderSide(color: Colors.black),
        ),
        onPressed: () {},
        child: const Text('Light Button'),
      );
}

class LightTextField implements ThemeTextField {
  @override
  Widget build() => TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
          ),
          filled: true,
          fillColor: Colors.white,
          labelText: 'Light Theme Input',
          labelStyle: const TextStyle(color: Colors.black),
        ),
      );
}

// Dark theme components
class DarkButton implements Button {
  @override
  Widget build() => ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.white),
        ),
        onPressed: () {},
        child: const Text('Dark Button'),
      );
}

class DarkTextField implements ThemeTextField {
  @override
  Widget build() => TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
          ),
          filled: true,
          fillColor: Colors.grey[800],
          labelText: 'Dark Theme Input',
          labelStyle: const TextStyle(color: Colors.white),
        ),
      );
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

class AbstractFactoryExample extends StatefulWidget {
  const AbstractFactoryExample({Key? key}) : super(key: key);

  @override
  State<AbstractFactoryExample> createState() => _AbstractFactoryExampleState();
}

class _AbstractFactoryExampleState extends State<AbstractFactoryExample> {
  bool _isDarkMode = false;
  late UIFactory _factory;
  late Button _button;
  late ThemeTextField _textField;

  @override
  void initState() {
    super.initState();
    _updateTheme();
  }

  void _updateTheme() {
    _factory = _isDarkMode ? DarkThemeFactory() : LightThemeFactory();
    _button = _factory.createButton();
    _textField = _factory.createTextField();
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
      _updateTheme();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Abstract Factory - Family of Related Objects',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Text('Current Theme:'),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _isDarkMode ? Colors.black : Colors.white,
                border: Border.all(
                  color: _isDarkMode ? Colors.white : Colors.black,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _isDarkMode ? 'Dark Theme' : 'Light Theme',
                style: TextStyle(
                  color: _isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            Switch(
              value: _isDarkMode,
              onChanged: (_) => _toggleTheme(),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          'Light Theme Factory creates:',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.withAlpha(20),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Components for Light Theme:',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '✓ LightButton (white bg, black text)',
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '✓ LightTextField (white input)',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Dark Theme Factory creates:',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.orange.withAlpha(20),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.orange),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Components for Dark Theme:',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '✓ DarkButton (black bg, white text)',
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '✓ DarkTextField (dark input)',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Preview - Currently using ${_isDarkMode ? 'Dark' : 'Light'} Theme:',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _isDarkMode ? Colors.grey[800] : Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _button.build(),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: _textField.build(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.purple.withAlpha(20),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.info, color: Colors.purple[700]),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Abstract Factory ensures a family of related UI components are always consistent.',
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
