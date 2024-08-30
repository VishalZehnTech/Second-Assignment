part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}

class GetEmail extends LoginEvent {
  final String email;
  const GetEmail({required this.email});
  @override
  List<Object> get props => [email];
}

class GetPassword extends LoginEvent {
  final String password;
  final bool isFouce;
  const GetPassword({required this.password, required this.isFouce});
  @override
  List<Object> get props => [password, isFouce];
}

class GetVisibility extends LoginEvent {}

class LoginAPI extends LoginEvent {}

class LogOutAPI extends LoginEvent {}
