import 'package:dartz/dartz.dart';
import 'package:uas_flutter/core/client/client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uas_flutter/feature/data/model/general_response.dart';
import 'package:uas_flutter/feature/feature.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uas_flutter/domain/services/services.dart';
import 'package:uas_flutter/models/coa.dart';
import 'package:uas_flutter/models/kategori.dart';
import 'package:uas_flutter/models/response-go.dart';
import 'package:uas_flutter/models/transaksi-go.dart';
import 'package:uas_flutter/repositories/transaksi-repository.dart';

part 'transaksi_state.dart';
part 'transaksi_cubit.freezed.dart';

class TransaksiCubit extends Cubit<TransaksiState> with BoxMixin {
  final GetRequestUseCase getUseCase;
  final PostRequestUseCase POSTUseCase;
  TransaksiCubit(this.getUseCase, this.POSTUseCase)
      : super(TransaksiState.initial());
  void selectWallet(GetWalletModel wallet) {
    if (!isClosed) {
      emit(TransaksiState.data(selectedWallet: wallet));
    }
    emit(TransaksiState.data(selectedWallet: wallet));

    // emit(state.copyWith(selectedWallet: wallet));
  }

  void listWallet(List<GetWalletModel> wallet) {
    if (!isClosed) {
      emit(TransaksiState.list(listselectedWallet: wallet));
    }
    emit(TransaksiState.list(listselectedWallet: wallet));
  }

  Future<Either<Failure, List<GetWalletModel>>> getWallet(
      int idJenisCoa) async {
    try {
      final response = await getUseCase.call(
        url:
            '${AppConstants.API}${AppConstants.DigitUser}${AppConstants.V1}${AppConstants.Master}${AppConstants.Coa}',
        queryParam: <String, dynamic>{"idJenisCoa": idJenisCoa},
        isUseToken: false,
        moreHeader: <String, String>{
          "acc": BoxMixin().getData(KeyStorage.accessToken),
        },
      );
      return response.fold(
        (error) {
          print("error");
          print(error.toString());
          if (error is ServerFailure) {
            emit(_Failed(error.message ?? ''));
          }
          return Left(error);
        },
        (right) async {
          print("right.data");
          print(right.data);
          Iterable jsonarray = (right.data);
          List<GetWalletModel> getwallet = List<GetWalletModel>.from(
              jsonarray.map((model) => GetWalletModel.fromJsonWallet(model)));
          // await addData(KeyStorage.keyWallet, getwallet);
          // emit(const _Success());
          print("getwallet");
          print(getwallet.first.NamaWallet);
          return Right(getwallet);
        },
      );
    } catch (e) {
      emit(_Failed(e.toString()));
      return Left(ServerFailure(400, e.toString()));
    }
  }

  Future<List<GetJenisCoaModel>> GetJenisTransaksi() async {
    List<GetJenisCoaModel> listJenisTransaksi = [
      GetJenisCoaModel(NamaJenisCoa: "Create Kategori", idJenisCoa: 0)
    ];
    final gettxs = await getJenisTransaksi();
    return gettxs.fold((failure) {
      return listJenisTransaksi;
    }, (data) {
      return data;
    });
  }

