import 'package:chatty_app/shared/app_validator.dart';
import 'package:chatty_app/auth/view_model/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/app_theme.dart';
import '../../../home_screen.dart';
import '../../../shared/ui_utils.dart';
import '../../view_model/auth_view_model.dart';
import '../widgets/default_elevated_button.dart';
import '../widgets/default_text_form_field.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = "/registerScreen";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
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
            image: AssetImage('assets/images/background_image.png'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Register',
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.17,
                  ),
                  DefaultTextFormField(
                    validator: (value) => AppValidator.validateUsername(value),
                    keyboardType: TextInputType.text,
                    hintText: 'Name',
                    controller: _nameController,
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  DefaultTextFormField(
                    validator: (value) => AppValidator.validateEmail(value),
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
                    height: screenHeight * 0.04,
                  ),
                  BlocListener<AuthViewModel, AuthStates>(
                    listener: (context, state) {
                      if (state is RegisterLoadingState) {
                        UiUtils.showLoading(context);
                      } else if (state is RegisterErrorState) {
                        UiUtils.hideLoading(context);
                        UiUtils.showMessage(state.message, AppTheme.red);
                      } else if (state is RegisterSuccessState) {
                        UiUtils.hideLoading(context);
                        Navigator.pushReplacementNamed(
                            context, HomeScreen.routeName);
                      }
                    },
                    child: DefaultElevatedButton(
                      label: 'Register',
                      onPressed: register,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.routeName);
                    },
                    child: const Text('Already have an account'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void register() {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<AuthViewModel>(context).registerUser(
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text);
    }
  }
}
