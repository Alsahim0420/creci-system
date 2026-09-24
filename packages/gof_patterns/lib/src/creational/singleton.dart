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
