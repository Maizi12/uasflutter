import 'package:dartz/dartz.dart';
import 'package:uas_flutter/core/client/client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uas_flutter/feature/feature.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uas_flutter/domain/services/services.dart';
import 'package:uas_flutter/models/coa.dart';
import 'package:uas_flutter/models/kategori.dart';
import 'package:uas_flutter/models/response-go.dart';

part 'transaksi_state.dart';
part 'transaksi_cubit.freezed.dart';

class TransaksiCubit extends Cubit<TransaksiState> with BoxMixin {
  final GetRequestUseCase getUseCase;
  TransaksiCubit(this.getUseCase) : super(TransaksiState.initial());

  Future<void> getWallet() async {
    try {
      final response = await getUseCase.call(
        url:
            '${AppConstants.API}${AppConstants.DigitUser}${AppConstants.V1}${AppConstants.Master}${AppConstants.Coa}',
        queryParam: <String, dynamic>{"idJenisCoa": 1},
        isUseToken: false,
        moreHeader: <String, String>{
          "acc": BoxMixin().getData(KeyStorage.accessToken),
        },
      );
      response.fold(
        (error) {
          if (error is ServerFailure) {
            emit(_Failed(error.message ?? ''));
          }
        },
        (right) async {
          Iterable jsonarray = (right.data);
          List<GetWalletModel> getwallet = List<GetWalletModel>.from(
              jsonarray.map((model) => GetWalletModel.fromJsonWallet(model)));
          await addData(KeyStorage.keyWallet, getwallet);
          emit(const _Success());
          return getwallet;
        },
      );
    } catch (e) {
      emit(_Failed(e.toString()));
    }

    // return response;
  }

  Future<Either<Failure, List<GetJenisTransaksiModel>>>
      getJenisTransaksi() async {
    try {
      final response = await getUseCase.call(
        url:
            '${AppConstants.API}${AppConstants.DigitTransaksi}${AppConstants.V1}${AppConstants.Transaksi}${AppConstants.JenisTransaksi}',
        isUseToken: false,
        // queryParam: <String,dynamic>{
        //   "idJenisTransaksi":idJenisTransaksi
        // },
        moreHeader: <String, String>{
          "acc": BoxMixin().getData(KeyStorage.accessToken),
        },
      );
      return response.fold(
        (error) {
          if (error is ServerFailure) {
            emit(_Failed(error.message ?? ''));
          }
          return Left(error);
        },
        (right) async {
          Iterable jsonarray = (right.data);
          List<GetJenisTransaksiModel> gettx =
              List<GetJenisTransaksiModel>.from(jsonarray
                  .map((model) => GetJenisTransaksiModel.fromJson(model)));
          // await addData(KeyStorage.keytx, gettx);
          emit(const _Success());
          return Right(gettx);
        },
      );
    } catch (e) {
      emit(_Failed(e.toString()));
      return Left(ServerFailure(400, e.toString()));
    }
  }

  Future<Either<Failure, GetBerandaModel>> getBeranda({
    int? idWallet,
  }) async {
    try {
      final response = await getUseCase.call(
        url:
            '${AppConstants.API}${AppConstants.DigitUser}${AppConstants.V1}${AppConstants.Master}${AppConstants.Beranda}',
        queryParam: <String, dynamic>{
          'idWallet': "$idWallet",
        },
        isUseToken: false,
        moreHeader: <String, String>{
          "acc": BoxMixin().getData(KeyStorage.accessToken),
        },
      );
      return response.fold(
        (error) {
          if (error is ServerFailure) {
            emit(_Failed(error.message ?? ''));
            return Left(ServerFailure(error.statusCode, error.message));
          } else {
            emit(_Failed('Unhandled'));
            return Left(ServerFailure(400, "Unhandled Error"));
          }
        },
        (right) async {
          var jsonarray = (right.data);
          var getberanda = GetBerandaModel.fromJson(jsonarray);
          emit(const _Success());
          return Right(getberanda);
        },
      );
    } catch (e, stackTrace) {
      print("Exception caught: $e");
      print("Stack trace: $stackTrace");
      emit(_Failed(e.toString()));
      return Left(ServerFailure(400, e.toString()));
    }
  }

