part of 'transaksi_cubit.dart';

@freezed
class TransaksiState with _$TransaksiState {
  /// State with selectedWallet
  const factory TransaksiState.data({GetWalletModel? selectedWallet}) = _Loaded;
  const factory TransaksiState.list({List<GetWalletModel>? listselectedWallet}) = _LoadedList;


  const factory TransaksiState.initial() = _Initial;
  const factory TransaksiState.success() = _Success;
  const factory TransaksiState.failed(String message) = _Failed;
  const factory TransaksiState.logout() = _Logout;
}
  