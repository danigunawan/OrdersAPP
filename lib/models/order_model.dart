class Order {
  int id;
  String address;
  String contact_phone;

  Order(int id, String address, String contact_phone) {
    this.id = id;
    this.address = address;
    this.contact_phone = contact_phone;
  }

  Order.fromJson(Map json, List<dynamic> permissions)
      : id = json['id'],
        address = json['address'],
        contact_phone = json['contact_phone'];

  Order.fromMap(Map<String, dynamic> map)
      : id = int.parse(map['user.id']),
        address = map['user.address'],
        contact_phone = map['user.contact_phone'];

  Map toJson() {
    return {
      'id': id,
      'address': address,
      'contact_phone': contact_phone,
    };
  }
}
