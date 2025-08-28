import 'package:digit/domain/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

// presentation/cubits/auth/auth_cubit.dart
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(const AuthState.initial());
  final AuthRepository authRepository;

  Future<void> login(String userName, String password) async {
    emit(const AuthState.loading());

    final result = await authRepository.login(userName, password);

    result.fold(
      (failure) {
        if (failure.message != null) {
          emit(AuthState.failed(failure.message!));
        }
      },
      (user) => emit(AuthState.authenticated()),
    );
  }

  Future<void> GetKey() async {
    emit(const AuthState.loading());

    final result = await authRepository.getEncryptionKey();

    result.fold(
      (failure) {
        emit(AuthState.failed(failure.toString()));
      },
      (user) => emit(AuthState.keyLoaded()),
    );

//   Future<void> logout() async {
//     await logoutBox();
//     emit(const _Logout());
//   }
  }
}
