import 'package:digit/data/models/general_response.dart';
import 'package:digit/data/models/response_go.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'transaksi_state.freezed.dart';

@freezed
class TransaksiState with _$TransaksiState {
  const factory TransaksiState.initial() = _Initial;

  const factory TransaksiState.loading({
    @Default([]) List<GetTxModel> transactions,
    GetWalletModel? wallet,
    GetTxModelDetail? transaction,
    @Default(1) int currentPage,
    @Default(true) bool hasMoreTransactions,
  }) = _Loading;

  const factory TransaksiState.loaded({
    @Default([]) List<GetTxModel> transactions,
    GetTxModelDetail? transaction,
    GetWalletModel? wallet,
    @Default(1) int currentPage,
    @Default(true) bool hasMoreTransactions,
    @Default(false) bool isLoadingMore,
  }) = _Loaded;

  const factory TransaksiState.error({
    required String message,
    @Default([]) List<GetTxModel> transactions,
    GetWalletModel? wallet,
    GetTxModelDetail? transaction,
    @Default(1) int currentPage,
    @Default(true) bool hasMoreTransactions,
  }) = _Error;

  const factory TransaksiState.created({
    required GeneralResponse message,
    @Default([]) List<GetTxModel> transactions,
  }) = _Created;

  const factory TransaksiState.updated({
    required GeneralResponse message,
    @Default([]) List<GetTxModel> transactions,
  }) = _Updated;
}

// Extensions for easier access
extension TransaksiStateX on TransaksiState {
  bool get isLoading => maybeWhen(
        loading: (_, __, ___, ____, _____) => true,
        loaded: (___, ____, _______, ________, _____, isLoadingMore) =>
            isLoadingMore,
        orElse: () => false,
      );

  bool get hasError => maybeWhen(
        error: (_, __, ___, ____, _______, _____) => true,
        orElse: () => false,
      );

  String? get errorMessage => maybeWhen(
        error: (message, _, __, ___, ____, _____) => message,
        orElse: () => null,
      );

  List<GetTxModel> get transactions => when(
        initial: () => [],
        loading: (transactions, _, __, ___, ____) => transactions,
        loaded: (transactions, ___, ____, _____, ______, _______) =>
            transactions,
        error: (___, transactions, ____, _____, ______, _______) =>
            transactions,
        created: (GeneralResponse message, List<GetTxModel> transactions) {
          return transactions;
        },
        updated: (GeneralResponse message, List<GetTxModel> transactions) {
          return transactions;
        },
      );

  bool get hasMoreTransactions => when(
        initial: () => true,
        loading: (_, __, ___, ____, hasMore) => hasMore,
        loaded: (_, __, ___, ____, hasMore, ______) => hasMore,
        error: (_, __, ___, ____, _____, hasMore) => hasMore,
        created: (GeneralResponse message, List<GetTxModel> transactions) =>
            false,
        updated: (GeneralResponse message, List<GetTxModel> transactions) =>
            false,
      );
}
