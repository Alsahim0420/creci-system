// Command interface
abstract class Command {
  void execute();
  void undo();
  String get name;
}

// Receiver
class Light {
  bool _isOn = false;

  void turnOn() => _isOn = true;
  void turnOff() => _isOn = false;
  bool get isOn => _isOn;
}

// Concrete commands
class TurnOnCommand implements Command {
  final Light light;

  TurnOnCommand(this.light);

  @override
  void execute() => light.turnOn();

  @override
  void undo() => light.turnOff();

  @override
  String get name => 'Turn On Light';
}

class TurnOffCommand implements Command {
  final Light light;

  TurnOffCommand(this.light);

  @override
  void execute() => light.turnOff();

  @override
  void undo() => light.turnOn();

  @override
  String get name => 'Turn Off Light';
}

// Invoker
class RemoteControl {
  final List<Command> _commandHistory = [];
  int _currentIndex = -1;

  void execute(Command command) {
    command.execute();
    _commandHistory.removeRange(_currentIndex + 1, _commandHistory.length);
    _commandHistory.add(command);
    _currentIndex++;
  }

  void undo() {
    if (_currentIndex >= 0) {
      _commandHistory[_currentIndex].undo();
      _currentIndex--;
    }
  }

  void redo() {
    if (_currentIndex < _commandHistory.length - 1) {
      _currentIndex++;
      _commandHistory[_currentIndex].execute();
    }
  }

  bool get canUndo => _currentIndex >= 0;
  bool get canRedo => _currentIndex < _commandHistory.length - 1;
  List<String> get history => _commandHistory.map((c) => c.name).toList();
}
