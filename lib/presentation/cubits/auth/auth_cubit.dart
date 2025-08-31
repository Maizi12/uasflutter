import 'package:digit/domain/repository/auth_repository.dart';
import 'package:digit/presentation/pages/auth/login_page.dart';
import 'package:digit/providers/navigation_history_provider.dart';
import 'package:digit/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

// lib/presentation/cubits/auth/auth_cubit.dart
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(const AuthState.initial());
  final AuthRepository authRepository;

  Future<void> login(String userName, String password) async {
    // Add input validation
    if (userName.isEmpty || password.isEmpty) {
      emit(const AuthState.failed('Username and password are required'));
      return;
    }
    emit(const AuthState.loading());

    try {
      // Step 1: Get encryption key
      final keyResult = await authRepository.getEncryptionKey();

      await keyResult.fold(
        (failure) async {
          emit(AuthState.failed(
              failure.message ?? 'Failed to get encryption key'));
        },
        (key) async {
          // Step 2: Login with encrypted credentials
          final loginResult = await authRepository.login(userName, password);

          loginResult.fold(
            (failure) {
              emit(AuthState.failed(failure.message ?? 'Login failed'));
            },
            (token) {
              emit(const AuthState.authenticated());
            },
          );
        },
      );
    } catch (e) {
      emit(AuthState.failed('An unexpected error occurred: $e'));
    }
  }

  void handleAuthFailure() {
    AppRouter.router.go(LoginPage.routeName);
    emit(const AuthState.unauthenticated());
  }

  Future<void> logout() async {
    // await authRepository.clearStoredData();
    emit(const AuthState.unauthenticated());
  }

  Future<void> GetKey() async {
    emit(const AuthState.loading());

    final result = await authRepository.getEncryptionKey();

    result.fold(
      (failure) {
        emit(AuthState.failed(failure.message ?? 'Login Failed'));
      },
      (user) => emit(AuthState.keyLoaded()),
    );

//   Future<void> logout() async {
//     await logoutBox();
//     emit(const _Logout());
//   }
  }
}
