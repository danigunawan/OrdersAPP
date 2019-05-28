import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:orders_app/models/user_model.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super(props);
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class LoggedIn extends AuthenticationEvent {
  final User user;

  LoggedIn({@required this.user}) : super([user]);

  @override
  String toString() => 'LoggedIn { token: ${user.first_name} }';
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
}

class ValidateUser extends AuthenticationEvent {
  @override
  String toString() => 'ValidateUser';
}

class AppChangeTheme extends AuthenticationEvent {
  @override
  String toString() => 'AppChangeTheme';
}