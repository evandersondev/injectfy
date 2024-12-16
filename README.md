# Injectonize: A Simple Dependency Injection Library for Dart

A minimalistic and easy-to-use dependency injection library for managing singletons and factories in Dart.

## Features

- Register singletons and factories to manage dependencies.
- Automatically resolve and inject dependencies.
- Easily unregister dependencies.
- Useful for both production and testing (with mock support).

## Installation

Add the following dependency to your pubspec.yaml:

```yaml
dependencies:
  injectonize: ^1.0.0
```

Then, run:

```bash
flutter pub get
```

## Getting Started

## Basic Usage

```dart
import 'package:injectonize/injectonize.dart';

void main() {
  // Registering a singleton
  Injectonize.registerSingleton<SomeService>(() => SomeService());

  // Registering a factory
  Injectonize.registerFactory<ClientsRepository>(() => ClientsRepositoryImpl());

  // Resolving dependencies
  final someService = Injectonize.get<SomeService>();
  final clientsRepository = Injectonize.get<ClientsRepository>();

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
  Injectonize.registerSingleton<SomeService>(() => SomeService());

  // Resolving the singleton
  final service1 = Injectonize.get<SomeService>();
  final service2 = Injectonize.get<SomeService>();

  // Both variables will point to the same instance
  print(identical(service1, service2));  // Output: true
}
```

## Registering a Factory

A factory allows creating a new instance of the dependency every time it is requested.

```dart
class UserRepository {
  final String name;
  UserRepository(this.name);
}

void main() {
  // Registering a factory
  Injectonize.registerFactory<UserRepository>(() => UserRepository("John"));

  // Resolving the factory
  final repo1 = Injectonize.get<UserRepository>();
  final repo2 = Injectonize.get<UserRepository>();

  // Different instances are created each time
  print(identical(repo1, repo2));  // Output: false
}
```

## Automatically Resolving Dependencies

You can automatically resolve dependencies via the call() method.

```dart
void main() {
  // Registering a dependency
  Injectonize.registerSingleton<SomeService>(() => SomeService());

  // Resolving dependencies automatically
  final service = Injectonize();
  service.doSomething();  // Output: Doing something...
}
```

## Unregistering a Dependency

You can unregister a previously registered dependency if it's no longer needed.

```dart
void main() {
  Injectonize.registerSingleton<SomeService>(() => SomeService());

  // Unregistering the dependency
  Injectonize.instance.unregister<SomeService>();

  try {
    final service = Injectonize.get<SomeService>();
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
  Injectonize.registerMock<SomeService>(mockService);

  final service = Injectonize.get<SomeService>();
  print(service == mockService);  // Output: true
}
```

## API Reference

## `Injectonize`

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
Injectonize.registerSingleton<SomeService>(() => SomeService());
```

This ensures that only one instance of SomeService is created and reused each time it's requested.

- Factory:

```dart
Injectonize.registerFactory<SomeService>(() => SomeService());
```

This creates a new instance of SomeService every time it's requested.

## Testing

You can test your application by registering mock dependencies for testing purposes.

## Example of Testing with Mocks

```dart
import 'package:test/test.dart';

void main() {
  test('Singleton works correctly', () {
    Injectonize.registerSingleton<SomeService>(() => SomeService());

    final service1 = Injectonize.get<SomeService>();
    final service2 = Injectonize.get<SomeService>();

    expect(identical(service1, service2), true);
  });

  test('Factory works correctly', () {
    Injectonize.registerFactory<UserRepository>(() => UserRepository("John"));

    final repo1 = Injectonize.get<UserRepository>();
    final repo2 = Injectonize.get<UserRepository>();

    expect(identical(repo1, repo2), false);
  });

  test('Mock registration works correctly', () {
    final mockService = SomeService();
    Injectonize.registerMock<SomeService>(mockService);

    final service = Injectonize.get<SomeService>();

    expect(service, mockService);
  });
}
```

## Contributing

Contributions are welcome! Please open issues or submit pull requests on the GitHub repository.

## License

This library is licensed under the MIT License. See the LICENSE file for details.
