import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:list/model/token_model.dart';
import 'package:list/model/user_model.dart';
import 'package:list/persistence/token.dart';

import 'config.dart';

Future<UserModel> fetchUser() async {
  TokenModel token = await getToken();

  final response = await http.get(
    Uri.parse(apiHost + '/api/user'),
    headers: {HttpHeaders.authorizationHeader: "Bearer ${token.accessToken}"},
  );

  if (response.statusCode == 200) {
    return UserModel.fromJson(jsonDecode(response.body)['data']);
  } else {
    throw Exception(jsonDecode(response.body)['message']);
  }
}
