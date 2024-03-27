part of 'authentication_bloc.dart';

abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class LoginInitial extends AuthenticationState {}

class LoginSuccess extends AuthenticationState {}

class LoginFailed extends AuthenticationState {}

class RegisterInitial extends AuthenticationState {}

class RegisterSuccess extends AuthenticationState {}

class RegisterFailed extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}
