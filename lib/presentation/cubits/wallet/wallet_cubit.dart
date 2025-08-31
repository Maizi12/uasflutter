// lib/presentation/cubits/Wallet/Wallet_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digit/domain/repository/transaksi_repository.dart';
import 'package:digit/data/models/response_go.dart';
import 'package:digit/core/utils/constant/appconstants.dart';
import 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  final TransaksiRepository _repository;
  static const int _pageSize = 10;

  WalletCubit(this._repository) : super(const WalletState.initial());

  // Initialize Wallet data
  Future<void> initialize() async {
    await _loadWallets();
  }

  // Load wallets and select first one
  Future<void> _loadWallets() async {
    emit(WalletState.loading(
      wallets: state.wallets,
      selectedWallet: state.selectedWallet,
    ));

    final result = await _repository.getWallet(AppConstants.IdJenisWallet);

    result.fold(
      (failure) => emit(WalletState.error(
        message: failure.message ?? 'Failed to load wallets',
        wallets: state.wallets,
        selectedWallet: state.selectedWallet,
      )),
      (wallets) async {
        if (wallets.isEmpty) {
          emit(WalletState.error(
            message: 'No wallets found',
            wallets: wallets,
          ));
          return;
        }

        final selectedWallet = wallets.first;
        emit(WalletState.loaded(
          wallets: wallets,
          selectedWallet: selectedWallet,
        ));
      },
    );
  }

  // Select a different wallet
  Future<void> selectWallet(GetWalletModel wallet) async {
    final currentState = state;

    // Update selected wallet immediately
    currentState.maybeWhen(
      loaded: (wallets, _, currentPage, hasMore, isLoadingMore) {
        emit(WalletState.loaded(
          wallets: wallets,
          selectedWallet: wallet,
          currentPage: 1,
        ));
      },
      orElse: () {
        emit(WalletState.loaded(
          wallets: state.wallets,
          selectedWallet: wallet,
          currentPage: 1,
        ));
      },
    );
  }

  // Refresh all data
  Future<void> refreshAll() async {
    await _loadWallets();
  }
}
