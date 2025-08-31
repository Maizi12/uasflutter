import 'package:dartz/dartz.dart';
import 'package:digit/core/core.dart';
import 'package:digit/core/utils/constant/appconstants.dart';
import 'package:digit/data/models/response_go.dart';
import 'package:digit/data/models/general_response.dart';
import 'package:digit/domain/repository/transaksi_repository.dart';
import 'package:digit/domain/usecases/get_request_use_case.dart';
import 'package:digit/domain/usecases/post_request_use_case.dart';
import 'package:digit/domain/services/hive/hive.dart';

class TransaksiRepositoryImpl implements TransaksiRepository {
  final GetRequestUseCase getUseCase;
  final PostRequestUseCase postUseCase;

  TransaksiRepositoryImpl(this.getUseCase, this.postUseCase);

  @override
  Future<Either<Failure, List<GetWalletModel>>> getWallet(int idJenisCoa) async {
    try {
      final response = await getUseCase.call(
        url: '${AppConstants.API}${AppConstants.DigitUser}${AppConstants.V1}${AppConstants.Master}${AppConstants.Coa}',
        queryParam: <String, dynamic>{"idJenisCoa": idJenisCoa},
        isUseToken: false,
        moreHeader: <String, String>{
          "acc": BoxMixin().getData(KeyStorage.accessToken),
        },
      );
      
      return response.fold(
        (error) {
          if (error is ServerFailure) {
            return Left(ServerFailure(error.statusCode, error.message));
          }
          return Left(ServerFailure(400, "Unhandled Error"));
        },
        (right) async {
          Iterable jsonarray = (right.data);
          List<GetWalletModel> getwallet = List<GetWalletModel>.from(
              jsonarray.map((model) => GetWalletModel.fromJsonWallet(model)));
          return Right(getwallet);
        },
      );
    } catch (e) {
      return Left(ServerFailure(400, e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GetJenisCoaModel>>> getJenisTransaksi() async {
    try {
      final response = await getUseCase.call(
        url: '${AppConstants.API}${AppConstants.DigitTransaksi}${AppConstants.V1}${AppConstants.Transaksi}${AppConstants.JenisTransaksi}',
        isUseToken: false,
        moreHeader: <String, String>{
          "acc": BoxMixin().getData(KeyStorage.accessToken),
        },
      );
      
      return response.fold(
        (error) {
          if (error is ServerFailure) {
            return Left(ServerFailure(error.statusCode, error.message));
          }
          return Left(ServerFailure(400, "Unhandled Error"));
        },
        (right) async {
          Iterable jsonarray = (right.data);
          List<GetJenisCoaModel> gettx = List<GetJenisCoaModel>.from(
              jsonarray.map((model) => GetJenisCoaModel.fromJson(model)));
          gettx.add(GetJenisCoaModel(NamaJenisCoa: "Create Kategori", idJenisCoa: 0));
          return Right(gettx);
        },
      );
    } catch (e) {
      return Left(ServerFailure(400, e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetBerandaModel>> getBeranda({
    int? idWallet,
    int? idCoaDebit,
  }) async {
    try {
      final response = await getUseCase.call(
        url: '${AppConstants.API}${AppConstants.DigitUser}${AppConstants.V1}${AppConstants.Master}${AppConstants.Beranda}',
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
            return Left(ServerFailure(error.statusCode, error.message));
          }
          return Left(ServerFailure(400, "Unhandled Error"));
        },
        (right) async {
          var jsonarray = (right.data);
          var getberanda = GetBerandaModel.fromJson(jsonarray);
          return Right(getberanda);
        },
      );
    } catch (e) {
      return Left(ServerFailure(400, e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GetTxModel>>> getRecentTx({
    String? page,
    pageSize,
    id,
    idCoaDebit,
    idCoaKredit,
    sort,
    idJenisTransaksi,
    idWallet,
    tglAwal,
    tglAkhir,
  }) async {
    try {
      final response = await getUseCase.call(
        url: '${AppConstants.API}${AppConstants.DigitTransaksi}${AppConstants.V1}${AppConstants.Transaksi}${AppConstants.Transaksi}',
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
            return Left(ServerFailure(error.statusCode, error.message));
          }
          return Left(ServerFailure(400, "Unhandled Error"));
        },
        (right) async {
          var jsonarray = (right.data);
          List<GetTxModel> gettxs = List<GetTxModel>.from(
              jsonarray.map((model) => GetTxModel.fromJson(model)));
          return Right(gettxs);
        },
      );
    } catch (e) {
      return Left(ServerFailure(400, e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetTxModelDetail>> getTxOne({dynamic id}) async {
    try {
      final response = await getUseCase.call(
        url: '${AppConstants.API}${AppConstants.DigitTransaksi}${AppConstants.V1}${AppConstants.Transaksi}${AppConstants.Transaksi}',
        queryParam: <String, dynamic>{'idTransaksi': "$id"},
        isUseToken: false,
        moreHeader: <String, String>{
          "acc": BoxMixin().getData(KeyStorage.accessToken),
        },
      );
      
      return response.fold(
        (error) {
          if (error is ServerFailure) {
            return Left(ServerFailure(error.statusCode, error.message));
          }
          return Left(ServerFailure(400, "Unhandled Error"));
        },
        (right) async {
          GetTxModelDetail gettxs = GetTxModelDetail.fromJson(right.data);
          return Right(gettxs);
        },
      );
    } catch (e) {
      return Left(ServerFailure(400, e.toString()));
    }
  }

  @override
  Future<Either<Failure, GeneralResponse>> createTransaksi(List<dynamic> transaksi) async {
    try {
      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "acc": BoxMixin().getData(KeyStorage.accessToken),
      };
      
      final response = await postUseCase.call(
        url: '${AppConstants.API}${AppConstants.DigitTransaksi}${AppConstants.V1}${AppConstants.Transaksi}${AppConstants.Transaksi}',
        isUseToken: false,
        moreHeader: header,
        queryParam: <String, dynamic>{"menu": "create"},
        data: {"transaksi": transaksi},
      );
      
      return response.fold(
        (error) {
          if (error is ServerFailure) {
            return Left(ServerFailure(error.statusCode, error.message));
          }
          return Left(ServerFailure(400, "Unhandled Error"));
        },
        (right) async {
          var data = GeneralResponse.fromJson(right.toJson());
          return Right(data);
        },
      );
    } catch (e) {
      return Left(ServerFailure(400, e.toString()));
    }
  }

  @override
  Future<Either<Failure, GeneralResponse>> updateTransaksi(dynamic transaksi) async {
    try {
      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "acc": BoxMixin().getData(KeyStorage.accessToken),
      };
      
      final response = await postUseCase.call(
        url: '${AppConstants.API}${AppConstants.DigitTransaksi}${AppConstants.V1}${AppConstants.Transaksi}${AppConstants.Transaksi}',
        isUseToken: false,
        moreHeader: header,
        queryParam: <String, dynamic>{"menu": "update"},
        data: transaksi,
      );
      
      return response.fold(
        (error) {
          if (error is ServerFailure) {
            return Left(ServerFailure(error.statusCode, error.message));
          }
          return Left(ServerFailure(400, "Unhandled Error"));
        },
        (right) async {
          var data = GeneralResponse.fromJson(right.toJson());
          return Right(data);
        },
      );
    } catch (e) {
      return Left(ServerFailure(400, e.toString()));
    }
  }
}