  Future<Either<Failure, List<GetTxModel>>> getRecentTx(
      {String? page,
      pageSize,
      id,
      sort,
      idJenisTransaksi,
      idWallet,
      tglAwal,
      tglAkhir}) async {
    try {
      final response = await getUseCase.call(
        url:
            '${AppConstants.API}${AppConstants.DigitTransaksi}${AppConstants.V1}${AppConstants.Transaksi}${AppConstants.Transaksi}',
        queryParam: <String, dynamic>{
          'page': "$page",
          'pageSize': "$pageSize",
          'id': "$id",
          'idJenisTransaksi': idJenisTransaksi,
          'idWallet': idWallet,
          'tglAwal': tglAwal,
          'tglAkhir': tglAkhir,
          'sort': sort
        },
        isUseToken: false,
        moreHeader: <String, String>{
          "acc": BoxMixin().getData(KeyStorage.accessToken),
        },
      );
      return response.fold(
        (error) {
          if (error is ServerFailure) {
            emit(_Failed(error.message ?? ''));
            return Left(ServerFailure(error.statusCode, error.message)
                // error.message
                );
          } else {
            // Handle other possible error types
            emit(_Failed('Unhandled'));
            return Left(ServerFailure(400, "Unhandled Error"));
          }
        },
        (right) async {
          var jsonarray = (right.data);
          // var getberanda= GetTxModel.fromJson(jsonarray);
          // await removeData(KeyStorage.getBeranda);
          // await addData(KeyStorage.getBeranda, getberanda);
          emit(const _Success());
          List<GetTxModel> gettxs = List<GetTxModel>.from(
              jsonarray.map((model) => GetTxModel.fromJson(model)));
          return Right(gettxs);
        },
      );
    } catch (e, stackTrace) {
      print("Exception caught: $e");
      print("Stack trace: $stackTrace");
      emit(_Failed(e.toString()));
      return Left(ServerFailure(400, e.toString()));
    }
  }

  Future<Either<Failure, GetTxModel>> getTxOne({dynamic id}) async {
    try {
      final response = await getUseCase.call(
        url:
            '${AppConstants.API}${AppConstants.DigitTransaksi}${AppConstants.V1}${AppConstants.Transaksi}${AppConstants.Transaksi}',
        queryParam: <String, dynamic>{'idTransaksi': "$id"},
        isUseToken: false,
        moreHeader: <String, String>{
          "acc": BoxMixin().getData(KeyStorage.accessToken),
        },
      );
      return response.fold(
        (error) {
          if (error is ServerFailure) {
            emit(_Failed(error.message ?? ''));
            return Left(ServerFailure(error.statusCode, error.message)
                // error.message
                );
          } else {
            // Handle other possible error types
            emit(_Failed('Unhandled'));
            return Left(ServerFailure(400, "Unhandled Error"));
          }
        },
        (right) async {
          var jsonarray = (right.data);
          print("right.data ${right.data}");
          emit(const _Success());
          GetTxModel gettxs = GetTxModel.fromJson(jsonarray);
          return Right(gettxs);
        },
      );
    } catch (e, stackTrace) {
      print("Exception caught: $e");
      print("Stack trace: $stackTrace");
      emit(_Failed(e.toString()));
      return Left(ServerFailure(400, e.toString()));
    }
  }

  Future<Either<Failure, List<GetCategoriesModel>>> getCategories() async {
    try {
      final response = await getUseCase.call(
        url:
            '${AppConstants.API}${AppConstants.DigitUser}${AppConstants.V1}${AppConstants.Master}${AppConstants.JenisCoa}',
        isUseToken: false,
        moreHeader: <String, String>{
          "acc": BoxMixin().getData(KeyStorage.accessToken),
        },
      );
      return response.fold(
        (error) {
          if (error is ServerFailure) {
            emit(_Failed(error.message ?? ''));
            return Left(ServerFailure(error.statusCode, error.message));
          } else {
            emit(_Failed('Unhandled'));
            return Left(ServerFailure(400, "Unhandled Error"));
          }
        },
        (right) async {
          var jsonarray = (right.data);
          emit(const _Success());
          List<GetCategoriesModel> gettxs = List<GetCategoriesModel>.from(
              jsonarray.map((model) => GetCategoriesModel.fromJson(model)));
          return Right(gettxs);
        },
      );
    } catch (e, stackTrace) {
      print("Exception caught: $e");
      print("Stack trace: $stackTrace");
      emit(_Failed(e.toString()));
      return Left(ServerFailure(400, e.toString()));
    }
  }

  Future<Either<Failure, List<GetCoaModel>>> getCoa(
    dynamic idJenisCoa,
  ) async {
    try {
      final response = await getUseCase.call(
        url:
            '${AppConstants.API}${AppConstants.DigitUser}${AppConstants.V1}${AppConstants.Master}${AppConstants.Coa}',
        isUseToken: false,
        queryParam: <String, dynamic>{
          'idJenisCoa': "$idJenisCoa",
        },
        moreHeader: <String, String>{
          "acc": BoxMixin().getData(KeyStorage.accessToken),
        },
      );
      return response.fold(
        (error) {
          if (error is ServerFailure) {
            emit(_Failed(error.message ?? ''));
            return Left(ServerFailure(error.statusCode, error.message));
          } else {
            emit(_Failed('Unhandled'));
            return Left(ServerFailure(400, "Unhandled Error"));
          }
        },
        (right) async {
          var jsonarray = (right.data);
          emit(const _Success());
          List<GetCoaModel> gettxs = List<GetCoaModel>.from(
              jsonarray.map((model) => GetCoaModel.fromJson(model)));
          return Right(gettxs);
        },
      );
    } catch (e, stackTrace) {
      print("Exception caught: $e");
      print("Stack trace: $stackTrace");
      emit(_Failed(e.toString()));
      return Left(ServerFailure(400, e.toString()));
    }
  }

  Future<void> logout() async {
    await logoutBox();
    emit(const _Logout());
  }
}
