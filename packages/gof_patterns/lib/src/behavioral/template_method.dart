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
