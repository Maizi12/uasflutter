import 'package:digit/data/models/response_go.dart';

class DashboardState {
  final List<GetTxModel> transactions;
  final List<GetWalletModel> wallets;
  final GetWalletModel? selectedWallet;
  final GetBerandaModel? beranda;
  final bool isLoading;
  final String? error;
  final bool hasMoreTransactions;
  final int currentPage;

  const DashboardState({
    this.transactions = const [],
    this.wallets = const [],
    this.selectedWallet,
    this.beranda,
    this.isLoading = true,
    this.error,
    this.hasMoreTransactions = true,
    this.currentPage = 1,
  });

  DashboardState copyWith({
    List<GetTxModel>? transactions,
    List<GetWalletModel>? wallets,
    GetWalletModel? selectedWallet,
    GetBerandaModel? beranda,
    bool? isLoading,
    String? error,
    bool? hasMoreTransactions,
    int? currentPage,
  }) {
    return DashboardState(
      transactions: transactions ?? this.transactions,
      wallets: wallets ?? this.wallets,
      selectedWallet: selectedWallet ?? this.selectedWallet,
      beranda: beranda ?? this.beranda,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      hasMoreTransactions: hasMoreTransactions ?? this.hasMoreTransactions,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
