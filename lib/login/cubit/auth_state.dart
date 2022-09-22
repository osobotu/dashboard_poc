part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  const AuthSuccess({required this.token});
  final String token;

  @override
  List<Object> get props => [token];
}

class AuthFailure extends AuthState {
  const AuthFailure({required this.errorMessage});

  final String errorMessage;
  @override
  List<Object> get props => [errorMessage];
}
