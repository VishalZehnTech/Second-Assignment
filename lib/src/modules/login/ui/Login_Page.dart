import 'package:assignment_second/src/modules/login/bloc/login_bloc.dart';
import 'package:assignment_second/src/modules/home/ui/Home_Page.dart';
import 'package:assignment_second/src/modules/login/ui/Forget_Button_Widget.dart';
import 'package:assignment_second/src/modules/login/ui/Login_Button_Widget.dart';
import 'package:assignment_second/src/services/db_Service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_text_field_widget.dart';
import 'password_text_field_widget.dart';

// The login page widget which handles user login
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  // Bloc for managing login state
  late LoginBloc _loginBloc;

  // Focus node for email and password field
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  // Controller for email and password input
  final emailText = TextEditingController();
  final passwordText = TextEditingController();
  final GlobalKey<FormState> formKey =
      GlobalKey<FormState>(); // Key for form validation

  @override
  void dispose() {
    // Dispose of focus nodes and text controllers to free up resources
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    emailText.dispose();
    passwordText.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Initialize the LoginBloc with DbService
    _loginBloc = LoginBloc(DbService());

    // Listener for email focus node to update focus field in the bloc
    emailFocusNode.addListener(() {
      _loginBloc.add(GetChangeFocus(
          focusField:
              emailFocusNode.hasFocus ? FocusField.email : FocusField.none));
    });

    // Listener for password focus node to update focus field in the bloc
    passwordFocusNode.addListener(() {
      _loginBloc.add(GetChangeFocus(
          focusField: passwordFocusNode.hasFocus
              ? FocusField.password
              : FocusField.none));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (_) => _loginBloc,
        child: Container(
          color: Colors.white70, // Background color of the page
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Form(
              key: formKey, // Key for the form
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const Text('Login in with your credentials'),
                  const SizedBox(height: 50),
                  // BlocBuilder to handle email field and focus state
                  BlocBuilder<LoginBloc, LoginState>(
                    buildWhen: (previous, current) =>
                        (current.email != previous.email ||
                            current.focusField != previous.focusField),
                    builder: (context, state) {
                      return _userNameColumnTextAndTextField(state);
                    },
                  ),
                  const SizedBox(height: 20),
                  // BlocBuilder to handle password field, visibility, and focus state
                  BlocBuilder<LoginBloc, LoginState>(
                    buildWhen: (previous, current) =>
                        (current.password != previous.password) ||
                        current.focusField != previous.focusField ||
                        (current.isVisibility != previous.isVisibility),
                    builder: (context, state) {
                      return _passwordColumnTextAndTextField(state);
                    },
                  ),
                  const SizedBox(height: 13),
                  // Widget for forgotten password link
                  const ForgetButtonWidget(),
                  const SizedBox(height: 30),

                  // BlocListener to handle login status and navigate or show messages
                  BlocListener<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state.loginStatus == LoginStatus.success) {
                        // Clear input fields and navigate to HomePage on successful login
                        emailText.clear();
                        passwordText.clear();
                        context.read<LoginBloc>().add(LogOutAPI());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      } else if (state.loginStatus == LoginStatus.failed) {
                        // Show failure message on login failure
                        context.read<LoginBloc>().add(LogOutAPI());
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Incorrect Password, Try again'),
                          ),
                        );
                      } else if (state.loginStatus == LoginStatus.error) {
                        // Show error message on login error
                        context.read<LoginBloc>().add(LogOutAPI());
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message.toString()),
                          ),
                        );
                      }
                    },
                    child: LoginButtonWidget(formKey: formKey),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Method to define common text style for labels
  TextStyle _fontStyleForText() => const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      );

  // Method to build the username section with text field and label
  Column _userNameColumnTextAndTextField(LoginState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Username',
          style: _fontStyleForText().copyWith(
            color: state.focusField == FocusField.email
                ? Colors.orange
                : Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        LoginTextFieldWidget(
          emailText: emailText,
          emailFocusNode: emailFocusNode,
          state: state,
        )
      ],
    );
  }

  // Method to build the password section with text field and label
  Column _passwordColumnTextAndTextField(LoginState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: _fontStyleForText().copyWith(
            color: state.focusField == FocusField.password
                ? Colors.orange
                : Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        PasswordTextFieldWidget(
          passwordFocusNode: passwordFocusNode,
          passwordText: passwordText,
          state: state,
        ),
      ],
    );
  }
}
