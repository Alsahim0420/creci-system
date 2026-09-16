import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../themes/app_theme.dart';

class PatternInfo {
  final String id;
  final String name;
  final String category;
  final Color categoryColor;
  final String description;
  final String problem;
  final String solution;
  final List<String> useCases;
  final IconData icon;

  PatternInfo({
    required this.id,
    required this.name,
    required this.category,
    required this.categoryColor,
    required this.description,
    required this.problem,
    required this.solution,
    required this.useCases,
    required this.icon,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';
  String searchQuery = '';

  final List<PatternInfo> patterns = [
    // CREACIONALES
    PatternInfo(
      id: 'singleton',
      name: 'Singleton',
      category: 'Creational',
      categoryColor: AppTheme.creationalColor,
      description: 'Garantiza una única instancia de una clase',
      problem: 'Necesitas que solo exista UNA instancia de algo (Logger, DB, API Client)',
      solution: 'Un patrón que controla la instantiación para asegurar una única instancia',
      useCases: ['Logger', 'DatabaseManager', 'ApiClient', 'ConfigManager'],
      icon: Icons.lock,
    ),
    PatternInfo(
      id: 'factory',
      name: 'Factory Method',
      category: 'Creational',
      categoryColor: AppTheme.creationalColor,
      description: 'Crea objetos sin especificar sus clases concretas',
      problem: 'Tienes múltiples tipos de objetos similares y no quieres que el cliente conozca los detalles',
      solution: 'Una fábrica decide qué tipo crear basado en parámetros',
      useCases: ['OrderFactory', 'PaymentFactory', 'UserProvider', 'DialogFactory'],
      icon: Icons.handyman,
    ),
    PatternInfo(
      id: 'builder',
      name: 'Builder',
      category: 'Creational',
      categoryColor: AppTheme.creationalColor,
      description: 'Construye objetos complejos paso a paso',
      problem: 'Objetos con muchos parámetros, muchos opcionales',
      solution: 'Un builder que añade parámetros uno por uno de forma legible',
      useCases: ['ComplexOrderBuilder', 'UIBuilder', 'QueryBuilder', 'HTTPRequestBuilder'],
      icon: Icons.build,
    ),
    PatternInfo(
      id: 'abstract_factory',
      name: 'Abstract Factory',
      category: 'Creational',
      categoryColor: AppTheme.creationalColor,
      description: 'Crea familias de objetos relacionados',
      problem: 'UI diferente por tema (Light/Dark) pero misma lógica',
      solution: 'Una fábrica de fábricas que genera familias completas',
      useCases: ['UIThemeFactory', 'PlatformFactory', 'DatabaseFactory'],
      icon: Icons.dashboard_customize,
    ),

    // ESTRUCTURALES
    PatternInfo(
      id: 'adapter',
      name: 'Adapter',
      category: 'Structural',
      categoryColor: AppTheme.structuralColor,
      description: 'Hace compatible lo incompatible',
      problem: 'Tienes API vieja con interface rara, necesitas interface nueva',
      solution: 'Un adaptador traduce entre ambas interfaces',
      useCases: ['PaymentAdapter', 'LegacyAPIAdapter', 'ThirdPartyIntegration'],
      icon: Icons.power_input,
    ),
    PatternInfo(
      id: 'decorator',
      name: 'Decorator',
      category: 'Structural',
      categoryColor: AppTheme.structuralColor,
      description: 'Añade comportamiento dinámicamente sin herencia',
      problem: 'Quieres añadir responsabilidades dinámicamente sin explosión de subclases',
      solution: 'Decora el objeto con componentes adicionales',
      useCases: ['CoffeeDecorator (Milk, Sugar)', 'UIDecorator', 'LoggingDecorator'],
      icon: Icons.layers,
    ),
    PatternInfo(
      id: 'facade',
      name: 'Facade',
      category: 'Structural',
      categoryColor: AppTheme.structuralColor,
      description: 'Interfaz simple para subsistema complejo',
      problem: 'Subsistema con 10+ clases, no quieres que otros las usen directamente',
      solution: 'Una Facade simplifica el acceso',
      useCases: ['AppFacade', 'DatabaseFacade', 'PaymentGatewayFacade'],
      icon: Icons.dashboard,
    ),
    PatternInfo(
      id: 'proxy',
      name: 'Proxy',
      category: 'Structural',
      categoryColor: AppTheme.structuralColor,
      description: 'Intermediario para controlar acceso',
      problem: 'Necesitas lazy loading, logging o control de acceso',
      solution: 'Un proxy se interpone entre cliente y objeto real',
      useCases: ['ImageProxy', 'RepositoryProxy', 'APIClientProxy'],
      icon: Icons.shield,
    ),

    // COMPORTAMENTALES
    PatternInfo(
      id: 'observer',
      name: 'Observer',
      category: 'Behavioral',
      categoryColor: AppTheme.behavioralColor,
      description: 'Notifica múltiples objetos de cambios',
      problem: 'Cuando cambia algo, muchas pantallas deben actualizarse',
      solution: 'El objeto cambiante "avisa" a los que están escuchando',
      useCases: ['OrderObserver', 'LiveData', 'StateNotifier', 'ChangeNotifier'],
      icon: Icons.notifications,
    ),
    PatternInfo(
      id: 'strategy',
      name: 'Strategy',
      category: 'Behavioral',
      categoryColor: AppTheme.behavioralColor,
      description: 'Intercambia algoritmos dinámicamente',
      problem: 'Múltiples formas de hacer lo mismo, elige en tiempo de ejecución',
      solution: 'Cada estrategia es una clase separada',
      useCases: ['PricingStrategy', 'PaymentStrategy', 'SortingStrategy'],
      icon: Icons.fork,
    ),
    PatternInfo(
      id: 'state',
      name: 'State',
      category: 'Behavioral',
      categoryColor: AppTheme.behavioralColor,
      description: 'Cambiar comportamiento según estado',
      problem: 'Objeto se comporta diferente según su estado',
      solution: 'Cada estado es una clase separada',
      useCases: ['OrderState (Pending/Processing/Completed)', 'ConnectionState'],
      icon: Icons.flow_split,
    ),
    PatternInfo(
      id: 'command',
      name: 'Command',
      category: 'Behavioral',
      categoryColor: AppTheme.behavioralColor,
      description: 'Encapsula una acción como objeto',
      problem: 'Necesitas undo/redo, queue de acciones, scheduled tasks',
      solution: 'Cada acción es un objeto Command',
      useCases: ['UndoRedoCommand', 'TaskQueue', 'MacroCommand'],
      icon: Icons.terminal,
    ),
    PatternInfo(
      id: 'template_method',
      name: 'Template Method',
      category: 'Behavioral',
      categoryColor: AppTheme.behavioralColor,
      description: 'Estructura definida, detalles en subclases',
      problem: 'Múltiples clases con estructura similar',
      solution: 'Clase base define estructura, subclases implementan detalles',
      useCases: ['DataSyncProcess', 'ReportGenerator', 'DataParser'],
      icon: Icons.schema,
    ),
    PatternInfo(
      id: 'chain',
      name: 'Chain of Responsibility',
      category: 'Behavioral',
      categoryColor: AppTheme.behavioralColor,
      description: 'Pasa acción entre objetos en cadena',
      problem: 'Validación o procesamiento en múltiples niveles',
      solution: 'Cada handler decide: ¿yo la proceso o la paso?',
      useCases: ['ValidatorChain', 'LoggerChain', 'RequestHandler'],
      icon: Icons.link,
    ),
    PatternInfo(
      id: 'mediator',
      name: 'Mediator',
      category: 'Behavioral',
      categoryColor: AppTheme.behavioralColor,
      description: 'Centraliza comunicación compleja',
      problem: 'Muchos objetos se comunican entre sí → complejidad total',
      solution: 'Un mediador central maneja toda la comunicación',
      useCases: ['ChatRoom', 'DialogMediator', 'EventBus'],
      icon: Icons.hub,
    ),
  ];

  List<PatternInfo> get filteredPatterns {
    return patterns.where((pattern) {
      final matchesCategory =
          selectedCategory == 'All' || pattern.category == selectedCategory;
      final matchesSearch = pattern.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          pattern.description.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('🏛️ GoF Patterns Showcase'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withAlpha(30),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${filteredPatterns.length}/${patterns.length} patterns',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search & Filter Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Search Bar
                  TextField(
                    onChanged: (value) => setState(() => searchQuery = value),
                    decoration: InputDecoration(
                      hintText: 'Search patterns...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () =>
                                  setState(() => searchQuery = ''),
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Category Filter
                  SizedBox(
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildCategoryChip('All', 'All'),
                        _buildCategoryChip('Creational', 'Creational'),
                        _buildCategoryChip('Structural', 'Structural'),
                        _buildCategoryChip('Behavioral', 'Behavioral'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Patterns Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _getCrossAxisCount(context),
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: filteredPatterns.length,
                itemBuilder: (context, index) {
                  final pattern = filteredPatterns[index];
                  return _buildPatternCard(context, pattern);
                },
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, String value) {
    final isSelected = selectedCategory == value;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => setState(() => selectedCategory = value),
      ),
    );
  }

  Widget _buildPatternCard(BuildContext context, PatternInfo pattern) {
    return Card(
      child: InkWell(
        onTap: () => context.push('/pattern/${pattern.id}'),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon & Category
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(pattern.icon, size: 32, color: pattern.categoryColor),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: pattern.categoryColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      pattern.category,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: pattern.categoryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),

              // Name
              Text(
                pattern.name,
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              // Description
              const SizedBox(height: 4),
              Text(
                pattern.description,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              // Arrow
              const SizedBox(height: 8),
              const Align(
                alignment: Alignment.bottomRight,
                child: Icon(Icons.arrow_forward, size: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 4;
    if (width > 800) return 3;
    if (width > 500) return 2;
    return 1;
  }
}
