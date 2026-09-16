import 'package:flutter/material.dart';

// Singleton Logger Implementation
class Logger {
  static Logger? _instance;
  int _logCount = 0;
  final List<String> _logs = [];

  factory Logger() {
    _instance ??= Logger._internal();
    return _instance!;
  }

  Logger._internal();

  void log(String message) {
    _logCount++;
    _logs.add('[$_logCount] $message');
  }

  List<String> getLogs() => List.from(_logs);
  int getLogCount() => _logCount;
  void clear() {
    _logCount = 0;
    _logs.clear();
  }
}

class SingletonExample extends StatefulWidget {
  const SingletonExample({Key? key}) : super(key: key);

  @override
  State<SingletonExample> createState() => _SingletonExampleState();
}

class _SingletonExampleState extends State<SingletonExample> {
  final Logger _logger = Logger();
  String _status = 'No logs yet';

  void _addLog(String message) {
    _logger.log(message);
    setState(() {
      _status = 'Total logs: ${_logger.getLogCount()}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Singleton Logger - Only ONE instance exists',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green.withAlpha(20),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _status,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _addLog('User logged in'),
                    icon: const Icon(Icons.login),
                    label: const Text('Login'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () => _addLog('File saved'),
                    icon: const Icon(Icons.save),
                    label: const Text('Save'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () => _addLog('Error occurred'),
                    icon: const Icon(Icons.error),
                    label: const Text('Error'),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Log History (${_logger.getLogCount()} total)',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey.withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: _logger.getLogs().isEmpty
              ? Center(
                  child: Text(
                    'No logs yet. Click buttons above to add logs.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: _logger.getLogs().length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      _logger.getLogs()[index],
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            _logger.clear();
            setState(() {
              _status = 'Logs cleared';
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Text('Clear Logs'),
        ),
      ],
    );
  }
}
