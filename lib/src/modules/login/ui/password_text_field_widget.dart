import 'package:assignment_second/src/modules/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordTextFieldWidget extends StatelessWidget {
  const PasswordTextFieldWidget({
    super.key,
    required this.passwordFocusNode, // Focus node for the password field
    required this.passwordText, // Controller for the password input
    required this.state, // Current login state
  });

  final FocusNode
      passwordFocusNode; // Focus node for managing focus of the password field
  final TextEditingController
      passwordText; // Controller to manage the input text
  final LoginState state; // Current state from the LoginBloc

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text, // Sets the keyboard type for text input
      focusNode: passwordFocusNode, // Focus node for the password field
      controller: passwordText, // Controller to retrieve and set the text value
      obscureText: !state
          .isVisibility, // Toggle between obscured and visible text based on state
      decoration: InputDecoration(
        filled: true, // Fill the text field with color
        fillColor: Colors.white, // Background color of the text field
        hintText: "Enter the Password here.", // Placeholder text
        border: const OutlineInputBorder(), // Default border style
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orange, // Border color when the field is focused
            width: 2.0, // Border width when the field is focused
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            state.isVisibility
                ? Icons.visibility
                : Icons.visibility_off, // Toggle icon based on visibility state
          ),
          onPressed: () {
            context.read<LoginBloc>().add(
                GetVisibility()); // Dispatch event to toggle password visibility
          },
        ),
      ),
      validator: (value) {
        // Validation message for empty password
        if (value == null || value.isEmpty) {
          return 'Password can\'t be empty';
        }
        // Validation message for short password
        else if (value.length < 8) {
          return 'Password must be at least 8 characters long';
        }
        // Return null if validation passes
        return null;
      },
      onChanged: (value) {
        // Dispatch event to update password in bloc
        context
            .read<LoginBloc>()
            .add(GetPassword(password: value, isFouce: true));
      },
    );
  }
}
