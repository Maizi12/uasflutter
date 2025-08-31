import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digit/domain/repository/transaksi_repository.dart';
import 'package:digit/data/models/response_go.dart';
import 'package:digit/core/utils/constant/appconstants.dart';
import 'dashboard_state.dart';
class DashboardCubit extends Cubit<DashboardState> {
  final TransaksiRepository _repository;
  static const int _pageSize = 10;

  DashboardCubit(this._repository) : super(const DashboardState.initial());

  // Initialize dashboard data
  Future<void> initialize() async {
    await _loadWallets();
  }

  // Load wallets and select first one
  Future<void> _loadWallets() async {
    emit(DashboardState.loading(
      wallets: state.wallets,
      selectedWallet: state.selectedWallet,
      transactions: state.transactions,
      beranda: state.beranda,
    ));

    final result = await _repository.getWallet(AppConstants.IdJenisWallet);
    
    result.fold(
      (failure) => emit(DashboardState.error(
        message: failure.message ?? 'Failed to load wallets',
        wallets: state.wallets,
        selectedWallet: state.selectedWallet,
        transactions: state.transactions,
        beranda: state.beranda,
      )),
      (wallets) async {
        if (wallets.isEmpty) {
          emit(DashboardState.error(
            message: 'No wallets found',
            wallets: wallets,
          ));
          return;
        }

        final selectedWallet = wallets.first;
        emit(DashboardState.loaded(
          wallets: wallets,
          selectedWallet: selectedWallet,
        ));

        // Load initial data for selected wallet
        await _loadWalletData(selectedWallet);
      },
    );
  }

  // Select a different wallet
  Future<void> selectWallet(GetWalletModel wallet) async {
    final currentState = state;
    
    // Update selected wallet immediately
    currentState.maybeWhen(
      loaded: (wallets, _, transactions, beranda, currentPage, hasMore, isLoadingMore) {
        emit(DashboardState.loaded(
          wallets: wallets,
          selectedWallet: wallet,
          transactions: [], // Clear transactions when switching
          currentPage: 1,
          hasMoreTransactions: true,
        ));
      },
      orElse: () {
        emit(DashboardState.loaded(
          wallets: state.wallets,
          selectedWallet: wallet,
          transactions: [],
          currentPage: 1,
          hasMoreTransactions: true,
        ));
      },
    );

    // Load data for new wallet
    await _loadWalletData(wallet);
  }

  // Load all data for a specific wallet
  Future<void> _loadWalletData(GetWalletModel wallet) async {
    await Future.wait([
      _loadTransactions(wallet.idWallet, reset: true),
      _loadBeranda(wallet.idWallet),
    ]);
  }

  // Load transactions for a wallet
  Future<void> _loadTransactions(int walletId, {bool reset = false}) async {
    final currentState = state;
    int page = 1;
    List<GetTxModel> currentTransactions = [];

    currentState.maybeWhen(
      loaded: (wallets, selectedWallet, transactions, beranda, currentPage, hasMore, isLoadingMore) {
        if (!reset) {
          page = currentPage + 1;
          currentTransactions = transactions;
        }
      },
      orElse: () {},
    );

    // Show loading state
    if (reset) {
      state.maybeWhen(
        loaded: (wallets, selectedWallet, _, beranda, __, ___, ____) {
          emit(DashboardState.loading(
            wallets: wallets,
            selectedWallet: selectedWallet,
            beranda: beranda,
          ));
        },
        orElse: () {},
      );
    } else {
      // Show loading more indicator
      state.maybeWhen(
        loaded: (wallets, selectedWallet, transactions, beranda, currentPage, hasMore, _) {
          emit(DashboardState.loaded(
            wallets: wallets,
            selectedWallet: selectedWallet,
            transactions: transactions,
            beranda: beranda,
            currentPage: currentPage,
            hasMoreTransactions: hasMore,
            isLoadingMore: true,
          ));
        },
        orElse: () {},
      );
    }

    final result = await _repository.getRecentTx(
      idWallet: walletId,
      page: page.toString(),
      pageSize: _pageSize.toString(),
    );

    result.fold(
      (failure) {
        emit(DashboardState.error(
          message: failure.message ?? 'Failed to load transactions',
          wallets: state.wallets,
          selectedWallet: state.selectedWallet,
          transactions: currentTransactions,
          beranda: state.beranda,
          currentPage: page - 1,
          hasMoreTransactions: state.hasMoreTransactions,
        ));
      },
      (newTransactions) {
        final allTransactions = reset 
          ? newTransactions 
          : [...currentTransactions, ...newTransactions];
        
        final hasMore = newTransactions.length >= _pageSize;

        emit(DashboardState.loaded(
          wallets: state.wallets,
          selectedWallet: state.selectedWallet!,
          transactions: allTransactions,
          beranda: state.beranda,
          currentPage: page,
          hasMoreTransactions: hasMore,
        ));
      },
    );
  }

  // Load beranda data
  Future<void> _loadBeranda(int walletId) async {
    final result = await _repository.getBeranda(idWallet: walletId);
    
    result.fold(
      (failure) {
        // Don't emit error for beranda failure, just continue without it
        print('Failed to load beranda: ${failure.message}');
      },
      (beranda) {
        state.maybeWhen(
          loaded: (wallets, selectedWallet, transactions, _, currentPage, hasMore, isLoadingMore) {
            emit(DashboardState.loaded(
              wallets: wallets,
              selectedWallet: selectedWallet,
              transactions: transactions,
              beranda: beranda,
              currentPage: currentPage,
              hasMoreTransactions: hasMore,
              isLoadingMore: isLoadingMore,
            ));
          },
          orElse: () {},
        );
      },
    );
  }

  // Load more transactions (pagination)
  Future<void> loadMoreTransactions() async {
    final wallet = state.selectedWallet;
    if (wallet == null || !state.hasMoreTransactions || state.isLoading) {
      return;
    }

    await _loadTransactions(wallet.idWallet, reset: false);
  }

  // Refresh all data
  Future<void> refreshAll() async {
    await _loadWallets();
  }

  // Refresh transactions only
  Future<void> refreshTransactions() async {
    final wallet = state.selectedWallet;
    if (wallet == null) return;

    await _loadTransactions(wallet.idWallet, reset: true);
  }

  // Refresh beranda only
  Future<void> refreshBeranda() async {
    final wallet = state.selectedWallet;
    if (wallet == null) return;

    await _loadBeranda(wallet.idWallet);
  }
}
