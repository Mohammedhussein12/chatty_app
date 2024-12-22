import 'package:chatty_app/shared/app_validator.dart';
import 'package:chatty_app/auth/view/screens/register_screen.dart';
import 'package:chatty_app/auth/view_model/auth_states.dart';
import 'package:chatty_app/auth/view_model/auth_view_model.dart';
import 'package:chatty_app/shared/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/app_theme.dart';
import '../../../home_screen.dart';
import '../widgets/default_elevated_button.dart';
import '../widgets/default_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/loginScreen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/background_image.png'),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Login',
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultTextFormField(
                  validator: (val) => AppValidator.validateEmail(val),
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Email',
                  controller: _emailController,
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                DefaultTextFormField(
                  isPassword: true,
                  validator: (value) => AppValidator.validatePassword(value),
                  keyboardType: TextInputType.visiblePassword,
                  hintText: 'Password',
                  controller: _passwordController,
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                BlocListener<AuthViewModel, AuthStates>(
                  listener: (context, state) {
                    if (state is LoginLoadingState) {
                      UiUtils.showLoading(context);
                    } else if (state is LoginErrorState) {
                      UiUtils.hideLoading(context);
                      UiUtils.showMessage(state.message, AppTheme.red);
                    } else if (state is LoginSuccessState) {
                      UiUtils.hideLoading(context);
                      Navigator.pushReplacementNamed(
                          context, HomeScreen.routeName);
                    }
                  },
                  child: DefaultElevatedButton(
                    label: 'Login',
                    onPressed: login,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, RegisterScreen.routeName);
                  },
                  child: const Text('Don\'t Have An Account ?'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<AuthViewModel>(context).loginUser(
          email: _emailController.text, password: _passwordController.text);
    }
  }
}
