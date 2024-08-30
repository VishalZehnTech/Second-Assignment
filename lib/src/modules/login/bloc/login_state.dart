part of 'login_bloc.dart';

enum LoginStatus { failed, success, error, loading, init }

class LoginState extends Equatable {
  final String email;
  final String password;
  final bool isVisibility;
  // final bool isFocused;
  final LoginStatus loginStatus;

  const LoginState(
      {this.email = '',
      this.password = '',
      // this.isFocused = false,
      required this.isVisibility,
      this.loginStatus = LoginStatus.init});

  LoginState copyWith(
      {String? email,
      String? password,
      String? message,
      bool? isVisibility,
      // bool? isFocused,
      LoginStatus? loginStatus}) {
    return LoginState(
      // isFocused: isFocused ?? this.isFocused,
      email: email ?? this.email,
      password: password ?? this.password,
      isVisibility: isVisibility ?? this.isVisibility,
      loginStatus: loginStatus ?? this.loginStatus,
    );
  }

  @override
  List<Object> get props => [email, password, loginStatus, isVisibility];
}
