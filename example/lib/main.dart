import 'package:example/app/config/inject.dart';
import 'package:example/app/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  Inject.inject();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Injectfy Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
