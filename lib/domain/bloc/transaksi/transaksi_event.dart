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

class GetTransaksi extends TransaksiEvent {}

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
