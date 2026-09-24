// Subject interface
abstract class Image {
  void display();
  String getSize();
}

// Real subject - expensive to create
class RealImage implements Image {
  final String filename;
  final int _sizeInMB;
  bool _loaded = false;

  RealImage(this.filename, this._sizeInMB);

  void _load() {
    _loaded = true;
  }

  @override
  void display() {
    if (!_loaded) _load();
  }

  @override
  String getSize() => '$_sizeInMB MB';
}

// Proxy - controls access to real image
class ProxyImage implements Image {
  final String _filename;
  final int _sizeInMB;
  RealImage? _realImage;

  ProxyImage(this._filename, this._sizeInMB);

  @override
  void display() {
    _realImage ??= RealImage(_filename, _sizeInMB);
    _realImage!.display();
  }

  @override
  String getSize() => '$_sizeInMB MB';

  bool get isLoaded => _realImage != null;
}
