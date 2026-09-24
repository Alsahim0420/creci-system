import 'package:gof_patterns/gof_patterns.dart';
import 'package:test/test.dart';

void main() {
  group('Singleton', () {
    setUp(() => Logger().clear());

    test('siempre devuelve la misma instancia', () {
      // Arrange & Act
      final a = Logger();
      final b = Logger();

      // Assert
      expect(identical(a, b), isTrue);
    });

    test('comparte el estado entre referencias', () {
      // Arrange
      final a = Logger();

      // Act
      a.log('uno');
      Logger().log('dos');

      // Assert
      expect(a.getLogCount(), 2);
      expect(a.getLogs(), ['[1] uno', '[2] dos']);
    });
  });

  group('Factory Method', () {
    test('crea el tipo concreto según el parámetro', () {
      expect(PaymentFactory.createPayment('paypal'), isA<PayPalPayment>());
      expect(PaymentFactory.createPayment('applepay'), isA<ApplePayPayment>());
    });

    test('usa tarjeta de crédito por defecto', () {
      expect(PaymentFactory.createPayment('bitcoin'), isA<CreditCardPayment>());
    });
  });

  group('Builder', () {
    test('respeta los valores por defecto y los personalizados', () {
      // Arrange
      final builder = ComputerBuilder().setRam('32GB').setWifi(false);

      // Act
      final pc = builder.build();

      // Assert
      expect(pc.processor, 'Intel i5');
      expect(pc.ram, '32GB');
      expect(pc.hasWifi, isFalse);
    });
  });

  group('Abstract Factory', () {
    test('cada fábrica crea una familia coherente', () {
      final light = LightThemeFactory();
      final dark = DarkThemeFactory();

      expect(light.createButton(), isA<LightButton>());
      expect(light.createTextField(), isA<LightTextField>());
      expect(dark.createButton(), isA<DarkButton>());
      expect(dark.createTextField(), isA<DarkTextField>());
    });
  });
}
