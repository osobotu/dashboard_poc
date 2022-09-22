import 'package:authentication_repository/authentication_repository.dart';
import 'package:dashboard_poc/login/login.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(context.read<AuthenticationRepository>()),
      child: const LoginView(),
    );
  }
}
