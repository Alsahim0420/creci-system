import 'package:flutter/material.dart';

// Observer interface
abstract class Observer {
  void update(String message);
}

// Concrete observers
class EmailSubscriber implements Observer {
  final String email;
  final ValueNotifier<String> lastMessage = ValueNotifier('No message');

  EmailSubscriber(this.email);

  @override
  void update(String message) {
    lastMessage.value = 'Email: $message';
  }
}

class SMSSubscriber implements Observer {
  final String phone;
  final ValueNotifier<String> lastMessage = ValueNotifier('No message');

  SMSSubscriber(this.phone);

  @override
  void update(String message) {
    lastMessage.value = 'SMS: $message';
  }
}

class PushNotificationSubscriber implements Observer {
  final String deviceId;
  final ValueNotifier<String> lastMessage = ValueNotifier('No message');

  PushNotificationSubscriber(this.deviceId);

  @override
  void update(String message) {
    lastMessage.value = 'Push: $message';
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

class ObserverExample extends StatefulWidget {
  const ObserverExample({Key? key}) : super(key: key);

  @override
  State<ObserverExample> createState() => _ObserverExampleState();
}

class _ObserverExampleState extends State<ObserverExample> {
  final NewsChannel _newsChannel = NewsChannel();
  final TextEditingController _newsController = TextEditingController();

  late EmailSubscriber _emailSub;
  late SMSSubscriber _smsSub;
  late PushNotificationSubscriber _pushSub;

  @override
  void initState() {
    super.initState();
    _emailSub = EmailSubscriber('user@email.com');
    _smsSub = SMSSubscriber('+1234567890');
    _pushSub = PushNotificationSubscriber('device-123');

    _newsChannel.subscribe(_emailSub);
    _newsChannel.subscribe(_smsSub);
    _newsChannel.subscribe(_pushSub);
  }

  @override
  void dispose() {
    _newsController.dispose();
    super.dispose();
  }

  void _publishNews() {
    if (_newsController.text.isNotEmpty) {
      _newsChannel.publishNews(_newsController.text);
      _newsController.clear();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Observer Pattern - Multiple objects listen to changes',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        Text(
          'Publish News:',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _newsController,
                decoration: InputDecoration(
                  hintText: 'Enter news...',
                  prefixIcon: const Icon(Icons.newspaper),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onSubmitted: (_) => _publishNews(),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: _publishNews,
              icon: const Icon(Icons.send),
              label: const Text('Publish'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          'Subscribers (Updated in Real-time):',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        ValueListenableBuilder<String>(
          valueListenable: _emailSub.lastMessage,
          builder: (context, message, _) => _buildSubscriberCard(
            'Email Subscriber',
            _emailSub.email,
            message,
            Icons.email,
            Colors.blue,
          ),
        ),
        const SizedBox(height: 8),
        ValueListenableBuilder<String>(
          valueListenable: _smsSub.lastMessage,
          builder: (context, message, _) => _buildSubscriberCard(
            'SMS Subscriber',
            _smsSub.phone,
            message,
            Icons.sms,
            Colors.green,
          ),
        ),
        const SizedBox(height: 8),
        ValueListenableBuilder<String>(
          valueListenable: _pushSub.lastMessage,
          builder: (context, message, _) => _buildSubscriberCard(
            'Push Notification Subscriber',
            _pushSub.deviceId,
            message,
            Icons.notifications,
            Colors.orange,
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
                  'When you publish news, all subscribers are notified automatically.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSubscriberCard(
    String title,
    String identifier,
    String message,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(
                    identifier,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: const TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }
}
