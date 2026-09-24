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
