import 'package:authentication_repository/authentication_repository.dart';
import 'package:dashboard_poc/app.dart';
import 'package:dashboard_poc/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(
    DashboardApp(
      userRepository: UserRepository(),
      authenticationRepository: AuthenticationRepository(),
    ),
  );
}
