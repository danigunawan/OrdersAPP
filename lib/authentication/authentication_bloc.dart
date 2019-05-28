import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:orders_app/services/user_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../app_config.dart';
import 'authentication.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  final _theme = BehaviorSubject<ThemeData>();
  Function(ThemeData) get inTheme => _theme.sink.add;
  Stream<ThemeData> get outTheme => _theme.stream;

  AuthenticationBloc({@required this.userRepository})
      : assert(userRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await userRepository.hasToken();

      if (hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await userRepository.persistUser(event.user);
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await userRepository.deleteAll();
      yield AuthenticationUnauthenticated();
    }

    if (event is ValidateUser) {
      if (await userRepository.hasToken()) {
        yield AuthenticationAuthenticated();
      } else {
        await userRepository.deleteAll();
        yield AuthenticationUnauthenticated();
      }
    }
  }
}
