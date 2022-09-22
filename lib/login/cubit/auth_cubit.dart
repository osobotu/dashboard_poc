import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authenticationRepository) : super(AuthInitial());

  final AuthenticationRepository _authenticationRepository;

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    final token =
        await _authenticationRepository.login(email: email, password: password);

    if (token.isNotEmpty) {
      print(token);
      emit(AuthSuccess(token: token));
    } else {
      emit(const AuthFailure(errorMessage: 'Incorrect email or password'));
    }
  }
}
