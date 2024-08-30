import 'package:assignment_second/src/modules/login/bloc/login_bloc.dart';
import 'package:assignment_second/src/modules/home/ui/Home_Page.dart';
import 'package:assignment_second/src/modules/login/ui/Login_Button_Widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final emailText = TextEditingController();
  final passwordText = TextEditingController();

  // _LoginPage() : super() {
  //   passwordFocusNode.addListener(() {
  //     final isFocused = passwordFocusNode.hasFocus;
  //     context.read<LoginBloc>().add(SetFieldFocus(isFocused));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(),
        child: Container(
          color: Colors.white70,
          // color: Colors.amber,
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Form(
              key: formKey,
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
                  Text('Username', style: _fontStyleForText()),
                  const SizedBox(height: 10),
                  BlocBuilder<LoginBloc, LoginState>(
                    buildWhen: (previous, current) =>
                        (current.email != previous.email),
                    builder: (context, state) {
                      return LoginTextFieldWidget(
                        emailText: emailText,
                        emailFocusNode: emailFocusNode,
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Text('Password', style: _fontStyleForText()),
                  const SizedBox(height: 10),
                  BlocBuilder<LoginBloc, LoginState>(
                    buildWhen: (previous, current) =>
                        (current.password != previous.password) ||
                        (current.isVisibility != previous.isVisibility),
                    builder: (context, state) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          //   'Password',
                          //   style: _fontStyleForText().copyWith(
                          //     color: state.isVisibility
                          //         ? Colors.orange
                          //         : Colors.black,
                          //   ),
                          // ),
                          // const SizedBox(height: 10),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            focusNode: passwordFocusNode,
                            controller: passwordText,
                            obscureText: !state.isVisibility,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Enter the Password here.",
                              border: const OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.orange,
                                  width: 2.0,
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  state.isVisibility
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  context
                                      .read<LoginBloc>()
                                      .add(GetVisibility());
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password can\'t be empty';
                              } else if (value.length < 8) {
                                return 'Password must be at least 8 characters long';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              context.read<LoginBloc>().add(
                                  GetPassword(password: value, isFouce: true));
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 13),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: const Text(
                          "Forget Password",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.deepPurple,
                            decorationThickness: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  BlocListener<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state.loginStatus == LoginStatus.success) {
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
                        context.read<LoginBloc>().add(LogOutAPI());
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Incorrect Password, Try again'),
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

  TextStyle _fontStyleForText() => const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      );
}

class LoginTextFieldWidget extends StatelessWidget {
  LoginTextFieldWidget({
    super.key,
    required this.emailText,
    required this.emailFocusNode,
  });
  final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
  final TextEditingController emailText;
  final FocusNode emailFocusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: emailText,
      focusNode: emailFocusNode,
      decoration: const InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange, width: 2.0),
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
        context.read<LoginBloc>().add(GetEmail(email: value));
      },
    );
  }
}
