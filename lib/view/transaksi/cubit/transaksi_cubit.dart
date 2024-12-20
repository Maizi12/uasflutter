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

// GetTx.GetTransaksi? get meta => widget.meta;
List<GetTxModel> get tagObjs => widget.tagObjs;
// // String get dropdownWalletValue => widget.dropdownWalletValue;
List<GetWalletModel> get listWallet => widget.listWallet;
// GetWalletModel get selectedlistWallet => widget.selectedlistWallet;
List<Map<String, Object>> get _data1 => widget._data1;
RecentTx() async {
  var gettxs = await GetTxData("1", "10", "");
  setState(() {
    widget.tagObjs = gettxs;
  });
}

GetWallet() async {
  var getwallets = await GetWalletData("1", "10", "");
  setState(() {
    widget.listWallet.clear();
    widget.listWallet = getwallets;
    // widget.dropdownWalletValue = getwallets.first.NamaWallet;
    widget.selectedlistWallet = getwallets.first;
    widget.listWallet.add(GetWalletModel(
        NamaWallet: "Create Wallet", idWallet: 0, TotalSaldo: 0));
  });
  if (getwallets.isEmpty) {
    widget.listWallet = [
      GetWalletModel(idWallet: 2, NamaWallet: "Create Wallets", TotalSaldo: 0),
    ];
    GetWalletModel selectedlistWallet =
        GetWalletModel(idWallet: 3, NamaWallet: "z", TotalSaldo: 1);
  }
}

GetBeranda() async {
  GetBerandaModel getwallets;
  getwallets =
      await GetBerandaData(widget.selectedlistWallet!.idWallet); //testing
  if (widget.getberanda.isget == 0) {
    getwallets = await GetBerandaData(widget.selectedlistWallet!.idWallet);
  } else {
    getwallets = widget.getberanda;
  }
  if (widget.selectedlistWallet.idWallet != getwallets.idWallet) {
    getwallets = await GetBerandaData(widget.selectedlistWallet!.idWallet);
  }
  // print(widget.getberanda);
  // print(widget.getberanda.totalDebit);
  // print(widget.getberanda.totalKredit);
  // print(widget.getberanda.totalSisa);
  // print("widget.isHarian");
  // print(widget.isHarian);
  // print("widget.isBulanan");
  // print(widget.isBulanan);
  // print("widget.isMingguan");
  // print(widget.isMingguan);
  setState(() {
    if (widget.isHarian == 1) {
      widget._data1 = [];
    } else if (widget.isMingguan == 1) {
      widget._data1 = [];
    } else if (widget.isBulanan == 1) {
      widget._data1 = [];
    }
    widget.getberanda = getwallets;
  });
  print("widget._data1");
  print(widget._data1);
}
