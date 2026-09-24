# 🚀 Getting Started with CRECI System

## Prerequisites

Make sure you have Flutter installed:

```bash
flutter --version
```

If not installed, download from: https://flutter.dev

## Quick Start

### 1. Get Dependencies

```bash
flutter pub get
```

### 2. Run on Web

```bash
flutter run -d chrome
```

Or build for web:

```bash
flutter build web
```

### 3. Run on Mobile/Tablet

```bash
flutter run
```

## Project Structure

```
creci-system/
├── lib/
│   ├── main.dart ............................ App entry point & routing
│   ├── screens/
│   │   ├── home_screen.dart ................ Gallery with all 15 patterns
│   │   └── pattern_detail_screen.dart ..... Detail view for each pattern
│   ├── themes/
│   │   └── app_theme.dart ................. Material Design 3 theming
│   └── patterns/
│       ├── creational/
│       │   ├── singleton_example.dart
│       │   ├── factory_example.dart
│       │   ├── builder_example.dart
│       │   └── abstract_factory_example.dart
│       ├── structural/
│       │   ├── adapter_example.dart
│       │   ├── decorator_example.dart
│       │   ├── facade_example.dart
│       │   └── proxy_example.dart
│       └── behavioral/
│           ├── observer_example.dart
│           ├── strategy_example.dart
│           ├── state_example.dart
│           ├── command_example.dart
│           ├── template_method_example.dart
│           ├── chain_example.dart
│           └── mediator_example.dart
├── web/
│   ├── index.html .......................... Web entry point
│   └── manifest.json ....................... PWA manifest
├── pubspec.yaml ............................ Dependencies
└── README.md ............................... Full documentation
```

## Features Implemented

✅ **Complete Gallery System**
- All 15 GoF patterns in interactive gallery
- Search functionality
- Filter by category (Creational/Structural/Behavioral)
- Pattern count indicator

✅ **Detailed Pattern Views**
- Problem description
- Solution explanation
- Real-world use cases
- Interactive demonstrations

✅ **Interactive Examples**
- Singleton: Logger with activity tracking
- Factory: Dynamic payment method selection
- Builder: Computer configuration builder
- Abstract Factory: Theme switching (light/dark)
- Adapter: Old API to new interface translation
- Decorator: Coffee customization with pricing
- Facade: Home theater system
- Proxy: Lazy image loading
- Observer: Real-time subscriber notifications
- Strategy: Dynamic pricing strategies
- State: Order state machine
- Command: Undo/Redo with light control
- Template Method: Different file processor implementations
- Chain: Validation chain
- Mediator: Chat room communication

✅ **Design System**
- Material Design 3
- Light & Dark themes
- Category-specific colors:
  - Creational: Purple (#9C27B0)
  - Structural: Blue (#2196F3)
  - Behavioral: Green (#4CAF50)
- Responsive design (1-4 columns based on screen size)

## Development Workflow

### Add New Features

1. Create feature branch: `git checkout -b feature/your-feature`
2. Make changes
3. Test on web and mobile
4. Commit: `git commit -m "feat: description"`
5. Push: `git push origin feature/your-feature`

### Commit Conventions

```
feat:     New feature
fix:      Bug fix
refactor: Code refactoring
style:    Code style changes
docs:     Documentation
test:     Test changes
```

## Troubleshooting

### Flutter not found
```bash
export PATH="$PATH:$(pwd)/flutter/bin"
```

### Port already in use (web)
```bash
flutter run -d chrome --web-port=5001
```

### Clean build
```bash
flutter clean
flutter pub get
flutter run
```

## Resources

- **GoF Patterns**: https://refactoring.guru/design-patterns
- **Flutter Docs**: https://flutter.dev/docs
- **Dart Docs**: https://dart.dev/guides
- **Material Design 3**: https://m3.material.io/

## Next Steps

1. ✅ Initial project structure
2. ✅ All 15 patterns implemented
3. ✅ Interactive examples for each pattern
4. 🔄 Deploy to Firebase Hosting / Vercel
5. 🔄 Add more advanced pattern demonstrations
6. 🔄 Add code syntax highlighting viewer
7. 🔄 Create video tutorials for each pattern

---

**Project**: CRECI System - GoF Design Patterns Showcase  
**Purpose**: Learn and master design patterns through interactive examples  
**Target**: Advanced developers aiming to reach Senior level  
**Language**: Dart/Flutter  
**Version**: 1.0.0
