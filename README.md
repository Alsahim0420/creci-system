# 🏛️ CRECI System - GoF Design Patterns Showcase

**Una aplicación web interactiva en Flutter que muestra los 15 patrones GoF (Gang of Four) más prácticos.**

> **Objetivo:** Aprender arquitectura de software con ejemplos visuales e interactivos  
> **Público:** Desarrolladores en crecimiento (nivel Advanced → Senior)  
> **Plataforma:** Flutter Web  

---

## 🎯 ¿Qué es esto?

Una galería visual e **interactiva** de patrones de diseño donde:

- ✅ **Cada patrón está implementado con widgets de Flutter**
- ✅ **Puedes interactuar** con los ejemplos en tiempo real
- ✅ **Ves visualmente** cómo funciona cada patrón
- ✅ **Código fuente visible** para aprender la implementación
- ✅ **Explicaciones claras** de problema → solución → cuándo usar

### Ejemplos de lo que verás:

```
🔵 OBSERVER PATTERN
┌─────────────────────────────────┐
│ Input: [___________]            │  ← Escribe aquí
│                                 │
│ Observer 1: Actualizado ✅      │
│ Observer 2: Actualizado ✅      │  ← Se actualizan automáticamente
│ Observer 3: Actualizado ✅      │
└─────────────────────────────────┘

🟩 STATE PATTERN
┌─────────────────────────────────┐
│ Estado: [Pending] → [Processing] │
│         ✅      ✅      ✅      │  ← Cambia interactivamente
│ Permite: Cancel    No       No  │
└─────────────────────────────────┘

🟨 STRATEGY PATTERN
┌─────────────────────────────────┐
│ Precio: $100                    │
│ Estrategia: [Regular ▼]         │
│   - Regular:      $100          │  ← Cambia precio según estrategia
│   - BulkDiscount: $90           │
│   - VIP:          $70           │
└─────────────────────────────────┘
```

---

## 📁 Estructura del Proyecto

```
creci-system/
├── lib/
│   ├── main.dart ........................... Punto de entrada
│   │
│   ├── screens/
│   │   ├── home_screen.dart ............... Pantalla principal (galería)
│   │   ├── pattern_detail_screen.dart .... Detalles de cada patrón
│   │   └── navigation_drawer.dart ........ Navegación
│   │
│   ├── patterns/
│   │   ├── creational/
│   │   │   ├── singleton_example.dart .... Singleton interactivo
│   │   │   ├── factory_example.dart ...... Factory interactivo
│   │   │   ├── builder_example.dart ...... Builder interactivo
│   │   │   └── abstract_factory_example.dart
│   │   │
│   │   ├── structural/
│   │   │   ├── adapter_example.dart
│   │   │   ├── decorator_example.dart
│   │   │   ├── facade_example.dart
│   │   │   └── proxy_example.dart
│   │   │
│   │   └── behavioral/
│   │       ├── observer_example.dart .... Observer interactivo
│   │       ├── strategy_example.dart .... Strategy interactivo
│   │       ├── state_example.dart ....... State interactivo
│   │       ├── command_example.dart
│   │       ├── template_method_example.dart
│   │       ├── chain_example.dart
│   │       └── mediator_example.dart
│   │
│   ├── widgets/
│   │   ├── pattern_card.dart ............. Card para mostrar patrón
│   │   ├── code_viewer.dart ............. Visor de código
│   │   ├── pattern_description.dart ..... Descripción del patrón
│   │   └── interactive_demo.dart ........ Contenedor interactivo
│   │
│   ├── models/
│   │   ├── pattern_model.dart ........... Modelo de datos para patrón
│   │   └── example_data.dart ........... Datos de ejemplos
│   │
│   ├── themes/
│   │   └── app_theme.dart ............... Tema visual de la app
│   │
│   └── utils/
│       ├── constants.dart
│       └── colors.dart
│
├── web/
│   ├── index.html
│   ├── styles.css
│   └── main.dart.js
│
├── pubspec.yaml ........................... Dependencias
├── .gitignore ............................. Git ignore
├── PATTERNS.md ............................ Documentación de patrones
└── SETUP.md ............................... Instrucciones de instalación
```

---

## 🚀 Cómo Empezar

### 1. Clonar el Repositorio

```bash
git clone https://github.com/Alsahim0420/creci-system.git
cd creci-system
```

### 2. Instalar Dependencias

```bash
flutter pub get
```

### 3. Ejecutar en Web

```bash
flutter run -d chrome
# O para generar web
flutter build web
```

### 4. Abrir en Navegador

