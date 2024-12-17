/// The [Injectfy] class is a simple dependency injection (DI) container.
///
/// It allows registering and retrieving singletons and factories for managing dependencies.
class Injectfy {
  Injectfy._();

  // The single instance of the Injectfy container
  static final Injectfy _instance = Injectfy._();

  // Getter to access the single instance of Injectfy
  static Injectfy get instance => _instance;

  // Shortcut to access the single instance
  static Injectfy get I => _instance;

  // A map to store singleton instances
  final Map<Type, dynamic> _singletons = {};

  // A map to store factory functions that create instances
  final Map<Type, Function()> _factories = {};

  // A cache for frequently accessed instances to improve performance
  final Map<Type, dynamic> _cache = {};

  /// Registers a singleton dependency.
  ///
  /// The factory function is called once to create the instance,
  /// and the same instance will be returned for subsequent requests.
  ///
  /// Example usage:
  /// ```dart
  /// Injectfy.instance.registerSingleton<MyClass>(() => MyClass());
  /// ```
  void registerSingleton<T>(T Function() factory) {
    if (!_singletons.containsKey(T)) {
      // Create the instance once and store it
      _singletons[T] = factory();
    }
  }

  /// Registers a factory dependency.
  ///
  /// The factory function will be called each time the dependency is requested,
  /// providing a new instance every time.
  ///
  /// Example usage:
  /// ```dart
  /// Injectfy.instance.registerFactory<MyClass>(() => MyClass());
  /// ```
  void registerFactory<T>(T Function() factory) {
    _factories[T] = factory;
  }

  /// Retrieves the instance of a registered dependency.
  ///
  /// It will first check if the dependency is a singleton,
  /// returning the same instance every time.
  /// If it's a factory, a new instance will be created each time.
  ///
  /// Throws an exception if the dependency is not registered.
  ///
  /// Example usage:
  /// ```dart
  /// var myClassInstance = Injectfy.instance.get<MyClass>();
  /// ```
  static T get<T>() {
    // Check if the type T is cached
    if (_instance._cache.containsKey(T)) {
      return _instance._cache[T] as T;
    }

    // Check if the type T is registered as a singleton
    if (_instance._singletons.containsKey(T)) {
      return _instance._singletons[T]! as T;
    }

    // Check if the type T is registered as a factory
    if (_instance._factories.containsKey(T)) {
      final instance = _instance._factories[T]!() as T;

      // Cache the instance if it's frequently accessed
      _instance._cache[T] = instance;

      return instance;
    }

    throw Exception(
        "Dependency of type $T not found. Please ensure it is registered before usage.");
  }

  /// Automatically resolves and returns the dependency.
  ///
  /// This method can be called directly for convenience. It will attempt to resolve
  /// the dependency from the registry (either a singleton or a factory).
  T _resolve<T>() {
    // Check if the type T is cached
    if (_cache.containsKey(T)) {
      return _cache[T] as T;
    }

    // Check if the type T is registered as a factory
    if (_factories.containsKey(T)) {
      final instance = _factories[T]!() as T;
      _cache[T] = instance; // Cache it if frequently accessed
      return instance;
    }

    // Check if the type T is registered as a singleton
    if (_singletons.containsKey(T)) {
      return _singletons[T]! as T;
    }

    throw Exception(
        "Unable to resolve dependency of type $T. It might not be registered.");
  }

  /// Calls the container to automatically resolve and return the dependency.
  ///
  /// This is an alternative to using `get<T>()` directly.
  T call<T>() {
    return _resolve<T>();
  }

  /// Unregisters a dependency type, removing both singletons and factories.
  ///
  /// Example usage:
  /// ```dart
  /// Injectfy.instance.unregister<MyClass>();
  /// ```
  void unregister<T>() {
    _singletons.remove(T);
    _factories.remove(T);
    _cache.remove(T); // Also clear from cache
  }

  /// Registers a mock dependency, useful for testing purposes.
  ///
  /// Example usage:
  /// ```dart
  /// Injectfy.instance.registerMock<MyClass>(MyClassMock());
  /// ```
  void registerMock<T>(T mock) {
    unregister<T>(); // Remove any previous registration
    registerSingleton(() => mock);
  }
}
