import 'package:flutter/material.dart';

// Subject interface
abstract class Image {
  void display();
  String getSize();
}

// Real subject - expensive to create
class RealImage implements Image {
  final String _filename;
  final int _sizeInMB;
  bool _loaded = false;

  RealImage(this._filename, this._sizeInMB);

  void _load() {
    _loaded = true;
  }

  @override
  void display() => _load();

  @override
  String getSize() => '$_sizeInMB MB';
}

// Proxy - controls access to real image
class ProxyImage implements Image {
  final String _filename;
  final int _sizeInMB;
  RealImage? _realImage;
  bool _displayCount = false;

  ProxyImage(this._filename, this._sizeInMB);

  @override
  void display() {
    if (_realImage == null) {
      _realImage = RealImage(_filename, _sizeInMB);
    }
    _displayCount = true;
    _realImage!.display();
  }

  @override
  String getSize() => '$_sizeInMB MB';

  bool get isLoaded => _realImage != null;
}

class ProxyExample extends StatefulWidget {
  const ProxyExample({Key? key}) : super(key: key);

  @override
  State<ProxyExample> createState() => _ProxyExampleState();
}

class _ProxyExampleState extends State<ProxyExample> {
  final List<ProxyImage> _images = [
    ProxyImage('vacation.jpg', 2),
    ProxyImage('family.png', 3),
    ProxyImage('nature.jpg', 4),
  ];

  final List<String> _logs = [];

  void _addLog(String message) {
    setState(() => _logs.insert(0, '• $message'));
  }

  void _loadImage(int index) {
    _addLog('Loading ${_images[index]._filename}...');
    _images[index].display();
    setState(() {
      _addLog('✓ Loaded: ${_images[index]._filename} (${_images[index].getSize()})');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Proxy Pattern - Control access and lazy loading',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        Text(
          'Images (loaded on demand):',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        Column(
          children: List.generate(
            _images.length,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _images[index].isLoaded ? Colors.green.withAlpha(20) : Colors.grey.withAlpha(20),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color:
                        _images[index].isLoaded ? Colors.green : Colors.grey,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _images[index]._filename,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Size: ${_images[index].getSize()}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          _images[index].isLoaded ? '✓ Loaded in memory' : '○ Not loaded yet',
                          style: TextStyle(
                            fontSize: 12,
                            color:
                                _images[index].isLoaded ? Colors.green : Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: _images[index].isLoaded
                          ? null
                          : () => _loadImage(index),
                      child: const Text('Load'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Activity Log:',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 150,
          decoration: BoxDecoration(
            color: Colors.grey.withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: _logs.isEmpty
              ? Center(
                  child: Text(
                    'Click "Load" button to load an image',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: _logs.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      _logs[index],
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
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
                  'Proxy delays image loading until needed (lazy loading). Real image created only when accessed.',
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
