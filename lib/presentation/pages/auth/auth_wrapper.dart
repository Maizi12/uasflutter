import 'package:digit/presentation/cubits/auth/auth_cubit.dart';
import 'package:digit/providers/navigation_history_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';


class AuthWrapper extends StatelessWidget {
  final Widget child;

  const AuthWrapper({required this.child});
  @override
  Widget build(BuildContext context) {
    final history = context.watch<NavigationHistory>();
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        // if (state is unauthenticated && state.failure is UnauthenticatedFailure) {
        //   context.goNamed('login'); // Or your login route
        // }
        state.whenOrNull(
          authenticated: () => context.go('/login'),
          unauthenticated: () => context.go('/login'),
          failed: (error) {
            if (error.contains("User not found") ||
                error.contains("statusCode: 401") &&
                    history.previousRoute != '/login') {
              context.go('/login');
              return;
            } else {
              _showError(context, error);
            }
          },
        );
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => Scaffold(),
            // LoadingScreen(),
            orElse: () => child,
          );
        },
      ),
    );
  }

  void _showError(BuildContext context, String? error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(error ?? 'Authentication failed')),
    );
  }
}

// Widget LoadingScreen() {
//   return Widget(key: ,);
// }
