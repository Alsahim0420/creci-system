// Complex subsystem classes
// Every subsystem writes to a shared log so the orchestration is observable.
final List<String> homeTheaterLog = [];

class AudioSystem {
  void on() => _log('Audio System ON');
  void off() => _log('Audio System OFF');
  void setVolume(int volume) => _log('Volume set to $volume');
  void _log(String msg) => homeTheaterLog.add(msg);
}

class VideoSystem {
  void on() => _log('Video System ON');
  void off() => _log('Video System OFF');
  void setResolution(String res) => _log('Resolution: $res');
  void _log(String msg) => homeTheaterLog.add(msg);
}

class LightingSystem {
  void dimLights() => _log('Lights dimmed');
  void brightLights() => _log('Lights brightened');
  void _log(String msg) => homeTheaterLog.add(msg);
}

class PopcornMaker {
  void on() => _log('Popcorn maker ON');
  void off() => _log('Popcorn maker OFF');
  void _log(String msg) => homeTheaterLog.add(msg);
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
