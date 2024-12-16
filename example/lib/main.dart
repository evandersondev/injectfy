import 'package:example/app/pages/home_page.dart';
import 'package:example/app/repositories/user_repository.dart';
import 'package:example/app/services/user_service.dart';
import 'package:example/app/services/user_service_impl.dart';
import 'package:flutter/material.dart';
import 'package:injectonize/injectonize.dart';

void main() {
  final injectonize = Injectonize.instance;
  injectonize.registerSingleton<UserService>(() => UserServiceImpl());
  injectonize.registerSingleton(() => UserRepository(injectonize()));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
