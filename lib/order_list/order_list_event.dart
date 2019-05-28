import 'package:equatable/equatable.dart';

abstract class OrderListEvent extends Equatable {
  OrderListEvent([List props = const []]) : super(props);
}

class NewOrder extends OrderListEvent {
  @override
  String toString() => 'NewOrder';
}

class CancelOrder extends OrderListEvent {
  @override
  String toString() => 'CancelOrder';
}
