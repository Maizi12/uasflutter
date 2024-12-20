part of 'transaksi_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.success() = _Success;
  const factory AuthState.failed(String message) = _Failed;
  const factory AuthState.logout() = _Logout;
}
