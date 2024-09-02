part of 'login_bloc.dart';

// Enum to represent different states of the login process
enum LoginStatus { failed, success, error, loading, init }

class LoginState extends Equatable {
  final String email; // The email address entered by the user
  final String password; // The password entered by the user
  final String message; // Message to show status or error messages
  final bool isVisibility; // Indicates if the password field is visible
  final FocusField focusField; // Represents the currently focused input field
  final LoginStatus loginStatus; // The current status of the login process

  // Constructor for initializing the LoginState
  const LoginState({
    this.email = '', // Default empty string for email
    this.password = '', // Default empty string for password
    this.message = '', // Default empty string for message
    this.focusField = FocusField.none, // Default focus field is none
    required this.isVisibility, // Required visibility status for password field
    this.loginStatus = LoginStatus.init, // Default login status is init
  });

  // Method to create a copy of the current state with updated properties
  LoginState copyWith({
    String? email, // Optionally update the email
    String? password, // Optionally update the password
    String? message, // Optionally update the message
    bool?
        isVisibility, // Optionally update the visibility of the password field
    FocusField? focusField, // Optionally update the focus field
    LoginStatus? loginStatus, // Optionally update the login status
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      message: message ?? this.message,
      focusField: focusField ?? this.focusField,
      isVisibility: isVisibility ?? this.isVisibility,
      loginStatus: loginStatus ?? this.loginStatus,
    );
  }

  @override
  // List of properties used for equality comparison
  List<Object> get props =>
      [email, password, message, focusField, loginStatus, isVisibility];
}
