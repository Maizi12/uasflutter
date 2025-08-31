// lib/router/router.dart
import 'package:digit/dependencies_injection.dart';
import 'package:digit/presentation/cubits/auth/auth_cubit.dart';
import 'package:digit/presentation/cubits/dashboard/dashboard_cubit.dart';
import 'package:digit/presentation/cubits/transaksi/transaksi_cubit.dart';
import 'package:digit/presentation/pages/auth/auth_wrapper.dart';
import 'package:digit/presentation/pages/auth/login_page.dart';
import 'package:digit/presentation/pages/dashboard/dashboard_page.dart';
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
        ],
      ),

      // Main app shell - provides global BLoCs
      ShellRoute(
        builder: (context, state, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => sl<AuthCubit>()),
              BlocProvider(create: (_) => sl<TransaksiCubit>()),
              BlocProvider<DashboardCubit>(
                create: (_) => sl<DashboardCubit>(),
              ),
            ],
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: DashboardPage.routeName,
            name: 'dashboard',
            builder: (context, state) => DashboardPage(),
          ),
          GoRoute(
            path: DashboardPage.routeName,
            name: 'transaksi',
            builder: (context, state) => DashboardPage(),
          ),
          GoRoute(
            path: '/create-transaction',
            name: 'create-transaction',
            builder: (context, state) => DashboardPage(),
          ),
          GoRoute(
            path: '/transactions',
            name: 'transactions',
            builder: (context, state) => const DashboardPage(),
          ),
        ],
      ),
    ],
  );
}
