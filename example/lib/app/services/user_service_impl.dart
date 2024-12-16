import 'package:example/app/services/user_service.dart';

class UserServiceImpl implements UserService {
  @override
  Future<void> get() async {
    print('Veio do service!!!');
  }
}
