import 'package:flutter/material.dart';

// Template class
abstract class DataProcessor {
  void process() {
    readData();
    validateData();
    transformData();
    saveData();
  }

  void readData();
  void validateData();
  void transformData();
  void saveData();
}

// Concrete implementations
class CSVProcessor extends DataProcessor {
  final List<String> _logs = [];

  @override
  void readData() => _logs.add('✓ Reading CSV file...');

  @override
  void validateData() => _logs.add('✓ Validating CSV data...');

  @override
  void transformData() => _logs.add('✓ Transforming CSV to objects...');

  @override
  void saveData() => _logs.add('✓ Saving to database...');

  List<String> getLogs() => List.from(_logs);
}

class JSONProcessor extends DataProcessor {
  final List<String> _logs = [];

  @override
  void readData() => _logs.add('✓ Reading JSON file...');

  @override
  void validateData() => _logs.add('✓ Validating JSON schema...');

  @override
  void transformData() => _logs.add('✓ Transforming JSON to objects...');

  @override
  void saveData() => _logs.add('✓ Saving to database...');

  List<String> getLogs() => List.from(_logs);
}

class XMLProcessor extends DataProcessor {
  final List<String> _logs = [];

  @override
  void readData() => _logs.add('✓ Reading XML file...');

  @override
  void validateData() => _logs.add('✓ Validating XML schema...');

  @override
  void transformData() => _logs.add('✓ Transforming XML to objects...');

  @override
  void saveData() => _logs.add('✓ Saving to database...');

  List<String> getLogs() => List.from(_logs);
}

class TemplateMethodExample extends StatefulWidget {
  const TemplateMethodExample({Key? key}) : super(key: key);

  @override
  State<TemplateMethodExample> createState() => _TemplateMethodExampleState();
}

class _TemplateMethodExampleState extends State<TemplateMethodExample> {
  List<String> _currentLogs = [];
  String _currentProcessor = 'CSV';

  void _processFile(String type) {
    late DataProcessor processor;

    switch (type) {
      case 'CSV':
        processor = CSVProcessor();
        _currentProcessor = 'CSV';
        break;
      case 'JSON':
        processor = JSONProcessor();
        _currentProcessor = 'JSON';
        break;
      case 'XML':
        processor = XMLProcessor();
        _currentProcessor = 'XML';
        break;
    }

    processor.process();

    setState(() {
      _currentLogs = processor is CSVProcessor
          ? processor.getLogs()
          : processor is JSONProcessor
              ? processor.getLogs()
              : (processor as XMLProcessor).getLogs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Template Method Pattern - Define algorithm structure',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        Text(
          'Select File Format:',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: ['CSV', 'JSON', 'XML']
              .map((type) => ElevatedButton(
                    onPressed: () => _processFile(type),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          type == _currentProcessor ? Colors.blue : Colors.grey[300],
                      foregroundColor:
                          type == _currentProcessor ? Colors.white : Colors.black,
                    ),
                    child: Text(type),
                  ))
              .toList(),
        ),
        const SizedBox(height: 16),
        if (_currentLogs.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.withAlpha(20),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Processing Steps ($_currentProcessor):',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                ..._currentLogs
                    .map((log) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text(log, style: const TextStyle(fontSize: 12)),
                        ))
                    .toList(),
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
                  'Each processor follows same algorithm: Read → Validate → Transform → Save',
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
