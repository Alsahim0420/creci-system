import 'package:flutter/material.dart';

// States
abstract class OrderState {
  String get name;
  bool get canCancel;
  bool get canProcess;
  bool get canDeliver;
}

class PendingState implements OrderState {
  @override
  String get name => 'Pending';
  @override
  bool get canCancel => true;
  @override
  bool get canProcess => true;
  @override
  bool get canDeliver => false;
}

class ProcessingState implements OrderState {
  @override
  String get name => 'Processing';
  @override
  bool get canCancel => false;
  @override
  bool get canProcess => false;
  @override
  bool get canDeliver => true;
}

class DeliveredState implements OrderState {
  @override
  String get name => 'Delivered';
  @override
  bool get canCancel => false;
  @override
  bool get canProcess => false;
  @override
  bool get canDeliver => false;
}

class Order {
  late OrderState _state;

  Order() {
    _state = PendingState();
  }

  void process() {
    if (_state.canProcess) {
      _state = ProcessingState();
    }
  }

  void deliver() {
    if (_state.canDeliver) {
      _state = DeliveredState();
    }
  }

  void cancel() {
    if (_state.canCancel) {
      _state = PendingState();
    }
  }

  OrderState getState() => _state;
}

class StateExample extends StatefulWidget {
  const StateExample({Key? key}) : super(key: key);

  @override
  State<StateExample> createState() => _StateExampleState();
}

class _StateExampleState extends State<StateExample> {
  final Order _order = Order();

  void _updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'State Pattern - Behavior changes with state',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.purple.withAlpha(20),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.purple),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Current Order State:',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              Text(
                _order.getState().name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.purple,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Available Actions:',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        Column(
          children: [
            if (_order.getState().canProcess)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _order.process();
                    _updateState();
                  },
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Start Processing'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                ),
              )
            else
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.lock, size: 16),
                    SizedBox(width: 8),
                    Text('Cannot process in this state'),
                  ],
                ),
              ),
            const SizedBox(height: 8),
            if (_order.getState().canDeliver)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _order.deliver();
                    _updateState();
                  },
                  icon: const Icon(Icons.local_shipping),
                  label: const Text('Deliver'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),
              )
            else
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.lock, size: 16),
                    SizedBox(width: 8),
                    Text('Cannot deliver in this state'),
                  ],
                ),
              ),
            const SizedBox(height: 8),
            if (_order.getState().canCancel)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _order.cancel();
                    _updateState();
                  },
                  icon: const Icon(Icons.close),
                  label: const Text('Cancel'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                ),
              )
            else
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.lock, size: 16),
                    SizedBox(width: 8),
                    Text('Cannot cancel in this state'),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}
