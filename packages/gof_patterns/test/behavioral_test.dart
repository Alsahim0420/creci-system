import 'package:gof_patterns/gof_patterns.dart';
import 'package:test/test.dart';

void main() {
  group('Chain of Responsibility', () {
    late Validator chain;

    setUp(() {
      chain = NotEmptyValidator();
      chain.setNext(MinLengthValidator()).setNext(AlphanumericValidator());
    });

    test('devuelve el error del primer eslabón que falla', () {
      expect(chain.validate(''), '[Error] Empty string not allowed');
      expect(chain.validate('abc'), '[Error] String too short');
      expect(chain.validate('abc!!'),
          '[Error] Only alphanumeric characters allowed');
    });

    test('devuelve null cuando toda la cadena aprueba', () {
      expect(chain.validate('pablo123'), isNull);
    });
  });

  group('Command', () {
    test('permite undo y redo', () {
      // Arrange
      final light = Light();
      final remote = RemoteControl();

      // Act & Assert
      remote.execute(TurnOnCommand(light));
      expect(light.isOn, isTrue);

      remote.undo();
      expect(light.isOn, isFalse);
      expect(remote.canRedo, isTrue);

      remote.redo();
      expect(light.isOn, isTrue);
    });

    test('un comando nuevo descarta el historial de redo', () {
      final light = Light();
      final remote = RemoteControl()
        ..execute(TurnOnCommand(light))
        ..undo()
        ..execute(TurnOffCommand(light));

      expect(remote.canRedo, isFalse);
      expect(remote.history, ['Turn Off Light']);
    });
  });

  test('Mediator centraliza los mensajes de los usuarios', () {
    final room = ChatRoom();
    User('Ana', room).send('Hola');
    User('Pablo', room).send('Hey');

    final log = room.getMessageLog();
    expect(log, hasLength(2));
    expect(log.last, endsWith('Pablo: Hey'));
  });

  test('Observer notifica solo a los suscritos', () {
    // Arrange
    final channel = NewsChannel();
    final email = EmailSubscriber('a@b.com');
    final sms = SMSSubscriber('300');
    channel
      ..subscribe(email)
      ..subscribe(sms)
      ..unsubscribe(sms);

    // Act
    channel.publishNews('Breaking');

    // Assert
    expect(email.lastMessage, 'Email: Breaking');
    expect(sms.lastMessage, 'No message');
  });

  test('State solo permite transiciones válidas', () {
    final order = Order();

    order.deliver(); // no permitido desde Pending
    expect(order.getState(), isA<PendingState>());

    order
      ..process()
      ..deliver();
    expect(order.getState(), isA<DeliveredState>());
  });

  test('Strategy cambia el cálculo en tiempo de ejecución', () {
    final cart = ShoppingCart()..basePrice = 100;

    expect(cart.getTotalPrice(), 100);
    cart.setPricingStrategy(BulkDiscountStrategy());
    expect(cart.getTotalPrice(), 70);
  });

  test('Template Method ejecuta los pasos en orden fijo', () {
    final processor = JSONProcessor()..process();

    expect(processor.getLogs(), [
      '✓ Reading JSON file...',
      '✓ Validating JSON schema...',
      '✓ Transforming JSON to objects...',
      '✓ Saving to database...',
    ]);
  });
}
