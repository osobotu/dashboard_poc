// import 'package:req_res_api/req_res_api.dart';

import 'package:req_res_api/req_res_api.dart' hide User;
import 'package:user_repository/src/models/models.dart';

class UserRepository {
  UserRepository({ReqResApiClient? reqResApiClient})
      : _reqResApiClient = reqResApiClient ?? ReqResApiClient();

  final ReqResApiClient _reqResApiClient;

  Future<List<User>> getUsers() async {
    final _usersFromApi = await _reqResApiClient.getUsers();
    final List<User> _users = [];
    for (var user in _usersFromApi) {
      _users.add(
        User.fromJson(user.toJson()),
      );
    }

    return _users;
  }
}
