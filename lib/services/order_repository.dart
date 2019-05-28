import 'dart:async';
import 'dart:convert';

import 'package:orders_app/models/order_model.dart';
import 'package:orders_app/services/user_repository.dart';

import '../app_config.dart';
import 'package:http/http.dart' as http;

class OrderRepository {
  Future<Order> myOrders() async {
    http.Response res = await http.get('${AppConfig().apiUrl}orders', headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${await UserRepository().getToken()}"
    });
    print(res.body);
    return json.decode(res.body);
  }
}
