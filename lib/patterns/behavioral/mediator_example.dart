import 'package:flutter/material.dart';

// Mediator
abstract class ChatMediator {
  void sendMessage(String message, User user);
  void addUser(User user);
}

// Concrete mediator
class ChatRoom implements ChatMediator {
  final List<User> _users = [];
  final List<String> _messageLog = [];

  @override
  void addUser(User user) {
    _users.add(user);
  }

  @override
  void sendMessage(String message, User user) {
    final timestamp = DateTime.now().toString().split('.')[0];
    _messageLog.add('[$timestamp] ${user.name}: $message');
  }

  List<String> getMessageLog() => List.from(_messageLog);
}

// Colleague
class User {
  final String name;
  final ChatMediator _mediator;

  User(this.name, this._mediator);

  void send(String message) {
    _mediator.sendMessage(message, this);
  }
}

class MediatorExample extends StatefulWidget {
  const MediatorExample({Key? key}) : super(key: key);

  @override
  State<MediatorExample> createState() => _MediatorExampleState();
}

class _MediatorExampleState extends State<MediatorExample> {
  late ChatRoom _chatRoom;
  late User _alice;
  late User _bob;
  late User _charlie;
  final TextEditingController _messageController = TextEditingController();
  String _currentUser = 'Alice';

  @override
  void initState() {
    super.initState();
    _chatRoom = ChatRoom();
    _alice = User('Alice', _chatRoom);
    _bob = User('Bob', _chatRoom);
    _charlie = User('Charlie', _chatRoom);
    _chatRoom.addUser(_alice);
    _chatRoom.addUser(_bob);
    _chatRoom.addUser(_charlie);
  }

  void _sendMessage() {
    if (_messageController.text.isEmpty) return;

    User sender;
    switch (_currentUser) {
      case 'Alice':
        sender = _alice;
        break;
      case 'Bob':
        sender = _bob;
        break;
      case 'Charlie':
        sender = _charlie;
        break;
      default:
        sender = _alice;
    }

    sender.send(_messageController.text);
    _messageController.clear();
    setState(() {});
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mediator Pattern - Centralize object communication',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        Text(
          'Select User:',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: ['Alice', 'Bob', 'Charlie']
              .map((name) => FilterChip(
                    label: Text(name),
                    selected: _currentUser == name,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _currentUser = name);
                      }
                    },
                  ))
              .toList(),
        ),
        const SizedBox(height: 16),
        Text(
          'Chat Room:',
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
            border: Border.all(color: Colors.grey),
          ),
          child: _chatRoom.getMessageLog().isEmpty
              ? Center(
                  child: Text(
                    'No messages yet',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: _chatRoom.getMessageLog().length,
                  itemBuilder: (context, index) {
                    final message = _chatRoom.getMessageLog()[index];
                    final isFromCurrentUser = message.contains(_currentUser);
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Align(
                        alignment: isFromCurrentUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isFromCurrentUser
                                ? Colors.blue.withAlpha(30)
                                : Colors.grey.withAlpha(30),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            message,
                            style: const TextStyle(fontSize: 11),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Type message...',
                  prefixIcon: const Icon(Icons.message),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: _sendMessage,
              icon: const Icon(Icons.send),
              label: const Text('Send'),
            ),
          ],
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
                  'ChatRoom mediator handles all communication between users instead of direct messaging.',
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
