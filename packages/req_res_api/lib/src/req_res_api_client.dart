import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:req_res_api/req_res_api.dart';

class UsersRequestFailure implements Exception {}

class UsersNotFound implements Exception {}

class LoginFailure implements Exception {}

class ReqResApiClient {
  ReqResApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  static const _baseUrl = 'reqres.in';

  // Fetches a [List] of [User]s from /api/users
  Future<List<User>> getUsers() async {
    final List<User> users = [];
    final getUsersRequest = Uri.https(
      _baseUrl,
      '/api/users',
      {'page': '2'},
    );

    final getUsersResponse = await _httpClient.get(getUsersRequest);

    if (getUsersResponse.statusCode != 200) {
      throw UsersRequestFailure();
    }

    final usersJson = jsonDecode(getUsersResponse.body) as Map;

    if (!usersJson.containsKey('data')) {
      throw UsersNotFound();
    }

    final data = usersJson['data'] as List;

    if (data.isEmpty) {
      throw UsersNotFound();
    }

    for (var rawUser in data) {
      final user = User.fromJson(rawUser);
      users.add(user);
    }
    return users;
  }

  // Takes user email and password and returns a token
  Future<String> login(
      {required String email, required String password}) async {
    final loginRequest = Uri.https(_baseUrl, '/api/login');

    final loginResponse = await _httpClient.post(loginRequest, body: {
      'email': email,
      'password': password,
    });

    final loginJson = jsonDecode(loginResponse.body) as Map;

    if (!loginJson.containsKey('token')) {
      throw LoginFailure();
    }
    final token = loginJson['token'];
    return token;
  }
}
// eve.holt@reqres.in
// cityslicka