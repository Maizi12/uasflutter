import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uas_flutter/models/coa.dart';
import 'package:uas_flutter/view/transaksi/cubit/transaksi_cubit.dart';

Future<List<GetCoaModel>> FetchCoa(BuildContext context, int idJenisCoa) async {
  final result = await context.read<TransaksiCubit>().getCoa(idJenisCoa, "");
  return result.fold(
    (failure) {
      return [GetCoaModel.empty()];
    },
    (data) {
      final List<GetCoaModel> list = [...data];
      return list;
    },
  );
}
