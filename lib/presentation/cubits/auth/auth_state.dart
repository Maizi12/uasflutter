// import 'package:freezed_annotation/freezed_annotation.dart';

part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated() = _Authenticated; // Use String or create User model
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.failed(String message) = _Failed;
  const factory AuthState.keyLoaded() = _KeyLoaded;
}