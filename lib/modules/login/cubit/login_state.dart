part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class ChangeRemember extends LoginState{}
class AppLoginLoading extends LoginState{}
class AppLoginSuccess extends LoginState{
  final uId;
  AppLoginSuccess(this.uId);
}
class AppLoginError extends LoginState{
  final error;

  AppLoginError(this.error);
}
