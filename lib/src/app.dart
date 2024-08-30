import 'package:assignment_second/src/modules/home/bloc/home_bloc.dart';
import 'package:assignment_second/src/modules/login/bloc/login_bloc.dart';
import 'package:assignment_second/src/modules/verbersuggesties/bloc/verber_bloc.dart';
import 'package:assignment_second/src/services/db_Service.dart';
import 'package:assignment_second/src/widgets/Splash_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => HomeBloc(DbService())),
        BlocProvider(create: (_) => VerberBloc(DbService())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        // home: const LoginPage(),
        // home: const HomePage(),
        // home: const TempPage(),
        // home: const TempListview(),
        // home: const TempCaros(),
        // home: const DrawerPage(),
        // home: const VerbeterSuggestiesPage(),
        // home: const TempSide(),
      ),
    );
  }
}
