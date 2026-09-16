import 'package:flutter/material.dart';

// Complex subsystem classes
class AudioSystem {
  void on() => _log('Audio System ON');
  void off() => _log('Audio System OFF');
  void setVolume(int volume) => _log('Volume set to $volume');
  void _log(String msg) {}
}

class VideoSystem {
  void on() => _log('Video System ON');
  void off() => _log('Video System OFF');
  void setResolution(String res) => _log('Resolution: $res');
  void _log(String msg) {}
}

class LightingSystem {
  void dimLights() => _log('Lights dimmed');
  void brightLights() => _log('Lights brightened');
  void _log(String msg) {}
}

class PopcornMaker {
  void on() => _log('Popcorn maker ON');
  void off() => _log('Popcorn maker OFF');
  void _log(String msg) {}
}

// Facade - Simple interface for complex subsystem
class HomeTheaterFacade {
  final AudioSystem _audio = AudioSystem();
  final VideoSystem _video = VideoSystem();
  final LightingSystem _lighting = LightingSystem();
  final PopcornMaker _popcorn = PopcornMaker();

  void watchMovie() {
    _lighting.dimLights();
    _popcorn.on();
    _audio.on();
    _audio.setVolume(12);
    _video.on();
    _video.setResolution('4K');
  }

  void endMovie() {
    _audio.off();
    _video.off();
    _popcorn.off();
    _lighting.brightLights();
  }
}

class FacadeExample extends StatefulWidget {
  const FacadeExample({Key? key}) : super(key: key);

  @override
  State<FacadeExample> createState() => _FacadeExampleState();
}

class _FacadeExampleState extends State<FacadeExample> {
  final HomeTheaterFacade _theater = HomeTheaterFacade();
  final List<String> _logs = [];
  bool _isMoviePlaying = false;

  void _addLog(String message) {
    setState(() => _logs.insert(0, '• $message'));
  }

  void _playMovie() {
    setState(() => _isMoviePlaying = true);
    _addLog('Setting up home theater for movie...');
    _addLog('Dimming lights');
    _addLog('Turning on popcorn maker');
    _addLog('Initializing audio system - Volume 12');
    _addLog('Starting video in 4K');
    _theater.watchMovie();
  }

  void _stopMovie() {
    setState(() => _isMoviePlaying = false);
    _addLog('Shutting down home theater...');
    _addLog('Turning off audio');
    _addLog('Turning off video');
    _addLog('Stopping popcorn maker');
    _addLog('Brightening lights');
    _theater.endMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Facade Pattern - Simplify complex subsystem',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        Text(
          'Home Theater System (complex subsystem hidden)',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: _isMoviePlaying ? null : _playMovie,
              icon: const Icon(Icons.play_arrow),
              label: const Text('Play Movie'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: _isMoviePlaying ? _stopMovie : null,
              icon: const Icon(Icons.stop),
              label: const Text('Stop Movie'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (_isMoviePlaying)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withAlpha(20),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                const SizedBox(width: 12),
                const Text('Movie playing...'),
              ],
            ),
          ),
        const SizedBox(height: 16),
        Text(
          'System Activities:',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey.withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: _logs.isEmpty
              ? Center(
                  child: Text(
                    'Click "Play Movie" to start the theater system',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: _logs.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      _logs[index],
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
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
                  'Facade provides simple interface (playMovie/endMovie) to hide complexity of 4 subsystems.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
