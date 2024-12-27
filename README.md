<div style="width: 100%;display:flex;flex-direction:column;justify-content:center;align-items:center;">
  <img src="assets/logo.jpg" style="width:120px;height:120px;border-radius:16px;" />
  <h1 style="border:none;">Injectfy</h1>
</div>

<h2 style="border:none;text-align:center;">🚀 A minimalistic and easy-to-use dependency injection library for managing singletons and factories in Dart.</h2>

## 🌟 Features

- ✅ Register singletons and factories to manage dependencies.
- 🔄 Automatically resolve and inject dependencies.
- ❌ Easily unregister dependencies.
- ⚡ Cache frequently accessed instances for better performance.
- 🛠️ Useful for both production and testing (with mock support).

## 📦 Installation

Add the following dependency to your `pubspec.yaml`:

```yaml
dependencies:
  injectfy: ^1.0.1
```

Then, run:

```bash
flutter pub get
```

## 🚀 Getting Started

### 📋 Basic Usage

```dart
import 'package:injectfy/injectfy.dart';

void main() {
  // Get instance
  final injectfy = Injectfy.instance;

  // Registering a singleton
  injectfy.registerSingleton<SomeService>(() => SomeService());

  // Registering a factory
  injectfy.registerFactory<ClientsRepository>(() => ClientsRepositoryImpl());

  // Resolving dependencies
  final someService = injectfy.get<SomeService>();
  final clientsRepository = injectfy.get<ClientsRepository>();

  print(someService);  // Instance of SomeService
  print(clientsRepository);  // Instance of ClientsRepositoryImpl
}
```

### 🧱 Registering a Singleton

A singleton will be instantiated only once and reused every time it's requested.

```dart
class SomeService {
  void doSomething() => print("Doing something...");
}

void main() {
  final injectfy = Injectfy.instance;

  injectfy.registerSingleton<SomeService>(() => SomeService());

  final service1 = Injectfy.get<SomeService>();
  final service2 = Injectfy.get<SomeService>();

  print(identical(service1, service2));  // Output: true
}
```

### 🏢 Registering a Factory

A factory allows creating a new instance of the dependency every time it is requested.

```dart
class UserRepository {}

void main() {
  final injectfy = Injectfy.instance;

  injectfy.registerFactory<UserRepository>(() => UserRepository());

  final repo1 = Injectfy.get<UserRepository>();
  final repo2 = Injectfy.get<UserRepository>();

  print(identical(repo1, repo2));  // Output: false
}
```

### 🧐 Automatically Resolving Dependencies

You can automatically resolve dependencies when calling a method.

```dart
class SomeService {
  final SomeDependency _someDependency;

  SomeService(this._someDependency);
}

void main() {
  final injectfy = Injectfy.instance;

  injectfy.registerSingleton<SomeService>(() => SomeService(injectfy()));
}
```

### 🛠️ Unregistering a Dependency

You can unregister a previously registered dependency if it's no longer needed.

```dart
void main() {
  final injectfy = Injectfy.instance;

  injectfy.registerSingleton<SomeService>(() => SomeService());

  injectfy.unregister<SomeService>();

  try {
    final service = Injectfy.get<SomeService>();
  } catch (e) {
    print(e);  // Dependency of type SomeService not found.
  }
}
```

### 🧪 Registering Mock Dependencies (Useful for Testing)

For testing purposes, you can register mock objects in place of actual dependencies.

```dart
void main() {
  final injectfy = Injectfy.instance;

  final mockService = SomeService();
  injectfy.registerMock<SomeService>(mockService);

  final service = Injectfy.get<SomeService>();
  print(service == mockService);  // Output: true
}
```

## 🖋️ API Reference

### 🛠️ `Injectfy`

| Method                 | Description                                                                |
| ---------------------- | -------------------------------------------------------------------------- |
| `instance`             | Get a singleton instance of Injectfy.                                      |
| `I`                    | Short syntax to get the instance.                                          |
| `registerSingleton<T>` | Registers a singleton for the specified type `T`.                          |
| `registerFactory<T>`   | Registers a factory for the specified type `T`.                            |
| `get<T>`               | Resolves and returns the instance of type `T`.                             |
| `call<T>`              | Automatically resolves and returns the instance of type `T`.               |
| `unregister<T>`        | Unregisters the dependency of type `T`.                                    |
| `registerMock<T>`      | Registers a mock object in place of a real dependency. Useful for testing. |

## 🧪 Testing

You can test your application by registering mock dependencies for testing purposes.

### Example of Testing with Mocks

```dart
import 'package:test/test.dart';

void main() {
  test('Singleton works correctly', () {
    Injectfy.I.registerSingleton<SomeService>(() => SomeService());

    final service1 = Injectfy.get<SomeService>();
    final service2 = Injectfy.get<SomeService>();

    expect(identical(service1, service2), true);
  });

  test('Factory works correctly', () {
    Injectfy.I.registerFactory<UserRepository>(() => UserRepository());

    final repo1 = Injectfy.get<UserRepository>();
    final repo2 = Injectfy.get<UserRepository>();

    expect(identical(repo1, repo2), false);
  });

  test('Mock registration works correctly', () {
    final mockService = SomeService();
    Injectfy.I.registerMock<SomeService>(mockService);

    final service = Injectfy.get<SomeService>();

    expect(service, mockService);
  });
}
```

## 🧱 Contributing

Contributions are welcome! Please open issues or submit pull requests on the GitHub repository.

