import 'package:digit/data/models/general_response.dart';
import 'package:digit/data/models/response_go.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'transaksi_state.freezed.dart';

// This is our single source of truth for the data. No duplication.
class TransaksiStateData {
  final List<GetTxModel> transactions;
  final GetTxModelDetail? transaction;
  final GetWalletModel? wallet;
  final int currentPage;
  final bool hasMoreData;

  TransaksiStateData({
    this.transactions = const [],
    this.wallet,
    this.transaction,
    this.currentPage = 1,
    this.hasMoreData = true,
  });

  // copyWith is essential for immutable state updates
  TransaksiStateData copyWith({
    List<GetTxModel>? transactions,
    GetWalletModel? wallet,
    int? currentPage,
    bool? hasMoreData,
  }) {
    return TransaksiStateData(
      transactions: transactions ?? this.transactions,
      wallet: wallet ?? this.wallet,
      currentPage: currentPage ?? this.currentPage,
      hasMoreData: hasMoreData ?? this.hasMoreData,
    );
  }
}

// Now, the union types represent STATUS, and they wrap the data.
@freezed
class TransaksiState with _$TransaksiState {
  const TransaksiState._(); // Private constructor for getters

  // Initial state before any loading
  const factory TransaksiState.initial({required TransaksiStateData data}) =
      _Initial;

  // State for the very first page load
  const factory TransaksiState.loading({required TransaksiStateData data}) =
      _Loading;

  // State for loading subsequent pages (for the bottom loading indicator)
  const factory TransaksiState.loadingMore({required TransaksiStateData data}) =
      _LoadingMore;

  // The primary success state
  const factory TransaksiState.loaded({required TransaksiStateData data}) =
      _Loaded;

  // Error state, which still preserves the last known data
  const factory TransaksiState.error({
    required TransaksiStateData data,
    required String message,
  }) = _Error;

  // You can add created/updated if needed, they'd also wrap the data.

  // A convenient getter to access the data regardless of the state.
  // This avoids repetitive `when` or `map` calls in the UI.
  TransaksiStateData get data => when(
        initial: (data) => data,
        loading: (data) => data,
        loadingMore: (data) => data,
        loaded: (data) => data,
        error: (data, _) => data,
      );
  // ADD THIS GETTER 👇
  bool get canLoadMore => maybeMap(
        // It's safe to load more only when we are in the 'loaded' state.
        loaded: (_) => true,
        // You could also allow it in the error state to let users retry by scrolling.
        error: (_) => true,
        // For all other states (loading, loadingMore, initial), it's false.
        orElse: () => false,
      );
  bool get hasError => maybeWhen(
        error: (_, __) => true,
        orElse: () => false,
      );

  String? get errorMessage => maybeWhen(
        error: ( _, message) => message,
        orElse: () => null,
      );
}
