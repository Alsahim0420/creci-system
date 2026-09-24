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
    hasBluetooh = hasBluetooth;
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
