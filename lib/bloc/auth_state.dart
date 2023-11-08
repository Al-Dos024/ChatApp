part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class RegisterSuccess extends AuthState {}

class RegisterLoading extends AuthState {}

class RegisterFailure extends AuthState {
  String errMessage;
  RegisterFailure({required this.errMessage});
}

class LoginSuccess extends AuthState {}

class LoginLoading extends AuthState {}

class LoginFailure extends AuthState {
  String errMessage;
  LoginFailure({required this.errMessage});
}
