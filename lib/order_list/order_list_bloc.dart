import 'dart:async';
import 'package:bloc/bloc.dart';
import 'order_list_event.dart';
import 'order_list_state.dart';

class OrderListBloc extends Bloc<OrderListEvent, OrderListState> {
  @override
  OrderListState get initialState => OrderListUninitialized();

  @override
  Stream<OrderListState> mapEventToState(
    OrderListEvent event,
  ) async* {
    if (event is NewOrder) {
      yield StartNewOrder();
    }
    if (event is CancelOrder) {
      yield CancelNewOrder();
    }
  }
}
