import 'package:chatty_app/auth/view_model/auth_states.dart';
import 'package:chatty_app/auth/view_model/auth_view_model.dart';
import 'package:chatty_app/home_screen.dart';
import 'package:chatty_app/shared/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/view/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthViewModel>(context).getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthViewModel, AuthStates>(
      listener: (context, state) {
        if (state is IsLoggedInState) {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        } else if (state is IsNotLoggedInState) {
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        }
      },
      child: const Scaffold(
        backgroundColor: Colors.white,
        body: LoadingIndicator(),
      ),
    );
  }
}
