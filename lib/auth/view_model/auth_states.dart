abstract class AuthStates {}

class AuthInitial extends AuthStates {}

class LoginLoadingState extends AuthStates {}

class LoginErrorState extends AuthStates {
  final String message;

  LoginErrorState({required this.message});
}

class LoginSuccessState extends AuthStates {}

class RegisterLoadingState extends AuthStates {}

class RegisterErrorState extends AuthStates {
  final String message;

  RegisterErrorState({required this.message});
}

class RegisterSuccessState extends AuthStates {}

class LogoutLoadingState extends AuthStates {}

class LogoutErrorState extends AuthStates {
  final String message;

  LogoutErrorState({required this.message});
}

class LogoutSuccessState extends AuthStates {}
class IsLoggedInState extends AuthStates {}
class IsNotLoggedInState extends AuthStates {}