```
http://localhost:5000
```

---

## 📚 Los 15 Patrones GoF

### 🆕 CREACIONALES (4)
- **Singleton** - Una instancia única
- **Factory Method** - Crear tipos dinámicamente
- **Builder** - Construir paso a paso
- **Abstract Factory** - Familias de objetos

### 🔗 ESTRUCTURALES (4)
- **Adapter** - Traducir interfaces
- **Decorator** - Envolver con comportamiento
- **Facade** - Simplificar subsistema
- **Proxy** - Control de acceso

### 🎬 COMPORTAMENTALES (7) ⭐
- **Observer** - Notificar cambios
- **Strategy** - Algoritmos intercambiables
- **State** - Comportamiento por estado
- **Command** - Encapsular acciones
- **Template Method** - Estructura común
- **Chain of Responsibility** - Pasar entre handlers
- **Mediator** - Comunicación centralizada

---

## ✨ Características

### 🎨 Interfaz Visual
- Diseño limpio y moderno
- Tema claro/oscuro
- Responsive (funciona en desktop y móvil)
- Animaciones suaves

### 🔄 Interactividad
- Ejemplos ejecutables en vivo
- Puedes interactuar con los widgets
- Ver cambios en tiempo real
- Código ejecutable

### 📖 Educación
- Explicación clara de cada patrón
- Código fuente visible
- Casos de uso reales
- Cuándo (y cuándo no) usarlos

### 🔗 Galería Completa
- 15 patrones implementados
- Búsqueda por categoría
- Ejemplos comparativos
- Timeline de complejidad

---

## 🏗️ Arquitectura

```
┌─────────────────────────────┐
│   Flutter Web App           │ ← Lo que ves en el navegador
└──────────────┬──────────────┘
               │
        ┌──────▼──────┐
        │   Screens   │ ← HomeScreen, DetailScreen
        └──────┬──────┘
               │
        ┌──────▼──────────────┐
        │   Pattern Examples  │ ← Cada patrón con su demo
        │   (15 widgets)      │
        └──────┬──────────────┘
               │
        ┌──────▼──────────────┐
        │   Widgets Reusables │ ← PatternCard, CodeViewer, etc.
        └─────────────────────┘
```

---

## 💻 Stack Tecnológico

- **Flutter** - Framework UI multiplataforma
- **Dart** - Lenguaje de programación
- **Flutter Web** - Compilación a web
- **Provider** - State management (opcional)

---

## 📊 Estado del Proyecto

| Fase | Tarea | Estado |
|------|-------|--------|
| 1 | Estructura base | ✅ En progreso |
| 2 | Creacionales (4 patrones) | ⏳ Pendiente |
| 3 | Estructurales (4 patrones) | ⏳ Pendiente |
| 4 | Comportamentales (7 patrones) | ⏳ Pendiente |
| 5 | UI/UX completa | ⏳ Pendiente |
| 6 | Desplegar en web | ⏳ Pendiente |

---

## 🎓 Aprendizaje

Después de explorar esta galería, podrás:

- ✅ Entender qué resuelve cada patrón
- ✅ Reconocer patrones en código existente
- ✅ Implementar patrones correctamente
- ✅ Defender tus decisiones arquitectónicas
- ✅ Pasar de nivel 2/4 a 4/4 en Arquitectura

---

## 🔗 Git Workflow

```bash
# Ver estado
git status

# Agregar cambios
git add .

# Commit
git commit -m "feat(patterns): Add Observer pattern example"

# Subir
git push origin main
```

### Estructura de Commits

```
Initial: Project structure
Add: Creational patterns (Singleton, Factory, Builder, AbstractFactory)
Add: Structural patterns (Adapter, Decorator, Facade, Proxy)
Add: Behavioral patterns - Part 1 (Observer, Strategy, State, Command)
Add: Behavioral patterns - Part 2 (Template, Chain, Mediator)
Add: UI/UX improvements and responsive design
Add: Deploy to web
```

---

## 📞 Contacto & Recursos

- **Documentación de patrones:** Ver `PATTERNS.md`
- **Guía de instalación:** Ver `SETUP.md`
- **Referencia GoF:** https://refactoring.guru/design-patterns

---

## 📝 Licencia

MIT - Libre para usar, modificar y distribuir

---

**Creado por:** Claude + Pablo Melo  
**Proyecto:** PRAGMA - Plan de Crecimiento  
**Objetivo:** Dominar Patrones de Diseño  
**Versión:** 1.0.0

🚀 **¡Vamos a aprender arquitectura de software!**
