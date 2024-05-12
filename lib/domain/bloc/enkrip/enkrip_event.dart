part of 'enkrip_bloc.dart';

@immutable
sealed class EnkripEvent extends Equatable {
  const EnkripEvent();
  @override
  List<Object> get props => [];
}

class enkrip extends EnkripEvent {
  // late String ResponseCode;
  // late String ResponseMessage;
  // dynamic Data;
  // // enkrip();
  // @override
  // // TODO: implement props
  // List<Object> get props => [ResponseCode, ResponseMessage, Data];
}

class CheckKey extends EnkripEvent {}

// class Login extends EnkripEvent {}

class Login extends EnkripEvent {
  final String email;
  final String password;

  Login({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
  String toString() {
    return 'Login: (email: $email , password: $password)';
  }
}

// class LoggedIn extends EnkripEvent {
//   final String token;

//   LoggedIn({required this.token});

//   @override
//   List<Object> get props => [token];

//   @override
//   String toString() {
//     return 'LoggedIn(token: $token)';
//   }
// }
