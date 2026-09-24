import 'package:flutter/material.dart';

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

class AdapterExample extends StatefulWidget {
  const AdapterExample({Key? key}) : super(key: key);

  @override
  State<AdapterExample> createState() => _AdapterExampleState();
}

class _AdapterExampleState extends State<AdapterExample> {
  final WeatherService _weather = WeatherAdapter();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Adapter Pattern - Makes incompatible interfaces compatible',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.cyan.withAlpha(20),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.cyan),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Weather Data (adapted from old API):',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              _buildWeatherItem(
                'Temperature',
                _weather.getTemperature(),
                Icons.thermostat,
                Colors.red,
              ),
              const SizedBox(height: 12),
              _buildWeatherItem(
                'Humidity',
                _weather.getHumidity(),
                Icons.water_drop,
                Colors.blue,
              ),
              const SizedBox(height: 12),
              _buildWeatherItem(
                'Wind Speed',
                _weather.getWindSpeed(),
                Icons.air,
                Colors.lightBlue,
              ),
            ],
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
                  'The adapter translates between old incompatible API and new interface.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherItem(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Row(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
