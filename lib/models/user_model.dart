class User {
  int id;
  String first_name;
  String last_name;
  String email;
  String auth_token;

  User(int id, String first_name, String last_name, String email) {
    this.id = id;
    this.first_name = first_name;
    this.last_name = last_name;
    this.email = email;
    this.auth_token = auth_token;
  }

  User.fromJson(Map json)
      : id = json['id'],
        first_name = json['first_name'],
        last_name = json['last_name'],
        email = json['email'],
        auth_token = json['auth_token'];

  User.fromMap(Map<String, dynamic> map)
      : id = int.parse(map['user.id']),
        first_name = map['user.first_name'],
        last_name = map['user.last_name'],
        email = map['user.email'],
        auth_token = map['user.auth_token'];

  Map toJson() {
    return {
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'auth_token': auth_token
    };
  }
}
