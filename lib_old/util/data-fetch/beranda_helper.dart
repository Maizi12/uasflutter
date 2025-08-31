import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uas_flutter/models/response-go.dart';
import 'package:uas_flutter/view/transaksi/cubit/transaksi_cubit.dart';

Future<GetBerandaModel> fetchBeranda(
    BuildContext context, int idCoaDebit) async {
  final result =
      await context.read<TransaksiCubit>().getBeranda(idCoaDebit: idCoaDebit);
  return result.fold(
    (failure) {
      return GetBerandaModel.empty();
    },
    (data) {
      final GetBerandaModel result = data;
      return result;
    },
  );
}
