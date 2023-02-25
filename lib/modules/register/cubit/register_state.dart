part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}


class AppRegisterLoading extends RegisterState{}
class AppCreateUserSuccess extends RegisterState{
  final String uId;
  AppCreateUserSuccess({
    required this.uId,
  });
}
class AppCreateUserError extends RegisterState{
  final error;

  AppCreateUserError(this.error);
}