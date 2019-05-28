import 'dart:async';
import 'dart:convert';

import '../app_config.dart';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:orders_app/models/profile_model.dart';

import '../models/user_model.dart';

class UserRepository {
  final storage = new FlutterSecureStorage();

  Future<User> authenticate({
    @required String username,
    @required String password,
  }) async {
    final Map<String, dynamic> postData = {
      'email': username,
      'password': password
    };

    http.Response res = await http.post(
        AppConfig().loginUrl,
        headers: {"Content-Type": "application/json"},
        body: json.encode(postData));

    var retorno = json.decode(res.body);

    if (retorno['error'] == null) {
      User user = User.fromJson(retorno);
      return user;
    } else {
      try {
        if (retorno['error']['user_authentication'][0] ==
            'invalid credentials') {
          throw ('Credenciais Inválidas');
        }
      } catch (error) {
        throw (error);
      }
    }
  }

  Future<void> deleteToken() async {
    await storage.delete(key: 'auth_token');
    // await storage.deleteAll();
    return;
  }

  Future<void> deleteAll() async {
    await storage.deleteAll();
    return;
  }

  Future<void> persistUser(User user) async {
    try {
      await persistData('user.first_name', user.first_name);
      await persistData('user.last_name', user.last_name);
      await persistData('user.id', user.id.toString());
      await persistData('user.email', user.email.toString());
      await persistData('user.profile', user.profile.toJson().toString());
      await persistData('user.auth_token', user.auth_token.toString());
      return true;
    } catch (error) {
      throw (error);
    }
  }

  Future<void> persistToken(String token) async {
    await storage.write(key: 'auth_token', value: token);
    return;
  }

  Future<void> persistData(String key, String value) async {
    await storage.write(key: key, value: value);
    return;
  }

  Future<int> getUserId() async {
    User currentUser = User.fromMap(await storage.readAll());
    return currentUser.id;
  }
  Future<String> getToken() async {
    User currentUser = User.fromMap(await storage.readAll());
    return currentUser.auth_token;
  }

  Future<bool> hasToken() async {
    Map<String, String> items = await storage.readAll();
    if (items.length > 0) {
      User currentUser = User.fromMap(await storage.readAll());
      try {
        http.Response res = await http.get(
            '${AppConfig().apiUrl}users/${currentUser.id}',
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${currentUser.auth_token}"
            });

        if (res.statusCode == 200) {
          print('Validado!');
          return true;
        }
      } catch (error) {
        deleteAll();
        return false;
      }
    }
    deleteAll();
    return false;
  }
}
