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

// class Login extends TransaksiEvent {}


// class LoggedIn extends TransaksiEvent {
//   final String token;

//   LoggedIn({required this.token});

//   @override
//   List<Object> get props => [token];

//   @override
//   String toString() {
//     return 'LoggedIn(token: $token)';
//   }
// }
