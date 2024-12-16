import 'package:flutter/widgets.dart';

import 'injectonize_base.dart';

class InjectonizeProvider extends InheritedWidget {
  final Injectonize injectonize;

  // Construtor aceita lista de registros
  InjectonizeProvider({
    required this.injectonize,
    required List<void Function()> providers,
    required super.child,
  }) {
    // Executa os registros passados na lista
    for (var register in providers) {
      register();
    }
  }

  static Injectonize of(BuildContext context) {
    final InjectonizeProvider? provider =
        context.dependOnInheritedWidgetOfExactType<InjectonizeProvider>();
    if (provider == null) {
      throw Exception("InjectonizeProvider not found in context.");
    }
    return provider.injectonize;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
