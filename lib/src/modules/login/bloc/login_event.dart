part of 'login_bloc.dart';

// Abstract base class for all Login events, extending Equatable for comparison
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

// Event to capture and update the email field
class GetEmail extends LoginEvent {
  final String email; // The email address to update

  // Constructor to initialize the email
  const GetEmail({required this.email});

  @override
  List<Object> get props => [email];
}

// Event to capture and update the password field
// Also includes whether the password field is focused or not
class GetPassword extends LoginEvent {
  final String password; // The password to update
  final bool isFouce; // Indicates if the password field is focused

  // Constructor to initialize the password and focus status
  const GetPassword({required this.password, required this.isFouce});

  @override
  List<Object> get props => [password, isFouce];
}

// Event to toggle the visibility of the password field
class GetVisibility extends LoginEvent {}

// Enum to represent different focus states of the input fields
enum FocusField { email, password, none }

// Event to update the focus state of the input fields
class GetChangeFocus extends LoginEvent {
  final FocusField focusField; // The current field that is focused

  // Constructor to initialize the focus field
  const GetChangeFocus({required this.focusField});

  @override
  List<Object> get props => [focusField];
}

// Event to trigger the login API call
class LoginAPI extends LoginEvent {}

// Event to trigger the logout API call
class LogOutAPI extends LoginEvent {}
