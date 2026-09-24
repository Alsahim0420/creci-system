// Old API - incompatible interface
class OldWeatherAPI {
  Map<String, dynamic> getWeatherData() {
    return {
      'temp_celsius': 25,
      'humidity_percent': 65,
      'wind_speed_kmh': 15,
    };
  }
}

// New interface expected by app
abstract class WeatherService {
  String getTemperature();
  String getHumidity();
  String getWindSpeed();
}

// Adapter - makes old API compatible with new interface
class WeatherAdapter implements WeatherService {
  final OldWeatherAPI _oldAPI = OldWeatherAPI();

  @override
  String getTemperature() {
    final data = _oldAPI.getWeatherData();
    return '${data['temp_celsius']}°C';
  }

  @override
  String getHumidity() {
    final data = _oldAPI.getWeatherData();
    return '${data['humidity_percent']}%';
  }

  @override
  String getWindSpeed() {
    final data = _oldAPI.getWeatherData();
    return '${data['wind_speed_kmh']} km/h';
  }
}
