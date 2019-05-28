import 'package:orders_app/models/profile_model.dart';
import 'dart:convert';
class User {
  int id;
  String first_name;
  String last_name;
  String email;
  String auth_token;
  Profile profile;

  User(int id, String first_name, String last_name, String email,
      Profile profile) {
    this.id = id;
    this.first_name = first_name;
    this.last_name = last_name;
    this.email = email;
    this.auth_token = auth_token;
    this.profile = profile;
  }

  User.fromJson(Map json)
      : id = json['id'],
        first_name = json['first_name'],
        last_name = json['last_name'],
        email = json['email'],
        auth_token = json['auth_token'],
        profile = Profile.fromJson(json['role'], json['permissions']);

  User.fromMap(Map<String, dynamic> map)
      : id = int.parse(map['user.id']),
        first_name = map['user.first_name'],
        last_name = map['user.last_name'],
        email = map['user.email'],
        auth_token = map['user.auth_token'];
        // profile = Profile.fromJson(json.decode(map['user.profile']),
            // json.decode(map['user.profile'])['permissions']);

  Map toJson() {
    return {
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'auth_token': auth_token,
      'profile': profile.toJson()
    };
  }
}
