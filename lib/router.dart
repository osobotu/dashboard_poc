import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'home/views/views.dart';
import 'login/views/views.dart';

final router = GoRouter(routes: <GoRoute>[
  GoRoute(
    path: '/',
    pageBuilder: (BuildContext context, GoRouterState state) {
      return MaterialPage(
        key: state.pageKey,
        child: const LoginPage(),
      );
    },
  ),
  GoRoute(
    path: '/home',
    pageBuilder: (BuildContext context, GoRouterState state) {
      return MaterialPage(
        key: state.pageKey,
        child: const HomePage(),
      );
    },
  ),
]);
