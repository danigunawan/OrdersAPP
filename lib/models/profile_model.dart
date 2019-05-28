class Profile {
  int id;
  String title;
  String description;
  List<dynamic> permissions;

  Profile(int id, String title, String description, String email, List<dynamic> permissions) {
    this.id = id;
    this.title = title;
    this.description = description;
    this.permissions = permissions;
  }

  Profile.fromJson(Map json, List<dynamic> permissions)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        permissions = permissions;

  Profile.fromMap(Map<String, dynamic> map)
      : id = int.parse(map['user.id']),
        title = map['user.title'],
        description = map['user.description'],
        permissions = map['permissions'];

  Map toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'permissions': permissions
    };
  }
}
