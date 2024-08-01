part of 'transaksi_bloc.dart';

@immutable
sealed class TransaksiEvent extends Equatable {
  const TransaksiEvent();
  @override
  List<Object> get props => [];
}

class transaksi extends TransaksiEvent {
  // late String ResponseCode;
  // late String ResponseMessage;
  // dynamic Data;
  // // transaksi();
  // @override
  // // TODO: implement props
  // List<Object> get props => [ResponseCode, ResponseMessage, Data];
}

class GetTransaksi extends TransaksiEvent {
  final String page;
  final String id;
  final String pagesize;

  GetTransaksi({required this.page, required this.pagesize, required this.id});

  @override
  List<Object> get props => [page, pagesize, id];
  String toString() {
    return 'Login: (page: $page , pagesize: $pagesize,id:$id)';
  }
}

class CreateTransaksi extends TransaksiEvent {
  final TransaksiGo;
  CreateTransaksi({required this.TransaksiGo});
  @override
  List<Object> get props => [TransaksiGo];
  String toString() {
    return 'CreateTransaksi: (TransaksiGo)';
  }
}
