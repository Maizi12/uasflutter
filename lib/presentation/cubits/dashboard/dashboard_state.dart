import 'package:digit/data/models/response_go.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'dashboard_state.freezed.dart';

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState.initial() = _Initial;

  const factory DashboardState.loading({
    @Default([]) List<GetWalletModel> wallets,
    GetWalletModel? selectedWallet,
    @Default([]) List<GetTxModel> transactions,
    GetBerandaModel? beranda,
    @Default(1) int currentPage,
    @Default(true) bool hasMoreTransactions,
  }) = _Loading;

  const factory DashboardState.loaded({
    required List<GetWalletModel> wallets,
    required GetWalletModel selectedWallet,
    @Default([]) List<GetTxModel> transactions,
    GetBerandaModel? beranda,
    @Default(1) int currentPage,
    @Default(true) bool hasMoreTransactions,
    @Default(false) bool isLoadingMore,
  }) = _Loaded;

  const factory DashboardState.error({
    required String message,
    @Default([]) List<GetWalletModel> wallets,
    GetWalletModel? selectedWallet,
    @Default([]) List<GetTxModel> transactions,
    GetBerandaModel? beranda,
    @Default(1) int currentPage,
    @Default(true) bool hasMoreTransactions,
  }) = _Error;
}

// Extensions for easier access
extension DashboardStateX on DashboardState {
  bool get isLoading => maybeWhen(
        loading: (_, __, ___, ____, _____, ______) => true,
        loaded: (___, ____, _____, ______, _______, ________, isLoadingMore) =>
            isLoadingMore,
        orElse: () => false,
      );

  bool get hasError => maybeWhen(
        error: (_, __, ___, ____, _____, ______, _______) => true,
        orElse: () => false,
      );

  String? get errorMessage => maybeWhen(
        error: (message, _, __, ___, ____, _____, ______) => message,
        orElse: () => null,
      );

  List<GetWalletModel> get wallets => when(
        initial: () => [],
        loading: (wallets, _, __, ___, ____, _____) => wallets,
        loaded: (wallets, _, __, ___, ____, _____, ______) => wallets,
        error: (_, wallets, __, ___, ____, _____, ______) => wallets,
      );

  GetWalletModel? get selectedWallet => when(
        initial: () => null,
        loading: (_, selectedWallet, __, ___, ____, _____) => selectedWallet,
        loaded: (_, selectedWallet, __, ___, ____, _____, ______) =>
            selectedWallet,
        error: (_, __, selectedWallet, ___, ____, _____, ______) =>
            selectedWallet,
      );

  List<GetTxModel> get transactions => when(
        initial: () => [],
        loading: (_, __, transactions, ___, ____, _____) => transactions,
        loaded: (_, __, transactions, ___, ____, _____, ______) => transactions,
        error: (_, __, ___, transactions, ____, _____, ______) => transactions,
      );

  bool get hasMoreTransactions => when(
        initial: () => true,
        loading: (_, __, ___, ____, _____, hasMore) => hasMore,
        loaded: (_, __, ___, ____, _____, hasMore, ______) => hasMore,
        error: (_, __, ___, ____, _____, ______, hasMore) => hasMore,
      );

  GetBerandaModel? get beranda => when(
        initial: () => null,
        loading: (_, __, ___, beranda, ____, _____) => beranda,
        loaded: (_, __, ___, beranda, ____, _____, ______) => beranda,
        error: (_, __, ___, ____, beranda, ______, _____) => beranda,
      );
}
