# CRECI System

Workspace de práctica para el plan de crecimiento **Advanced → Senior** (Chapter Móvil, Pragma).
Cada tema del plan vive como un paquete independiente en `packages/`.

## Paquetes

| Paquete | Tema del mapa de crecimiento | Tipo |
| :-- | :-- | :-- |
| [`gof_patterns`](packages/gof_patterns) | Arquitectura: patrones y principios (GoF) | Dart puro |

## Estructura

```
creci-system/
├── pubspec.yaml            ← raíz del workspace (lista los paquetes)
└── packages/
    └── gof_patterns/
        ├── lib/gof_patterns.dart         ← API pública (exports)
        ├── lib/src/creational/           Singleton, Factory Method, Builder, Abstract Factory
        ├── lib/src/structural/           Adapter, Decorator, Facade, Proxy
        ├── lib/src/behavioral/           Chain, Command, Mediator, Observer, State, Strategy, Template Method
        ├── example/main.dart             ← demo por consola de todos los patrones
        └── test/                         ← un archivo por categoría (patrón AAA)
```

## Uso

```bash
dart pub get                      # resuelve todo el workspace desde la raíz

cd packages/gof_patterns
dart run example/main.dart        # ejecuta la demo por consola
dart test                         # corre los tests
dart analyze                      # lints
```

## Agregar un paquete nuevo

1. Crear `packages/<nombre>/pubspec.yaml` con `resolution: workspace`.
2. Añadir `packages/<nombre>` a la lista `workspace:` del `pubspec.yaml` raíz.
3. `dart pub get` en la raíz.
