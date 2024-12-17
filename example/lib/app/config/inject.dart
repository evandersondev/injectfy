import 'package:injectfy/injectfy.dart';

import '../repositories/user_repository.dart';
import '../services/user_service.dart';
import '../services/user_service_impl.dart';

class Inject {
  static inject() {
    final injectfy = Injectfy.instance;

    injectfy.registerSingleton<UserService>(() => UserServiceImpl());
    injectfy.registerSingleton(() => UserRepository(injectfy()));
  }
}
