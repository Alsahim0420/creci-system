import 'package:gof_patterns/gof_patterns.dart';
import 'package:test/test.dart';

void main() {
  test('Adapter traduce la API vieja a la interfaz nueva', () {
    final WeatherService service = WeatherAdapter();

    expect(service.getTemperature(), '25°C');
    expect(service.getHumidity(), '65%');
    expect(service.getWindSpeed(), '15 km/h');
  });

  test('Decorator acumula descripción y costo', () {
    // Arrange
    final Coffee coffee = SugarDecorator(MilkDecorator(SimpleCoffee()));

    // Act
    final description = coffee.getDescription();
    final cost = coffee.getCost();

    // Assert
    expect(description, 'Simple Coffee, Milk, Sugar');
    expect(cost, 2.75);
  });

  test('Facade orquesta los subsistemas en orden', () {
    // Arrange
    homeTheaterLog.clear();

    // Act
    HomeTheaterFacade().watchMovie();

    // Assert
    expect(homeTheaterLog.first, 'Lights dimmed');
    expect(homeTheaterLog.last, 'Resolution: 4K');
  });

  test('Proxy carga la imagen real solo al mostrarla', () {
    // Arrange
    final proxy = ProxyImage('photo.png', 10);
    expect(proxy.isLoaded, isFalse);

    // Act
    proxy.display();

    // Assert
    expect(proxy.isLoaded, isTrue);
    expect(proxy.getSize(), '10 MB');
  });
}
