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
