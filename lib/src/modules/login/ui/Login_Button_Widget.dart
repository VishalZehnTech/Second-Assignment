import 'package:assignment_second/src/modules/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// A widget that displays a login button and interacts with the LoginBloc
class LoginButtonWidget extends StatelessWidget {
  // Constructor to receive the formKey for validating the form
  const LoginButtonWidget({super.key, required this.formKey});

  final GlobalKey<FormState> formKey; // Key to access the form state

  @override
  Widget build(BuildContext context) {
    // BlocBuilder to rebuild the button based on LoginBloc state changes
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
          false, // Rebuilds only when state changes
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            // Check if the form is valid before dispatching the LoginAPI event
            if (formKey.currentState?.validate() == true) {
              context.read<LoginBloc>().add(LoginAPI()); // Trigger login event
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orangeAccent, // Button background color
            minimumSize:
                const Size(double.infinity, 55), // Full width and fixed height
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5), // Rounded corners
            ),
          ),
          child: const Text(
            "Login",
            style: TextStyle(
              fontWeight: FontWeight.bold, // Bold text
              fontSize: 19, // Text size
              color: Colors.white, // Text color
            ),
          ),
        );
      },
    );
  }
}
