import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/database_services.dart';
import '../../models/user_model.dart';
import 'auth_states.dart';

class AuthViewModel extends Cubit<AuthStates> {
  AuthViewModel() : super(AuthInitial());
  UserModel? currentUser;

  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      currentUser =
          await DatabaseUtils.login(email: email, password: password);
      emit(LoginSuccessState());
    } catch (e) {
      emit(LoginErrorState(message: e.toString()));
    }
  }

  Future<void> registerUser(
      {required String name,
      required String email,
      required String password}) async {
    emit(RegisterLoadingState());
    try {
      currentUser = await DatabaseUtils.registerUser(name: name, email: email, password: password);
      emit(RegisterSuccessState());
    } catch (e) {
     emit(RegisterErrorState(message: e.toString()));
    }
  }
}
