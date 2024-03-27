// authentication_event.dart
part of 'authentication_bloc.dart';

class AuthenticationEvent {}

class AuthenticationLoggingIn extends AuthenticationEvent {
  final String email;
  final String password;

  AuthenticationLoggingIn({required this.email, required this.password});
}

class AuthenticationRegistering extends AuthenticationEvent {
  final String username;
  final String email;
  final String password;

  AuthenticationRegistering({
    required this.username,
    required this.email,
    required this.password,
  });
}

// class CheckAuthenticationEvent extends AuthenticationEvent {}
