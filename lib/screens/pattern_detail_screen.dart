import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../themes/app_theme.dart';
import '../patterns/creational/singleton_example.dart';
import '../patterns/creational/factory_example.dart';
import '../patterns/creational/builder_example.dart';
import '../patterns/creational/abstract_factory_example.dart';
import '../patterns/structural/adapter_example.dart';
import '../patterns/structural/decorator_example.dart';
import '../patterns/structural/facade_example.dart';
import '../patterns/structural/proxy_example.dart';
import '../patterns/behavioral/observer_example.dart';
import '../patterns/behavioral/strategy_example.dart';
import '../patterns/behavioral/state_example.dart';
import '../patterns/behavioral/command_example.dart';
import '../patterns/behavioral/template_method_example.dart';
import '../patterns/behavioral/chain_example.dart';
import '../patterns/behavioral/mediator_example.dart';

class PatternDetailScreen extends StatelessWidget {
  final String patternId;

  const PatternDetailScreen({
    Key? key,
    required this.patternId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Pattern Details'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                _getPatternName(patternId),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Pattern Info Section
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: _buildPatternInfo(patternId, context),
            ),

            // Interactive Demo Section
            Container(
              color: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Interactive Demo',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(height: 16),
                  _buildInteractiveDemo(patternId),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPatternInfo(String patternId, BuildContext context) {
    final info = _getPatternInfo(patternId);
    final categoryColor = _getCategoryColor(patternId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: categoryColor.withAlpha(30),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: categoryColor, width: 2),
          ),
          child: Text(
            _getCategoryName(patternId),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: categoryColor,
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Problem Section
        _buildSection('Problem', info['problem'], context, categoryColor),

        const SizedBox(height: 20),

        // Solution Section
        _buildSection('Solution', info['solution'], context, categoryColor),

        const SizedBox(height: 20),

        // Use Cases Section
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Use Cases',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: categoryColor),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: (info['useCases'] as List<String>)
                  .map((useCase) => Chip(
                        label: Text(useCase),
                        backgroundColor: categoryColor.withAlpha(20),
                        side: BorderSide(color: categoryColor),
                      ))
                  .toList(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSection(
    String title,
    String content,
    BuildContext context,
    Color categoryColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: categoryColor),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: categoryColor.withAlpha(10),
            borderLeft: BorderSide(color: categoryColor, width: 4),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            content,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }

  Widget _buildInteractiveDemo(String patternId) {
    switch (patternId) {
      case 'singleton':
        return const SingletonExample();
      case 'factory':
        return const FactoryExample();
      case 'builder':
        return const BuilderExample();
      case 'abstract_factory':
        return const AbstractFactoryExample();
      case 'adapter':
        return const AdapterExample();
      case 'decorator':
        return const DecoratorExample();
      case 'facade':
        return const FacadeExample();
      case 'proxy':
        return const ProxyExample();
      case 'observer':
        return const ObserverExample();
      case 'strategy':
        return const StrategyExample();
      case 'state':
        return const StateExample();
      case 'command':
        return const CommandExample();
      case 'template_method':
        return const TemplateMethodExample();
      case 'chain':
        return const ChainExample();
      case 'mediator':
        return const MediatorExample();
      default:
        return const Text('Pattern not found');
    }
  }

  String _getPatternName(String patternId) {
    const names = {
      'singleton': 'Singleton',
      'factory': 'Factory Method',
      'builder': 'Builder',
      'abstract_factory': 'Abstract Factory',
      'adapter': 'Adapter',
      'decorator': 'Decorator',
      'facade': 'Facade',
      'proxy': 'Proxy',
      'observer': 'Observer',
      'strategy': 'Strategy',
      'state': 'State',
      'command': 'Command',
      'template_method': 'Template Method',
      'chain': 'Chain of Responsibility',
      'mediator': 'Mediator',
    };
    return names[patternId] ?? 'Pattern';
  }

  String _getCategoryName(String patternId) {
    const creational = [
      'singleton',
      'factory',
      'builder',
      'abstract_factory'
    ];
    const structural = ['adapter', 'decorator', 'facade', 'proxy'];

    if (creational.contains(patternId)) {
      return 'Creational';
    } else if (structural.contains(patternId)) {
      return 'Structural';
    } else {
      return 'Behavioral';
    }
  }

  Color _getCategoryColor(String patternId) {
    const creational = [
      'singleton',
      'factory',
      'builder',
      'abstract_factory'
    ];
    const structural = ['adapter', 'decorator', 'facade', 'proxy'];

    if (creational.contains(patternId)) {
      return AppTheme.creationalColor;
    } else if (structural.contains(patternId)) {
      return AppTheme.structuralColor;
    } else {
      return AppTheme.behavioralColor;
    }
  }

  Map<String, dynamic> _getPatternInfo(String patternId) {
    final patterns = {
      'singleton': {
        'problem': 'Necesitas que solo exista UNA instancia de algo (Logger, DB, API Client)',
        'solution': 'Un patrón que controla la instantiación para asegurar una única instancia',
        'useCases': ['Logger', 'DatabaseManager', 'ApiClient', 'ConfigManager'],
      },
      'factory': {
        'problem':
            'Tienes múltiples tipos de objetos similares y no quieres que el cliente conozca los detalles',
        'solution': 'Una fábrica decide qué tipo crear basado en parámetros',
        'useCases': ['OrderFactory', 'PaymentFactory', 'UserProvider', 'DialogFactory'],
      },
      'builder': {
        'problem': 'Objetos con muchos parámetros, muchos opcionales',
        'solution':
            'Un builder que añade parámetros uno por uno de forma legible',
        'useCases': ['ComplexOrderBuilder', 'UIBuilder', 'QueryBuilder', 'HTTPRequestBuilder'],
      },
      'abstract_factory': {
        'problem': 'UI diferente por tema (Light/Dark) pero misma lógica',
        'solution': 'Una fábrica de fábricas que genera familias completas',
        'useCases': ['UIThemeFactory', 'PlatformFactory', 'DatabaseFactory'],
      },
      'adapter': {
        'problem': 'Tienes API vieja con interface rara, necesitas interface nueva',
        'solution': 'Un adaptador traduce entre ambas interfaces',
        'useCases': ['PaymentAdapter', 'LegacyAPIAdapter', 'ThirdPartyIntegration'],
      },
      'decorator': {
        'problem':
            'Quieres añadir responsabilidades dinámicamente sin explosión de subclases',
        'solution': 'Decora el objeto con componentes adicionales',
        'useCases': ['CoffeeDecorator (Milk, Sugar)', 'UIDecorator', 'LoggingDecorator'],
      },
      'facade': {
        'problem': 'Subsistema con 10+ clases, no quieres que otros las usen directamente',
        'solution': 'Una Facade simplifica el acceso',
        'useCases': ['AppFacade', 'DatabaseFacade', 'PaymentGatewayFacade'],
      },
      'proxy': {
        'problem': 'Necesitas lazy loading, logging o control de acceso',
        'solution': 'Un proxy se interpone entre cliente y objeto real',
        'useCases': ['ImageProxy', 'RepositoryProxy', 'APIClientProxy'],
      },
      'observer': {
        'problem': 'Cuando cambia algo, muchas pantallas deben actualizarse',
        'solution': 'El objeto cambiante "avisa" a los que están escuchando',
        'useCases': ['OrderObserver', 'LiveData', 'StateNotifier', 'ChangeNotifier'],
      },
      'strategy': {
        'problem': 'Múltiples formas de hacer lo mismo, elige en tiempo de ejecución',
        'solution': 'Cada estrategia es una clase separada',
        'useCases': ['PricingStrategy', 'PaymentStrategy', 'SortingStrategy'],
      },
      'state': {
        'problem': 'Objeto se comporta diferente según su estado',
        'solution': 'Cada estado es una clase separada',
        'useCases': ['OrderState (Pending/Processing/Completed)', 'ConnectionState'],
      },
      'command': {
        'problem': 'Necesitas undo/redo, queue de acciones, scheduled tasks',
        'solution': 'Cada acción es un objeto Command',
        'useCases': ['UndoRedoCommand', 'TaskQueue', 'MacroCommand'],
      },
      'template_method': {
        'problem': 'Múltiples clases con estructura similar',
        'solution': 'Clase base define estructura, subclases implementan detalles',
        'useCases': ['DataSyncProcess', 'ReportGenerator', 'DataParser'],
      },
      'chain': {
        'problem': 'Validación o procesamiento en múltiples niveles',
        'solution': 'Cada handler decide: ¿yo la proceso o la paso?',
        'useCases': ['ValidatorChain', 'LoggerChain', 'RequestHandler'],
      },
      'mediator': {
        'problem': 'Muchos objetos se comunican entre sí → complejidad total',
        'solution': 'Un mediador central maneja toda la comunicación',
        'useCases': ['ChatRoom', 'DialogMediator', 'EventBus'],
      },
    };

    return patterns[patternId] ??
        {
          'problem': 'Pattern not found',
          'solution': 'Pattern not found',
          'useCases': [],
        };
  }
}
