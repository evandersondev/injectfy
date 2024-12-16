import 'package:example/app/services/user_service.dart';

class UserRepository {
  final UserService _service;

  UserRepository(this._service);

  void load() {
    _service.get();
    print('chamou UserRepository');
  }
}
