import 'package:assignment_second/src/services/db_Service.dart';
import 'package:assignment_second/src/services/db_service_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

// Bloc class for handling login-related events and states
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  // Instance of DbService to interact with the backend
  final DbService dbService;

  // Constructor for LoginBloc, initializes with DbService and sets initial state
  LoginBloc(this.dbService) : super(const LoginState(isVisibility: false)) {
    // Register event handlers
    on<GetEmail>(_getEmail);
    on<GetPassword>(_getPassword);
    on<LoginAPI>(_loginAPI);
    on<LogOutAPI>(_logOutAPI);
    on<GetVisibility>(_getVisibility);
    on<GetChangeFocus>(_getChangeFocus);
  }

  // Handles the GetEmail event to update the email in the state
  void _getEmail(GetEmail event, Emitter<LoginState> emit) async {
    emit(state.copyWith(email: event.email));
  }

  // Handles the GetPassword event to update the password in the state
  void _getPassword(GetPassword event, Emitter<LoginState> emit) async {
    emit(state.copyWith(password: event.password));
  }

  // Handles the GetVisibility event to toggle the visibility of the password field
  void _getVisibility(GetVisibility event, Emitter<LoginState> emit) {
    emit(state.copyWith(isVisibility: !state.isVisibility));
  }

  // Handles the GetChangeFocus event to update the currently focused field
  void _getChangeFocus(GetChangeFocus event, Emitter<LoginState> emit) {
    emit(state.copyWith(focusField: event.focusField));
  }

  // Handles the LogOutAPI event to reset the login status
  void _logOutAPI(LogOutAPI event, Emitter<LoginState> emit) async {
    emit(state.copyWith(loginStatus: LoginStatus.init));
  }

  // Handles the LoginAPI event to perform login and update the login status based on response
  void _loginAPI(LoginAPI event, Emitter<LoginState> emit) async {
    // Set initial login status to indicate login attempt
    emit(state.copyWith(loginStatus: LoginStatus.init));
    try {
      // Prepare data for the login API request
      Map<String, String> data = {'email': state.email, 'password': state.password};

      // Call the login API
      ResponseModel response = await dbService.postApi("login", mapData: data);

      // Check response status and update state accordingly
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
            message: "Something went wrong",
          ),
        );
      }
    } catch (e) {
      // Print error and update state with error message
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
