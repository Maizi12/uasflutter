import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:uas_flutter/domain/services/enkrip-services.dart';
import 'package:uas_flutter/models/response-go.dart';
part "enkrip_event.dart";
part "enkrip_state.dart";

class EnkripBloc extends Bloc<EnkripEvent, EnkripState> {
  EnkripBloc() : super(EnkripInitial()) {
    on<EnkripEvent>((event, emit) async {
      // TODO: implement event handler
      try {
        // emit(EnkripLoading())
        emit(EnkripLoading());
        final enkrips = await EnkripServices().enkrip();
        try {
          MetaModel meta = MetaModel.fromJson(enkrips);
        } catch (e) {
          print("error from Map $e");
        }
        MetaModel meta = MetaModel.fromJson(enkrips);
        print("meta.code");
        print(meta.code);
        print("meta.message");
        print(meta.message);
        print("meta.data");
        print(meta.data);
        if (meta.code == "201") {
          emit(SuccessEnkrip(result: enkrips));
        }
        if (meta.code != "200") {
          emit(FailedEnkrip(metaModel: enkrips));
        }
      } catch (e) {
        emit(FailedEnkrip(
            metaModel: MetaModel(message: "Error", code: "201", data: null)));
      }
    });
    on<CheckKey>((event, emit) async {
      // TODO: implement event handler
      try {
        // emit(EnkripLoading())
        emit(EnkripLoading());
        final enkrips = await EnkripServices().enkrip();
        MetaModel meta = MetaModel.fromMap(enkrips);
        print("meta.code");
        print(meta.code);
        print("meta.message $meta.message");
        print("meta.data $meta.data");
        if (meta.code == "201") {
          emit(SuccessEnkrip(result: enkrips));
        }
        if (meta.code != "200") {
          emit(FailedEnkrip(metaModel: enkrips));
        }
      } catch (e) {
        emit(FailedEnkrip(
            metaModel: MetaModel(message: "Error", code: "201", data: null)));
      }
    });
  }

  // Future<void> _enkrip(enkrip event, Emitter<EnkripState> emit) async {
  //   try {
  //     // emit(EnkripLoading())
  //     emit(EnkripLoading());
  //     final enkrips = await EnkripServices().enkrip();
  //     MetaModel meta = MetaModel.fromMap(enkrips["metadata"]);
  //     if (meta.code == "200") {
  //       emit(SuccessEnkrip(result: enkrips));
  //     }
  //     if (meta.code != "200") {
  //       emit(FailedEnkrip(metaModel: enkrips));
  //     }
  //   } catch (e) {
  //     emit(FailedEnkrip(
  //         metaModel: MetaModel(message: "Error", code: "201", data: null)));
  //   }
  // }
}
