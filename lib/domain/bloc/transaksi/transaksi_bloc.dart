import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:uas_flutter/domain/bloc/auth/auth_bloc.dart';
import 'package:uas_flutter/domain/services/transaksi-services.dart';
import 'package:uas_flutter/models/response-go.dart';
import 'package:uas_flutter/models/transaksi-go.dart';
part "transaksi_event.dart";
part "transaksi_state.dart";

class TransaksiBloc extends Bloc<TransaksiEvent, TransaksiState> {
  // final UserRepository userRepository;
  final AuthBloc authBloc;
  TransaksiBloc(
    this.authBloc,
  ) : super(TransaksiInitial()) {
    on<GetTransaksi>((event, emit) async {
      // TODO: implement event handler
      try {
        // emit(TransaksiLoading())
        emit(TransaksiLoading());
        final transaksi = await TransaksiServices()
            .getTransaksi(event.page, event.pagesize, event.id);
        MetaModel meta = MetaModel.fromMap(transaksi);
        print("meta.code");
        print(meta.code);
        print("meta.message $meta.message");
        print("meta.data $meta.data");
        if (meta.code == "201") {
          emit(SuccessTransaksi(result: transaksi));
        }
        if (meta.code != "200") {
          emit(FailedTransaksi(metaModel: transaksi));
        }
      } catch (e) {
        emit(FailedTransaksi(
            metaModel: MetaModel(message: "Error", code: "201", data: null)));
      }
    });
    on<CreateTransaksi>((event, emit) async {
      try{

      }catch (e) {
        emit(FailedTransaksi(
            metaModel: MetaModel(message: "Error", code: "201", data: null)));
      }
    });
  }
}
