interface class Injectfy {
  Injectfy._();

  static final Injectfy _instance = Injectfy._();

  static Injectfy get instance => _instance;
  static Injectfy get I => _instance;

  final Map<Type, dynamic> _singletons = {};
  final Map<Type, Function()> _factories = {};

  // Method to register a singleton
  void registerSingleton<T>(T Function() factory) {
    if (!_instance._singletons.containsKey(T)) {
      Injectfy.instance._singletons[T] = factory;
    }
  }

  // Method to register a factory
  void registerFactory<T>(T Function() factory) {
    Injectfy.instance._factories[T] = factory;
  }

  // Method to get the instance of a registered dependency
  static T get<T>() {
    // Check if the type T is registered as a singleton
    if (_instance._singletons.containsKey(T)) {
      return _instance._singletons[T]!() as T;
    }

    // Check if the type T is registered as a factory
    if (_instance._factories.containsKey(T)) {
      return _instance._factories[T]!() as T;
    }

    throw Exception(
        "Dependency of type $T not found. Please ensure it is registered before calling.");
  }

  // Automatically resolve dependencies from the registry
  T _resolve<T>() {
    // Check if the type T is registered as a factory
    if (_factories.containsKey(T)) {
      return _factories[T]!() as T;
    }

    // Check if the type T is registered as a singleton
    if (_singletons.containsKey(T)) {
      return _singletons[T]!() as T;
    }

    throw Exception(
        "Unable to resolve dependency of type $T. It might not be registered.");
  }

  // Automatically resolve and return the dependency when calling Injectfy directly.
  T call<T>() {
    return _resolve<T>();
  }

  // Method to unregister a dependency
  void unregister<T>() {
    _singletons.remove(T);
    _factories.remove(T);
  }

  // Register a mock dependency (useful for testing)
  void registerMock<T>(T mock) {
    unregister<T>();
    registerSingleton(() => mock);
  }
}
