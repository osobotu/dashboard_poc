import 'package:dashboard_poc/login/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: const Color(0xFF363740),
      body: Center(
        child: SizedBox(
          width: 380,
          height: 582,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.dashboard,
                    color: Colors.deepPurple,
                  ),
                  Text(
                    'Bellum',
                    style: theme.textTheme.headline5,
                  ),
                  Text(
                    'Enter your email and password below',
                    style: theme.textTheme.caption,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      label: const Text('Email'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hoverColor: Colors.deepPurpleAccent,
                    ),
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      label: const Text('Password'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hoverColor: Colors.deepPurpleAccent,
                    ),
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: ((context, state) {
                      if (state is AuthSuccess) {
                        context.go('/home');
                      } else if (state is AuthFailure) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const Align(
                                alignment: Alignment.bottomCenter,
                                child: AlertDialog(
                                  title: Text(
                                      'Incorrect Email or Password. Use test details.'),
                                ),
                              );
                            });
                      }
                    }),
                    builder: (context, state) {
                      return Builder(
                        builder: (context) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepPurple,
                              minimumSize: const Size(320, 60),
                            ),
                            onPressed: () async {
                              await context.read<AuthCubit>().login(
                                  email: emailController.text,
                                  password: passwordController.text);
                            },
                            child: state is AuthLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text('Log In'),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
