// Ejecuta: dart run example/main.dart
import 'package:gof_patterns/gof_patterns.dart';

void main() {
  _section('CREACIONALES');

  final logger = Logger()..log('App started');
  Logger().log('Same instance');
  print('Singleton  -> ${identical(logger, Logger())}, logs: ${logger.getLogs()}');

  final payment = PaymentFactory.createPayment('paypal');
  print('Factory    -> ${payment.name}: ${payment.description}');

  final pc = ComputerBuilder().setProcessor('M3').setRam('16GB').setGpu('RTX').build();
  print('Builder    -> ${pc.processor} / ${pc.ram} / ${pc.gpu}');

  for (final UIFactory factory in [LightThemeFactory(), DarkThemeFactory()]) {
    print('Abs.Factory-> ${factory.createButton().render()}');
  }

  _section('ESTRUCTURALES');

  final WeatherService weather = WeatherAdapter();
  print('Adapter    -> ${weather.getTemperature()}, ${weather.getHumidity()}');

  final Coffee coffee = WhipCreamDecorator(MilkDecorator(SimpleCoffee()));
  print('Decorator  -> ${coffee.getDescription()} = \$${coffee.getCost()}');

  HomeTheaterFacade().watchMovie();
  print('Facade     -> $homeTheaterLog');

  final image = ProxyImage('photo.png', 12);
  print('Proxy      -> loaded antes: ${image.isLoaded}');
  image.display();
  print('Proxy      -> loaded después: ${image.isLoaded}');

  _section('COMPORTAMENTALES');

  final chain = NotEmptyValidator();
  chain.setNext(MinLengthValidator()).setNext(AlphanumericValidator());
  for (final input in ['', 'abc', 'abc!!', 'pablo123']) {
    print('Chain      -> "$input": ${chain.validate(input) ?? 'OK'}');
  }

  final light = Light();
  final remote = RemoteControl()..execute(TurnOnCommand(light));
  remote.undo();
  print('Command    -> luz encendida tras undo: ${light.isOn}');

  final room = ChatRoom();
  User('Ana', room).send('Hola');
  User('Pablo', room).send('Qué tal');
  print('Mediator   -> ${room.getMessageLog().length} mensajes');

  final channel = NewsChannel();
  final email = EmailSubscriber('a@b.com');
  channel
    ..subscribe(email)
    ..publishNews('Nueva versión');
  print('Observer   -> ${email.lastMessage}');

  final order = Order()
    ..process()
    ..deliver();
  print('State      -> ${order.getState().name}');

  final cart = ShoppingCart()
    ..basePrice = 100
    ..setPricingStrategy(StudentDiscountStrategy());
  print('Strategy   -> ${cart.getStrategyName()}: ${cart.getTotalPrice()}');

  final csv = CSVProcessor()..process();
  print('Template   -> ${csv.getLogs()}');
}

void _section(String title) => print('\n=== $title ===');
