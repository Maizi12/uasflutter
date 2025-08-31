import 'package:digit/dependencies_injection.dart';
import 'package:digit/presentation/cubits/auth/auth_cubit.dart';
import 'package:digit/presentation/cubits/transaksi/transaksi_cubit.dart';
import 'package:digit/presentation/pages/auth/auth_wrapper.dart';
import 'package:digit/presentation/pages/auth/login_page.dart';
import 'package:digit/presentation/pages/dashboard_page.dart';
import 'package:digit/presentation/pages/transaksi2_page.dart';
import 'package:digit/providers/navigation_history_provider.dart';
import 'package:digit/router/route_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: GlobalKey<NavigatorState>(),
    initialLocation: LoginPage.routeName,
    observers: [
      AppRouteObserver(sl<NavigationHistory>()), // Get the instance from GetIt
    ],
    routes: [
      // Auth shell - handles auth redirects
      ShellRoute(
        builder: (context, state, child) {
          return AuthWrapper(child: LoginPage());
        },
        routes: [
          GoRoute(
            path: LoginPage.routeName,
            name: 'login',
            builder: (context, state) => LoginPage(),
          ),
          // GoRoute(
          //   path: '/register',
          //   name: 'register',
          //   builder: (context, state) =>  RegisterPage(),
          // ),
        ],
      ),

      // Main app shell - provides global BLoCs
      ShellRoute(
        builder: (context, state, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => sl<AuthCubit>()),
              BlocProvider(create: (_) => sl<TransaksiCubit>()),
            ],
            child: child,
            // MainAppWrapper(child: child),
          );
        },
        routes: [
          GoRoute(
            path: DashboardPage.routeName,
            name: 'dashboard',
            builder: (context, state) => DashboardPage(),
          ),
          GoRoute(
            path: Transaksi2Page.routeName,
            name: 'transaksi',
            builder: (context, state) => Transaksi2Page(),
          ),
          GoRoute(
            path: '/create-transaction',
            name: 'create-transaction',
            builder: (context, state) => Transaksi2Page(),
          ),
          GoRoute(
            path: '/transactions',
            name: 'transactions',
            builder: (context, state) => const Transaksi2Page(),
          ),
        ],
      ),
    ],
  );
}
