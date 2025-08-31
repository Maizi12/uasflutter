import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uas_flutter/core/client/client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uas_flutter/feature/feature.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uas_flutter/domain/services/services.dart';
import 'package:uas_flutter/main.dart';
import 'package:uas_flutter/repositories/golang-repository.dart';
import 'package:uas_flutter/view/transaksi/transaksi2.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> with BoxMixin {
  final PostRequestUseCase postUseCase;
  final GetRequestUseCase getUseCase;
  AuthCubit(this.postUseCase, this.getUseCase) : super(AuthState.initial());

  Future<void> GetKey() async {
    try {
      final response = await getUseCase.call(
        url:
            "${AppConstants.API}${AppConstants.DigitEnkrip}${AppConstants.V1}${AppConstants.User}${AppConstants.Enkrip}",
        isUseToken: false,
        moreHeader: await UserRepository().GetKey(),
      );
      response.fold(
        (error) {
          if (error is ServerFailure) {
            emit(_Failed(error.message ?? ''));
          }
        },
        (right) async {
          await addData(KeyStorage.enkripKey, right.data);
          print(BoxMixin().getData(KeyStorage.enkripKey));
          // await addData(KeyStorage.refreshToken, right.data['refreshToken']);
          emit(const _Success());
        },
      );
    } catch (e) {
      emit(_Failed(e.toString()));
    }
  }

  Future<Either<Failure, String>> login({
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
          queryParam: {});
      return response.fold(
        (error) {
          if (error is ServerFailure) {
            print("error.message");
            print(error.message);
            emit(_Failed(error.message ?? ''));
          }
          return Left(ServerFailure(400, "Unhandled Error"));
        },
        (right) async {
          print("right.data");
          print(right.data);
          await addData(KeyStorage.accessToken, right.data);
          print(BoxMixin().getData(KeyStorage.accessToken));
          // await addData(KeyStorage.refreshToken, right.data['refreshToken']);
          emit(const _Success());
          navigatorKey.currentContext?.go(Transaksi2App.routeName);
          navigatorKey.currentContext?.pushNamed(Transaksi2App.routeName);
          //   navigatorKey.currentState?.push<void>(
          // MaterialPageRoute<void>(
          //   builder: (BuildContext context) => Transaksi2App(),
          // ),
          // );
          return Right(right.data);
        },
      );
    } catch (e) {
      print("e.toString()");
      print(e.toString());
      emit(_Failed(e.toString()));
      return Left(ServerFailure(400, e.toString()));
    }
  }

  Future<void> logout() async {
    await logoutBox();
    emit(const _Logout());
  }
}
