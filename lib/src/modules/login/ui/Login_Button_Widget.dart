import 'package:assignment_second/src/modules/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => false,
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            if (formKey.currentState?.validate() == true) {
              context.read<LoginBloc>().add(LoginAPI());
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orangeAccent,
            minimumSize: const Size(double.infinity, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            "Login",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 19,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