  Future<Either<Failure, List<GetJenisCoaModel>>> getJenisTransaksi() async {
    try {
      final response = await getUseCase.call(
        url:
            '${AppConstants.API}${AppConstants.DigitTransaksi}${AppConstants.V1}${AppConstants.Transaksi}${AppConstants.JenisTransaksi}',
        isUseToken: false,
        moreHeader: <String, String>{
          "acc": BoxMixin().getData(KeyStorage.accessToken),
        },
      );
      return response.fold(
        (error) {
          if (error is ServerFailure) {
            print("error.message");
            print(error.message);
            emit(_Failed(error.message ?? ''));
          }
          return Left(error);
        },
        (right) async {
          Iterable jsonarray = (right.data);
          List<GetJenisCoaModel> gettx = List<GetJenisCoaModel>.from(
              jsonarray.map((model) => GetJenisCoaModel.fromJson(model)));

          emit(const _Success());
          gettx.add(
              GetJenisCoaModel(NamaJenisCoa: "Create Kategori", idJenisCoa: 0));
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
    int? idCoaDebit,
  }) async {
    try {
      final response = await getUseCase.call(
        url:
            '${AppConstants.API}${AppConstants.DigitUser}${AppConstants.V1}${AppConstants.Master}${AppConstants.Beranda}',
        queryParam: <String, dynamic>{
          'idWallet': "$idWallet",
          'idCoaDebit': "$idCoaDebit",
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
      idCoaDebit,
      idCoaKredit,
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
          'idCoaDebit': "$idCoaDebit",
          'idCoaKredit': "$idCoaKredit",
          'idJenisTransaksi': idJenisTransaksi,
          'idCoa': idWallet,
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

  Future<Either<Failure, GetTxModelDetail>> getTxOne({dynamic id}) async {
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
          print("right.data ${right.data}");
          emit(const _Success());
          GetTxModelDetail gettxs = GetTxModelDetail.fromJson(right.data);
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

  Future<Either<Failure, GetCoaModel>> getCoaOne(
    int idCoa,
  ) async {
    try {
      final response = await getUseCase.call(
        url:
            '${AppConstants.API}${AppConstants.DigitUser}${AppConstants.V1}${AppConstants.Master}${AppConstants.Coa}',
        isUseToken: false,
        queryParam: <String, dynamic>{
          'idCoa': "$idCoa",
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
          emit(const _Success());
          GetCoaModel gettxs = GetCoaModel.fromJson(right.data);
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
    String tanggal,
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

  Future<Either<Failure, GeneralResponse>> UpdateTransaksi(
      TransaksiGo Transaksi) async {
    try {
      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "acc": BoxMixin().getData(KeyStorage.accessToken),
      };
      final updatetx =
          await TransaksiRepository().UpdateTransaksiRepo(Transaksi);
      print("updatetx");
      print(updatetx);
      final response = await POSTUseCase.call(
          url:
              '${AppConstants.API}${AppConstants.DigitTransaksi}${AppConstants.V1}${AppConstants.Transaksi}${AppConstants.Transaksi}',
          isUseToken: false,
          moreHeader: header,
          queryParam: <String, dynamic>{"menu": "update"},
          data: updatetx);
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
          var data = GeneralResponse.fromJson(right.toJson());
          return Right(data);
        },
      );
    } catch (e, stackTrace) {
      print("Exception caught: $e");
      print("Stack trace: $stackTrace");
      emit(_Failed(e.toString()));
      return Left(ServerFailure(400, e.toString()));
    }
  }

  Future<Either<Failure, GeneralResponse>> CreateTransaksi(
      List<TransaksiGo> Transaksi) async {
    try {
      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "acc": BoxMixin().getData(KeyStorage.accessToken),
      };
      final createtx =
          await TransaksiRepository().CreateTransaksiRepo(Transaksi);
      print("createtx");
      print(createtx);
      final response = await POSTUseCase.call(
          url:
              '${AppConstants.API}${AppConstants.DigitTransaksi}${AppConstants.V1}${AppConstants.Transaksi}${AppConstants.Transaksi}',
          isUseToken: false,
          moreHeader: header,
          queryParam: <String, dynamic>{"menu": "create"},
          data: createtx);
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
          // navigatorKey.currentContext?.go(Transaksi2App.routeName);
          // navigatorKey.currentContext?.pushNamed(Transaksi2App.routeName);
          var data = GeneralResponse.fromJson(right.toJson());
          return Right(data);
        },
      );
    } catch (e, stackTrace) {
      print("Exception caught: $e");
      print("Stack trace: $stackTrace");
      emit(_Failed(e.toString()));
      return Left(ServerFailure(400, e.toString()));
    }
  }
}
