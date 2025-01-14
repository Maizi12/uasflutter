import 'package:dartz/dartz.dart';
import 'package:uas_flutter/core/client/client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uas_flutter/feature/feature.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uas_flutter/domain/services/services.dart';
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
            '${AppConstants.API}${AppConstants.DigitUser}${AppConstants.V1}${AppConstants.Master}${AppConstants.Wallet}',
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
              jsonarray.map((model) => GetWalletModel(
                  idWallet: model["idWallet"],
                  NamaWallet: model["namaWallet"],
                  TotalSaldo: model["totalSaldo"])));
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
  Future<Either<Failure,List<GetJenisTransaksiModel>>> getJenisTransaksi( ) async {
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
          List<GetJenisTransaksiModel> gettx = List<GetJenisTransaksiModel>.from(
              jsonarray.map((model) => GetJenisTransaksiModel(
              idJenisTransaksi: model["idJenisTransaksi"],
              NamaJenisTransaksi: model["namaJenisTransaksi"],
            )));
          // await addData(KeyStorage.keytx, gettx);
          emit(const _Success());
          return Right(gettx);
        },
      );
    } catch (e) {
      emit(_Failed(e.toString()));
    return Left(ServerFailure(400, e.toString()));
    }

    // return response;
  }
 Future<Either<Failure,GetBerandaModel>> getBeranda(
  {
    int? idWallet,
  }
 ) async {
    try {
      final response = await getUseCase.call(
        url:
            '${AppConstants.API}${AppConstants.DigitUser}${AppConstants.V1}${AppConstants.Master}${AppConstants.Beranda}',
            queryParam: <String, dynamic>{'idWallet': "$idWallet",},
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
            return Left(
              ServerFailure(error.statusCode,error.message)
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
          var getberanda= GetBerandaModel.fromJson(jsonarray);
          // await removeData(KeyStorage.getBeranda);
          // await addData(KeyStorage.getBeranda, getberanda);
          emit(const _Success());
          print("getberanda");
          print(getberanda);
          print("getberanda.bulanan");
          print(getberanda.bulanan);
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
  Future<Either<Failure,List<GetTxModel>>> getRecentTx(
  {
    String? page,pageSize,id,sort,idJenisTransaksi,idWallet
  }
 ) async {
    try {
      final response = await getUseCase.call(
        url:
            '${AppConstants.API}${AppConstants.DigitTransaksi}${AppConstants.V1}${AppConstants.Transaksi}${AppConstants.Transaksi}',
            queryParam: <String, dynamic>{'page': "$page",'pageSize':"$pageSize",'id':"$id",'idJenisTransaksi':idJenisTransaksi,'idWallet':idWallet,},
        isUseToken: false,
        moreHeader: <String, String>{
          "acc": BoxMixin().getData(KeyStorage.accessToken),
        },
      );
     return response.fold(
        (error) {
          if (error is ServerFailure) {
            emit(_Failed(error.message ?? ''));
            return Left(
              ServerFailure(error.statusCode,error.message)
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
           List<GetTxModel> gettxs =List<GetTxModel>.from(jsonarray.map((model) => GetTxModel(
              idTransaksi: model["idTransaksi"],
              KeteranganTransaksi: model["KeteranganTransaksi"],
              idJenisTransaksi: model["idJenisTransaksi"],
              DebitKredit: model["debitKredit"],
              WaktuTransaksi: model["waktuTransaksi"],
              nominal: model["nominal"],
              idUser: model["idUser"],
              idWallet: model["idWallet"],
            )));
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

// GetTx.GetTransaksi? get meta => widget.meta;
// List<GetTxModel> get tagObjs => widget.tagObjs;
// // // String get dropdownWalletValue => widget.dropdownWalletValue;
// List<GetWalletModel> get listWallet => widget.listWallet;
// // GetWalletModel get selectedlistWallet => widget.selectedlistWallet;
// List<Map<String, Object>> get _data1 => widget._data1;
// RecentTx() async {
//   var gettxs = await GetTxData("1", "10", "");
//   setState(() {
//     widget.tagObjs = gettxs;
//   });
// }

// GetWallet() async {
//   var getwallets = await GetWalletData("1", "10", "");
//   setState(() {
//     widget.listWallet.clear();
//     widget.listWallet = getwallets;
//     // widget.dropdownWalletValue = getwallets.first.NamaWallet;
//     widget.selectedlistWallet = getwallets.first;
//     widget.listWallet.add(GetWalletModel(
//         NamaWallet: "Create Wallet", idWallet: 0, TotalSaldo: 0));
//   });
//   if (getwallets.isEmpty) {
//     widget.listWallet = [
//       GetWalletModel(idWallet: 2, NamaWallet: "Create Wallets", TotalSaldo: 0),
//     ];
//     GetWalletModel selectedlistWallet =
//         GetWalletModel(idWallet: 3, NamaWallet: "z", TotalSaldo: 1);
//   }
// }

// GetBeranda() async {
//   GetBerandaModel getwallets;
//   getwallets =
//       await GetBerandaData(widget.selectedlistWallet!.idWallet); //testing
//   if (widget.getberanda.isget == 0) {
//     getwallets = await GetBerandaData(widget.selectedlistWallet!.idWallet);
//   } else {
//     getwallets = widget.getberanda;
//   }
//   if (widget.selectedlistWallet.idWallet != getwallets.idWallet) {
//     getwallets = await GetBerandaData(widget.selectedlistWallet!.idWallet);
//   }
//   // print(widget.getberanda);
//   // print(widget.getberanda.totalDebit);
//   // print(widget.getberanda.totalKredit);
//   // print(widget.getberanda.totalSisa);
//   // print("widget.isHarian");
//   // print(widget.isHarian);
//   // print("widget.isBulanan");
//   // print(widget.isBulanan);
//   // print("widget.isMingguan");
//   // print(widget.isMingguan);
//   setState(() {
//     if (widget.isHarian == 1) {
//       widget._data1 = [];
//     } else if (widget.isMingguan == 1) {
//       widget._data1 = [];
//     } else if (widget.isBulanan == 1) {
//       widget._data1 = [];
//     }
//     widget.getberanda = getwallets;
//   });
//   print("widget._data1");
//   print(widget._data1);
// }
