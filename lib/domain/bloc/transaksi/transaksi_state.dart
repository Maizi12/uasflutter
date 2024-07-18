part of 'transaksi_bloc.dart';

@immutable
sealed class TransaksiState extends Equatable {
  const TransaksiState();
  @override
  List<Object> get props => [];
}

class TransaksiInitial extends TransaksiState {}

class TransaksiLoading extends TransaksiState {}

class SuccessTransaksi extends TransaksiState {
  final dynamic result;

  SuccessTransaksi({required this.result});
  @override
  List<Object> get props => [result];
}

class FailedTransaksi extends TransaksiState {
  final MetaModel metaModel;

  FailedTransaksi({required this.metaModel});

  @override
  List<Object> get props => [metaModel];
}
