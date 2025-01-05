part of 'transaksi_cubit.dart';

@freezed
class TransaksiState with _$TransaksiState {
  const factory TransaksiState.initial() = _Initial;
  const factory TransaksiState.success() = _Success;
  const factory TransaksiState.failed(String message) = _Failed;
  const factory TransaksiState.logout() = _Logout;
}