## 📄 License

This library is licensed under the MIT License. See the LICENSE file for details.

# 🚀 Injectfy: A Simple Dependency Injection Library for Dart

A minimalistic and easy-to-use dependency injection library for managing singletons and factories in Dart.

## 🌟 Features

- ✅ Register singletons and factories to manage dependencies.
- 🔄 Automatically resolve and inject dependencies.
- ❌ Easily unregister dependencies.
- ⚡ Cache frequently accessed instances for better performance.
- 🛠️ Useful for both production and testing (with mock support).

## 📦 Installation

Add the following dependency to your `pubspec.yaml`:

```yaml
dependencies:
  injectfy: ^1.0.0
```

Then, run:

```bash
flutter pub get
```

## 🚀 Getting Started

### 📋 Basic Usage

```dart
import 'package:injectfy/injectfy.dart';

void main() {
  // Get instance
  final injectfy = Injectfy.instance;

  // Registering a singleton
  injectfy.registerSingleton<SomeService>(() => SomeService());

  // Registering a factory
  injectfy.registerFactory<ClientsRepository>(() => ClientsRepositoryImpl());

  // Resolving dependencies
  final someService = injectfy.get<SomeService>();
  final clientsRepository = injectfy.get<ClientsRepository>();

  print(someService);  // Instance of SomeService
  print(clientsRepository);  // Instance of ClientsRepositoryImpl
}
```

### 🧱 Registering a Singleton

A singleton will be instantiated only once and reused every time it's requested.

```dart
class SomeService {
  void doSomething() => print("Doing something...");
}

void main() {
  final injectfy = Injectfy.instance;

  injectfy.registerSingleton<SomeService>(() => SomeService());

  final service1 = Injectfy.get<SomeService>();
  final service2 = Injectfy.get<SomeService>();

  print(identical(service1, service2));  // Output: true
}
```

### 🏢 Registering a Factory

A factory allows creating a new instance of the dependency every time it is requested.

```dart
class UserRepository {}

void main() {
  final injectfy = Injectfy.instance;

  injectfy.registerFactory<UserRepository>(() => UserRepository());

  final repo1 = Injectfy.get<UserRepository>();
  final repo2 = Injectfy.get<UserRepository>();

  print(identical(repo1, repo2));  // Output: false
}
```

### 🧐 Automatically Resolving Dependencies

You can automatically resolve dependencies when calling a method.

```dart
class SomeService {
  final SomeDependency _someDependency;

  SomeService(this._someDependency);
}

void main() {
  final injectfy = Injectfy.instance;

  injectfy.registerSingleton<SomeService>(() => SomeService(injectfy()));
}
```

### 🛠️ Unregistering a Dependency

You can unregister a previously registered dependency if it's no longer needed.

```dart
void main() {
  final injectfy = Injectfy.instance;

  injectfy.registerSingleton<SomeService>(() => SomeService());

  injectfy.unregister<SomeService>();

  try {
    final service = Injectfy.get<SomeService>();
  } catch (e) {
    print(e);  // Dependency of type SomeService not found.
  }
}
```

### 🧪 Registering Mock Dependencies (Useful for Testing)

For testing purposes, you can register mock objects in place of actual dependencies.

```dart
void main() {
  final injectfy = Injectfy.instance;

  final mockService = SomeService();
  injectfy.registerMock<SomeService>(mockService);

  final service = Injectfy.get<SomeService>();
  print(service == mockService);  // Output: true
}
```

## 🖋️ API Reference

### 🛠️ `Injectfy`

| Method                 | Description                                                                |
| ---------------------- | -------------------------------------------------------------------------- |
| `instance`             | Get a singleton instance of Injectfy.                                      |
| `I`                    | Short syntax to get the instance.                                          |
| `registerSingleton<T>` | Registers a singleton for the specified type `T`.                          |
| `registerFactory<T>`   | Registers a factory for the specified type `T`.                            |
| `get<T>`               | Resolves and returns the instance of type `T`.                             |
| `call<T>`              | Automatically resolves and returns the instance of type `T`.               |
| `unregister<T>`        | Unregisters the dependency of type `T`.                                    |
| `registerMock<T>`      | Registers a mock object in place of a real dependency. Useful for testing. |

## 🧪 Testing

You can test your application by registering mock dependencies for testing purposes.

### Example of Testing with Mocks

```dart
import 'package:test/test.dart';

void main() {
  test('Singleton works correctly', () {
    Injectfy.I.registerSingleton<SomeService>(() => SomeService());

    final service1 = Injectfy.get<SomeService>();
    final service2 = Injectfy.get<SomeService>();

    expect(identical(service1, service2), true);
  });

  test('Factory works correctly', () {
    Injectfy.I.registerFactory<UserRepository>(() => UserRepository());

    final repo1 = Injectfy.get<UserRepository>();
    final repo2 = Injectfy.get<UserRepository>();

    expect(identical(repo1, repo2), false);
  });

  test('Mock registration works correctly', () {
    final mockService = SomeService();
    Injectfy.I.registerMock<SomeService>(mockService);

    final service = Injectfy.get<SomeService>();

    expect(service, mockService);
  });
}
```

## 🧱 Contributing

Contributions are welcome! Please open issues or submit pull requests on the GitHub repository.

## 📄 License

This library is licensed under the MIT License. See the LICENSE file for details.

---

Made with ❤️ for Flutter developers! 🎯
