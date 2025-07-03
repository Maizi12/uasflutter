import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uas_flutter/models/response-go.dart';
import 'package:uas_flutter/view/transaksi/cubit/transaksi_cubit.dart';

Future<List<GetTxModel>> RecentTxGet(BuildContext context, int idWallet,
    int idJenisTransaksi, String tglAwal, String tglAkhir, int page) async {
  final result = await context.read<TransaksiCubit>().getRecentTx(
      page: 1.toString(),
      pageSize: (page * 10).toString(),
      id: "0",
      idCoaDebit: idWallet,
      idCoaKredit: idWallet,
      idWallet: idWallet,
      idJenisTransaksi: idJenisTransaksi,
      tglAwal: tglAwal,
      tglAkhir: tglAkhir);

  return result.fold(
    (failure) {
      return [GetTxModel.empty()];
    },
    (data) {
      final List<GetTxModel> list = [...data];
      return list;
    },
  );
}

Future<GetTxModelDetail> RecentTxOne(BuildContext context, int idTx) async {
  final result = await context.read<TransaksiCubit>().getTxOne(id: idTx);

  return result.fold(
    (failure) {
      return GetTxModelDetail.empty();
    },
    (data) {
      return data;
    },
  );
}
