# Injectfy: A Simple Dependency Injection Library for Dart

A minimalistic and easy-to-use dependency injection library for managing singletons and factories in Dart.

## Features

- Register singletons and factories to manage dependencies.
- Automatically resolve and inject dependencies.
- Easily unregister dependencies.
- Cache frequently accessed instances for better performance.
- Useful for both production and testing (with mock support).

## Installation

Add the following dependency to your `pubspec.yaml`:

```yaml
dependencies:
  injectfy: ^1.0.0
```

Then, run:

```bash
flutter pub get
```

## Getting Started

## Basic Usage

```dart
import 'package:injectfy/injectfy.dart';

void main() {
  // Registering a singleton
  Injectfy.registerSingleton<SomeService>(() => SomeService());

  // Registering a factory
  Injectfy.registerFactory<ClientsRepository>(() => ClientsRepositoryImpl());

  // Resolving dependencies
  final someService = Injectfy.get<SomeService>();
  final clientsRepository = Injectfy.get<ClientsRepository>();

  print(someService);  // Instance of SomeService
  print(clientsRepository);  // Instance of ClientsRepositoryImpl
}
```

## Registering a Singleton

The singleton will be instantiated only once and reused every time it's requested.

```dart
class SomeService {
  void doSomething() => print("Doing something...");
}

void main() {
  // Registering a singleton
  Injectfy.registerSingleton<SomeService>(() => SomeService());

  // Resolving the singleton
  final service1 = Injectfy.get<SomeService>();
  final service2 = Injectfy.get<SomeService>();

  // Both variables will point to the same instance
  print(identical(service1, service2));  // Output: true
}
```

## Registering a Factory

A factory allows creating a new instance of the dependency every time it is requested.

```dart
class UserRepository {}

void main() {
  // Registering a factory
  Injectfy.registerFactory<UserRepository>(() => UserRepository());

  // Resolving the factory
  final repo1 = Injectfy.get<UserRepository>();
  final repo2 = Injectfy.get<UserRepository>();

  // Different instances are created each time
  print(identical(repo1, repo2));  // Output: false
}
```

## Automatically Resolving Dependencies

You can automatically resolve dependencies method if instance call.

```dart
class SomeService {
  final SomeDependency _someDependency;

  SomeService(this._someDependency);
}

void main() {
  final injectfy = Injectfy.instance;
  // Registering a dependency
  Injectfy.registerSingleton<SomeService>(() => SomeService(injectfy()));
}
```

## Unregistering a Dependency

You can unregister a previously registered dependency if it's no longer needed.

```dart
void main() {
  Injectfy.registerSingleton<SomeService>(() => SomeService());

  // Unregistering the dependency
  Injectfy.instance.unregister<SomeService>();

  try {
    final service = Injectfy.get<SomeService>();
  } catch (e) {
    print(e);  // Output: Dependency of type SomeService not found. Please ensure it is registered before calling.
  }
}
```

## Registering Mock Dependencies (Useful for Testing)

For testing purposes, you can register mock objects in place of actual dependencies.

```dart
void main() {
  final mockService = SomeService();
  Injectfy.registerMock<SomeService>(mockService);

  final service = Injectfy.get<SomeService>();
  print(service == mockService);  // Output: true
}
```

## API Reference

## `Injectfy`

| Method                 | Description                                                                |
| ---------------------- | -------------------------------------------------------------------------- |
| `registerSingleton<T>` | Registers a singleton for the specified type `T`.                          |
| `registerFactory<T>`   | Registers a factory for the specified type `T`.                            |
| `get<T>`               | Resolves and returns the instance of type `T`.                             |
| `call<T>`              | Automatically resolves and returns the instance of type `T`.               |
| `unregister<T>`        | Unregisters the dependency of type `T`.                                    |
| `registerMock<T>`      | Registers a mock object in place of a real dependency. Useful for testing. |

## `T Function()`

This is the type of the factory function you provide when registering dependencies. It creates a new instance of the dependency when called.

## Example of `registerSingleton` and `registerFactory`

- Singleton:

```dart
Injectfy.registerSingleton<SomeService>(() => SomeService());
```

This ensures that only one instance of SomeService is created and reused each time it's requested.

- Factory:

```dart
Injectfy.registerFactory<SomeService>(() => SomeService());
```

This creates a new instance of SomeService every time it's requested.

## Testing

You can test your application by registering mock dependencies for testing purposes.

## Example of Testing with Mocks

```dart
import 'package:test/test.dart';

void main() {
  test('Singleton works correctly', () {
    Injectfy.registerSingleton<SomeService>(() => SomeService());

    final service1 = Injectfy.get<SomeService>();
    final service2 = Injectfy.get<SomeService>();

    expect(identical(service1, service2), true);
  });

  test('Factory works correctly', () {
    Injectfy.registerFactory<UserRepository>(() => UserRepository("John"));

    final repo1 = Injectfy.get<UserRepository>();
    final repo2 = Injectfy.get<UserRepository>();

    expect(identical(repo1, repo2), false);
  });

  test('Mock registration works correctly', () {
    final mockService = SomeService();
    Injectfy.registerMock<SomeService>(mockService);

    final service = Injectfy.get<SomeService>();

    expect(service, mockService);
  });
}
```

## Contributing

Contributions are welcome! Please open issues or submit pull requests on the GitHub repository.

## License

This library is licensed under the MIT License. See the LICENSE file for details.
