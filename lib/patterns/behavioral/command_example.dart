import 'package:flutter/material.dart';

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

class CommandExample extends StatefulWidget {
  const CommandExample({Key? key}) : super(key: key);

  @override
  State<CommandExample> createState() => _CommandExampleState();
}

class _CommandExampleState extends State<CommandExample> {
  final Light _light = Light();
  final RemoteControl _remote = RemoteControl();

  void _executeCommand(Command command) {
    _remote.execute(command);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Command Pattern - Encapsulate requests as objects',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _light.isOn ? Colors.yellow.withAlpha(20) : Colors.grey.withAlpha(20),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _light.isOn ? Colors.yellow : Colors.grey,
            ),
          ),
          child: Row(
            children: [
              Icon(
                _light.isOn ? Icons.lightbulb : Icons.lightbulb_outline,
                size: 32,
                color: _light.isOn ? Colors.yellow : Colors.grey,
              ),
              const SizedBox(width: 12),
              Text(
                _light.isOn ? 'Light is ON' : 'Light is OFF',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Remote Control:',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: () => _executeCommand(TurnOnCommand(_light)),
              icon: const Icon(Icons.power_settings_new),
              label: const Text('ON'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: () => _executeCommand(TurnOffCommand(_light)),
              icon: const Icon(Icons.power_settings_new),
              label: const Text('OFF'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: _remote.canUndo
                  ? () {
                      _remote.undo();
                      setState(() {});
                    }
                  : null,
              icon: const Icon(Icons.undo),
              label: const Text('Undo'),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: _remote.canRedo
                  ? () {
                      _remote.redo();
                      setState(() {});
                    }
                  : null,
              icon: const Icon(Icons.redo),
              label: const Text('Redo'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'History (${_remote.history.length}):',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey.withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: _remote.history.isEmpty
              ? Center(
                  child: Text(
                    'No commands executed yet',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: _remote.history.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      '${index + 1}. ${_remote.history[index]}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
