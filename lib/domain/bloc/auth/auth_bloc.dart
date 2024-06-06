import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uas_flutter/repositories/golang-repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;
  AuthBloc({required this.userRepository}) : super(AuthInitial()) {
    on<AppStarted>((event, emit) async {
      //   final bool hasToken = await userRepository.hasToken();
      //   if (hasToken) {
      //     emit(AuthAuthenticated());
      //   } else {
      //     emit(AuthUnauthenticated());
      // }
    });

    on<LoggedIn>((event, emit) async {
      emit(AuthLoading());
      await userRepository.storeToken(event.token);
      emit(AuthAuthenticated());
    });

    // on<CheckToken>((event, emit) async {
    //   final String? data = await userRepository.getToken();
    //   print('token asli ini: ${data.toString()}');
    //   emit(AuthAuthenticated());
    // });

    // on<LoggedOut>((event, emit) async {
    //   emit(AuthLoading());
    //   await userRepository.deleteToken();
    //   emit(AuthUnauthenticated());
    // });
  }
}
