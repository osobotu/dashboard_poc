import 'package:req_res_api/req_res_api.dart';

class AuthenticationRepository {
  AuthenticationRepository({ReqResApiClient? reqResApiClient})
      : _reqResApiClient = reqResApiClient ?? ReqResApiClient();

  final ReqResApiClient _reqResApiClient;

  Future<String> login(
      {required String email, required String password}) async {
    try {
      final token =
          await _reqResApiClient.login(email: email, password: password);
      return token;
    } on Exception {
      throw LoginFailure();
    }
  }
}
