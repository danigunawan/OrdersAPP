import 'package:equatable/equatable.dart';

abstract class OrderListState extends Equatable {}

class OrderListUninitialized extends OrderListState {
  @override
  String toString() => 'OrderListUninitialized';
}

class StartNewOrder extends OrderListState {
  @override
  String toString() => 'StartNewOrder';
}

class CancelNewOrder extends OrderListState {
  @override
  String toString() => 'CancelNewOrder';
}