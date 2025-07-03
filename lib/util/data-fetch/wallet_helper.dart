import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uas_flutter/domain/services/services.dart';
import 'package:uas_flutter/models/response-go.dart';
import 'package:uas_flutter/view/transaksi/cubit/transaksi_cubit.dart';

Future<List<GetWalletModel>> fetchWallet(BuildContext context) async {
  final result = await context
      .read<TransaksiCubit>()
      .getWallet(AppConstants.idJenisCoaWallet);

  return result.fold(
    (failure) {
      return [
        GetWalletModel(
          idWallet: 2,
          NamaWallet: "Create Wallets",
          TotalSaldo: 1,
          KodeCoa: "",
        )
      ];
    },
    (data) {
      final List<GetWalletModel> list = [...data];
      if (list.isNotEmpty) {
        list.add(
          GetWalletModel(
            NamaWallet: "Create Wallet",
            idWallet: 0,
            TotalSaldo: 0,
            KodeCoa: "",
          ),
        );
      }
      return list;
    },
  );
}
