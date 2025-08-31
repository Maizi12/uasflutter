// lib/presentation/cubits/wallet/wallet_state.dart
import 'package:digit/data/models/response_go.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'wallet_state.freezed.dart';

@freezed
class WalletState with _$WalletState {
  const factory WalletState.initial() = _Initial;

  const factory WalletState.loading({
    @Default([]) List<GetWalletModel> wallets,
    GetWalletModel? selectedWallet,
    @Default(1) int currentPage,
    @Default(true) bool hasMoreTransactions,
  }) = _Loading;

  const factory WalletState.loaded({
    required List<GetWalletModel> wallets,
    required GetWalletModel selectedWallet,
    @Default(1) int currentPage,
    @Default(true) bool hasMoreWallets,
    @Default(false) bool isLoadingMore,
  }) = _Loaded;

  const factory WalletState.error({
    required String message,
    @Default([]) List<GetWalletModel> wallets,
    GetWalletModel? selectedWallet,
    @Default(1) int currentPage,
    @Default(true) bool hasMoreTransactions,
  }) = _Error;
}

// Extensions for easier access
extension WalletStateX on WalletState {
  bool get isLoading => maybeWhen(
        loading: (_, __, ___, ____) => true,
        loaded: (___, ____, _____, ________, isLoadingMore) => isLoadingMore,
        orElse: () => false,
      );

  bool get hasError => maybeWhen(
        error: (_, __, ___, ____, _____) => true,
        orElse: () => false,
      );

  String? get errorMessage => maybeWhen(
        error: (message, _, __, ___, ____) => message,
        orElse: () => null,
      );

  List<GetWalletModel> get wallets => when(
        initial: () => [],
        loading: (wallets, _, __, ___) => wallets,
        loaded: (wallets, _, __, ___, ______) => wallets,
        error: (_, wallets, __, ___, ______) => wallets,
      );

  GetWalletModel? get selectedWallet => when(
        initial: () => null,
        loading: (_, selectedWallet, __, ___) => selectedWallet,
        loaded: (_, selectedWallet, __, ___, ______) => selectedWallet,
        error: (_, __, selectedWallet, ___, ______) => selectedWallet,
      );
  int get currentPage => when(
        initial: () => 1,
        loading: (_, __, currentPage, ___) => currentPage,
        loaded: (_, __, currentPage, ___, ______) => currentPage,
        error: (_, __, ___, currentPage, ______) => currentPage,
      );
  bool hasMoreTransactions() => when(
        initial: () => true,
        loading: (_, __, ___, hasMoreTransactions) => hasMoreTransactions,
        loaded: (_, __, ___, ____, hasMoreTransactions) => hasMoreTransactions,
        error: (_, __, ___, ____, hasMoreTransactions) => hasMoreTransactions,
      );
}
