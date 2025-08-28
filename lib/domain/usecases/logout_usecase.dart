// import 'package:dartz/dartz.dart';
// import 'package:digit/core/client/client.dart';
// import 'package:digit/domain/repositories/golang-repository.dart';

// class LogOutUseCase {
//   final UserRepository _repository;
  
//   LogOutUseCase(this._repository);
  
//   Future<Either<Failure, dynamic>> execute(LogOutParams params) async {
//     return await _repository.LogOut(params.userName, params.password);
//   }
// }

// class LogOutParams {
//   final String userName;
//   final String password;
  
//   LogOutParams({required this.userName, required this.password});
// }