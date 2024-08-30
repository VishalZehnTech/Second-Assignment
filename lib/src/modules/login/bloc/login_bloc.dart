import 'package:assignment_second/src/overrides.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  // DbService dbService = DbService();

  LoginBloc() : super(const LoginState(isVisibility: false)) {
    on<GetEmail>(_getEmail);
    on<GetPassword>(_getPassword);
    on<LoginAPI>(_loginAPI);
    on<LogOutAPI>(_logOutAPI);
    on<GetVisibility>(_getVisibility);
    // on<SetFieldFocus>(_setFieldFocus);
  }

  // void _setFieldFocus(SetFieldFocus event, Emitter<LoginState> emit) {
  //   emit(state.copyWith(isFocused: event.isFocused));
  // }

  void _getEmail(GetEmail event, Emitter<LoginState> emit) async {
    emit(state.copyWith(email: event.email));
  }

  void _getPassword(GetPassword event, Emitter<LoginState> emit) async {
    emit(state.copyWith(
      password: event.password,
    ));
  }

  void _getVisibility(GetVisibility event, Emitter<LoginState> emit) {
    emit(state.copyWith(isVisibility: !state.isVisibility));
  }

  void _logOutAPI(LogOutAPI event, Emitter<LoginState> emit) async {
    emit(state.copyWith(loginStatus: LoginStatus.init));
  }

  void _loginAPI(LoginAPI event, Emitter<LoginState> emit) async {
    emit(state.copyWith(loginStatus: LoginStatus.init));
    try {
      Map data = {'email': state.email, 'password': state.password};
      final response = await http
          .post(Uri.parse("${Overrides.API_BASE_URL}login"), body: data);

      if (response.statusCode == 200) {
        emit(
          state.copyWith(
            loginStatus: LoginStatus.success,
            message: "Login Successfully",
          ),
        );
      } else {
        emit(
          state.copyWith(
            loginStatus: LoginStatus.failed,
            message: "Something Want wrong",
          ),
        );
      }
    } catch (e) {
      debugPrint("Error : $e");
      emit(
        state.copyWith(
          loginStatus: LoginStatus.error,
          message: e.toString(),
        ),
      );
    }
  }
}
