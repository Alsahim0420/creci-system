import 'package:flutter/material.dart';

// Handler
abstract class Validator {
  Validator? nextValidator;

  void setNext(Validator validator) {
    nextValidator = validator;
  }

  void validate(String input);
  String get name;
}

// Concrete handlers
class NotEmptyValidator extends Validator {
  @override
  String get name => 'Not Empty';

  @override
  void validate(String input) {
    if (input.isEmpty) {
      print('❌ Empty string not allowed');
      return;
    }
    if (nextValidator != null) {
      nextValidator!.validate(input);
    }
  }
}

class MinLengthValidator extends Validator {
  @override
  String get name => 'Min Length (5)';

  @override
  void validate(String input) {
    if (input.length < 5) {
      print('❌ String too short');
      return;
    }
    if (nextValidator != null) {
      nextValidator!.validate(input);
    }
  }
}

class AlphanumericValidator extends Validator {
  @override
  String get name => 'Alphanumeric';

  @override
  void validate(String input) {
    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(input)) {
      print('❌ Only alphanumeric characters allowed');
      return;
    }
    if (nextValidator != null) {
      nextValidator!.validate(input);
    }
  }
}

class ChainExample extends StatefulWidget {
  const ChainExample({Key? key}) : super(key: key);

  @override
  State<ChainExample> createState() => _ChainExampleState();
}

class _ChainExampleState extends State<ChainExample> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _results = [];

  void _validateInput() {
    final input = _controller.text;
    _results.clear();

    final chain = NotEmptyValidator();
    chain.setNext(MinLengthValidator());
    chain.setNext(AlphanumericValidator());

    _results.add('Validating: "$input"');
    _results.add('---');

    // Simulate validation
    if (input.isEmpty) {
      _results.add('❌ Empty string not allowed');
    } else if (input.length < 5) {
      _results.add('❌ String too short (needs 5+ chars)');
    } else if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(input)) {
      _results.add('❌ Only alphanumeric allowed');
    } else {
      _results.add('✓ All validations passed!');
    }

    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Chain of Responsibility - Pass request along chain',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        Text(
          'Validation Chain:',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.withAlpha(20),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '1. ${NotEmptyValidator().name}',
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                '   ↓',
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                '2. ${MinLengthValidator().name}',
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                '   ↓',
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                '3. ${AlphanumericValidator().name}',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Test Input:',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Enter text to validate...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onSubmitted: (_) => _validateInput(),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: _validateInput,
              icon: const Icon(Icons.check),
              label: const Text('Validate'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (_results.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(30),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _results
                  .map((result) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          result,
                          style: TextStyle(
                            fontSize: 12,
                            color: result.startsWith('✓')
                                ? Colors.green
                                : result.startsWith('❌')
                                    ? Colors.red
                                    : null,
                            fontWeight: result.startsWith('Validating')
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
      ],
    );
  }
}
