import 'package:assignment_second/src/modules/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginTextFieldWidget extends StatelessWidget {
  LoginTextFieldWidget({
    super.key,
    required this.emailText,
    required this.emailFocusNode,
    required this.state,
  });
  final emailRegex =
      RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$'); // Regex for email validation

  final TextEditingController emailText; // Controller for email input
  final FocusNode emailFocusNode; // Focus node for email field
  final LoginState state; // Current state from Bloc

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: emailText,
      focusNode: emailFocusNode,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: state.focusField == FocusField.email
                ? Colors.orange
                : Colors.grey,
            width: 1,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orange,
            width: 2.0,
          ),
        ),
        hintText: "Enter the Username here.",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email can\'t be empty';
        } else if (!emailRegex.hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
      onChanged: (value) {
        context
            .read<LoginBloc>()
            .add(GetEmail(email: value)); // Update email in Bloc
      },
    );
  }
}
