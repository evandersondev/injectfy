import 'package:flutter/material.dart';
import 'package:injectonize/injectonize.dart';

import '../repositories/user_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _repository = Injectonize.get<UserRepository>();

  @override
  void initState() {
    super.initState();

    _repository.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
