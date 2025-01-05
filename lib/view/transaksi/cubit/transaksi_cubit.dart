import 'package:uas_flutter/core/client/client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uas_flutter/feature/feature.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uas_flutter/domain/services/services.dart';
import 'package:uas_flutter/models/response-go.dart';
import 'package:uas_flutter/repositories/golang-repository.dart';
import 'package:uas_flutter/repositories/transaksi-repository.dart';

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
