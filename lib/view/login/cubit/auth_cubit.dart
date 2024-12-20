import 'package:uas_flutter/core/client/client.dart';
import 'package:uas_flutter/domain/services/hive/hive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uas_flutter/feature/feature.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uas_flutter/domain/services/services.dart';
import 'package:uas_flutter/repositories/golang-repository.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> with BoxMixin {
  final PostRequestUseCase postUseCase;
  AuthCubit(this.postUseCase) : super(AuthState.initial());

  Future<void> login({
    required String userName,
    required String password,
  }) async {
    try {
      final response = await postUseCase.call(
        url:
            '${AppConstants.API}${AppConstants.DigitUser}${AppConstants.V1}${AppConstants.Login}',
        isUseToken: false,
        moreHeader: await UserRepository().login(userName, password),
        data: {},
      );
      response.fold(
        (error) {
          if (error is ServerFailure) {
            emit(_Failed(error.message ?? ''));
          }
        },
        (right) async {
          await addData(KeyStorage.accessToken, right.data);
          print(BoxMixin().getData(KeyStorage.accessToken));
          // await addData(KeyStorage.refreshToken, right.data['refreshToken']);
          emit(const _Success());
        },
      );
    } catch (e) {
      emit(_Failed(e.toString()));
    }
  }

  Future<void> logout() async {
    await logoutBox();
    emit(const _Logout());
  }
}
