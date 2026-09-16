import 'package:flutter/material.dart';

// Builder Pattern - Builds complex objects step by step
class Computer {
  final String processor;
  final String ram;
  final String storage;
  final String gpu;
  final bool hasWifi;
  final bool hasBluetooh;

  Computer({
    required this.processor,
    required this.ram,
    required this.storage,
    required this.gpu,
    required this.hasWifi,
    required this.hasBluetooh,
  });

  @override
  String toString() {
    return '''
Processor: $processor
RAM: $ram
Storage: $storage
GPU: $gpu
WiFi: ${hasWifi ? 'Yes' : 'No'}
Bluetooth: ${hasBluetooh ? 'Yes' : 'No'}
    ''';
  }
}

// Builder class
class ComputerBuilder {
  String processor = 'Intel i5';
  String ram = '8GB';
  String storage = '256GB SSD';
  String gpu = 'Integrated';
  bool hasWifi = true;
  bool hasBluetooh = true;

  ComputerBuilder setProcessor(String processor) {
    this.processor = processor;
    return this;
  }

  ComputerBuilder setRam(String ram) {
    this.ram = ram;
    return this;
  }

  ComputerBuilder setStorage(String storage) {
    this.storage = storage;
    return this;
  }

  ComputerBuilder setGpu(String gpu) {
    this.gpu = gpu;
    return this;
  }

  ComputerBuilder setWifi(bool hasWifi) {
    this.hasWifi = hasWifi;
    return this;
  }

  ComputerBuilder setBluetooth(bool hasBluetooth) {
    this.hasBluetooh = hasBluetooth;
    return this;
  }

  Computer build() {
    return Computer(
      processor: processor,
      ram: ram,
      storage: storage,
      gpu: gpu,
      hasWifi: hasWifi,
      hasBluetooh: hasBluetooh,
    );
  }
}

class BuilderExample extends StatefulWidget {
  const BuilderExample({Key? key}) : super(key: key);

  @override
  State<BuilderExample> createState() => _BuilderExampleState();
}

class _BuilderExampleState extends State<BuilderExample> {
  late ComputerBuilder _builder;
  Computer? _builtComputer;

  @override
  void initState() {
    super.initState();
    _builder = ComputerBuilder();
  }

  void _buildComputer() {
    setState(() {
      _builtComputer = _builder.build();
    });
  }

  void _resetBuilder() {
    setState(() {
      _builder = ComputerBuilder();
      _builtComputer = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Builder Pattern - Configure Computer Step by Step',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.purple.withAlpha(20),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.purple),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOption(
                'Processor',
                _builder.processor,
                ['Intel i5', 'Intel i7', 'AMD Ryzen 5', 'AMD Ryzen 9'],
                (value) => setState(() => _builder.setProcessor(value)),
              ),
              const SizedBox(height: 12),
              _buildOption(
                'RAM',
                _builder.ram,
                ['8GB', '16GB', '32GB', '64GB'],
                (value) => setState(() => _builder.setRam(value)),
              ),
              const SizedBox(height: 12),
              _buildOption(
                'Storage',
                _builder.storage,
                ['256GB SSD', '512GB SSD', '1TB SSD', '2TB SSD'],
                (value) => setState(() => _builder.setStorage(value)),
              ),
              const SizedBox(height: 12),
              _buildOption(
                'GPU',
                _builder.gpu,
                ['Integrated', 'RTX 3060', 'RTX 3070', 'RTX 3090'],
                (value) => setState(() => _builder.setGpu(value)),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text('WiFi'),
                      value: _builder.hasWifi,
                      onChanged: (value) =>
                          setState(() => _builder.setWifi(value ?? false)),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text('Bluetooth'),
                      value: _builder.hasBluetooh,
                      onChanged: (value) =>
                          setState(() => _builder.setBluetooth(value ?? false)),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: _buildComputer,
              icon: const Icon(Icons.build),
              label: const Text('Build Computer'),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: _resetBuilder,
              icon: const Icon(Icons.refresh),
              label: const Text('Reset'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
            ),
          ],
        ),
        if (_builtComputer != null) ...[
          const SizedBox(height: 16),
          Text(
            'Built Configuration:',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.withAlpha(20),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green),
            ),
            child: Text(
              _builtComputer.toString(),
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildOption(String label, String current, List<String> options,
      Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        const SizedBox(height: 4),
        DropdownButton<String>(
          value: current,
          isExpanded: true,
          items: options
              .map((opt) => DropdownMenuItem(value: opt, child: Text(opt)))
              .toList(),
          onChanged: (value) => onChanged(value ?? current),
        ),
      ],
    );
  }
}
