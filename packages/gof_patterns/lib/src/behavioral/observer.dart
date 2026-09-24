// Observer interface
abstract class Observer {
  void update(String message);
}

// Concrete observers
class EmailSubscriber implements Observer {
  final String email;
  String lastMessage = 'No message';

  EmailSubscriber(this.email);

  @override
  void update(String message) {
    lastMessage = 'Email: $message';
  }
}

class SMSSubscriber implements Observer {
  final String phone;
  String lastMessage = 'No message';

  SMSSubscriber(this.phone);

  @override
  void update(String message) {
    lastMessage = 'SMS: $message';
  }
}

class PushNotificationSubscriber implements Observer {
  final String deviceId;
  String lastMessage = 'No message';

  PushNotificationSubscriber(this.deviceId);

  @override
  void update(String message) {
    lastMessage = 'Push: $message';
  }
}

// Subject
class NewsChannel {
  final List<Observer> _observers = [];

  void subscribe(Observer observer) {
    _observers.add(observer);
  }

  void unsubscribe(Observer observer) {
    _observers.remove(observer);
  }

  void publishNews(String news) {
    for (var observer in _observers) {
      observer.update(news);
    }
  }
}
