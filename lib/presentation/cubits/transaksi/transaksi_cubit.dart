import 'package:digit/core/utils/constant/appconstants.dart';
import 'package:digit/data/models/response_go.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digit/domain/repository/transaksi_repository.dart';
import 'transaksi_state.dart';

class TransaksiCubit extends Cubit<TransaksiState> {
  final TransaksiRepository transaksiRepository;

  TransaksiCubit(this.transaksiRepository)
      : super(TransaksiState.initial(data: TransaksiStateData()));

// Add these methods to your TransaksiCubit:
  Future<void> refreshAll() async {
    await getRecentTx(
        pageSize: AppConstants.pageSize, idWallet: AppConstants.IdJenisWallet);
    // Refresh wallets, transactions, and beranda
  }

  Future<void> initialize(int idWallet) async {
    // Initial load transactions
    emit(TransaksiState.loading(data: state.data));
    final result = await transaksiRepository.getRecentTx(
        idWallet: idWallet,
        idCoaDebit: idWallet,
        idCoaKredit: idWallet,
        page: 1);
    result.fold(
      (failure) {
        emit(TransaksiState.error(data: state.data, message: failure.message!));
      },
      (pagination) {
        // On success, create a new data object and wrap it in a 'loaded' state
        final newData = state.data.copyWith(
          transactions: pagination.data,
          currentPage: 1,
          hasMoreData: pagination.data.isNotEmpty,
        );
        emit(TransaksiState.loaded(data: newData));
      },
    );
  }

  Future<void> loadMoreTransactions(int idWallet) async {
    // Guard to prevent multiple loads
    if (!state.data.hasMoreData && state.canLoadMore) return;

    // Emit 'loadingMore' status. CRUCIALLY, the existing data is preserved.
    // This solves the "blank screen" problem.
    emit(TransaksiState.loadingMore(data: state.data));

    final nextPage = state.data.currentPage + 1;
    final result = await transaksiRepository.getRecentTx(
        idWallet: idWallet,
        idCoaDebit: idWallet,
        idCoaKredit: idWallet,
        page: nextPage);

    result.fold(
      (failure) {
        // On error, return to 'error' state, still preserving the list data
        emit(TransaksiState.error(data: state.data, message: failure.message!));
      },
      (pagination) {
        // SUCCESS: Append new data to the existing list.
        final updatedData = state.data.copyWith(
          transactions: List.from(state.data.transactions)
            ..addAll(pagination.data),
          currentPage: nextPage,
          hasMoreData: pagination.data.isNotEmpty,
        );
        emit(TransaksiState.loaded(data: updatedData));
      },
    );
  }

  void setSelectedWallet(GetWalletModel wallet) {
    TransaksiState.loading(data: TransaksiStateData(wallet: wallet));
  }

  void refreshTransactions() {
    // Refresh current wallet's transactions
  }
  Future<void> getJenisTransaksi() async {
    // emit(const TransaksiState.loading());

    // final result = await transaksiRepository.getJenisTransaksi();

    // result.fold(
    //   (failure) {
    //     emit(TransaksiState.error(
    //         message: failure.message ?? 'Failed to get jenis transaksi'));
    //   },
    //   (jenisTransaksi) {
    //     emit(TransaksiState.loaded());
    //   },
    // );
  }

  void updateSelectedWallet(GetWalletModel wallet) {
    emit(
      TransaksiState.loaded(
          data: TransaksiStateData(
              wallet: wallet)), // assuming your state has copyWith
    );
  }

  Future<void> getRecentTx({
    int? page,
    pageSize,
    id,
    idCoaDebit,
    idCoaKredit,
    sort,
    idJenisTransaksi,
    idWallet,
    tglAwal,
    tglAkhir,
  }) async {
    emit(TransaksiState.loading(data: TransaksiStateData()));

    final result = await transaksiRepository.getRecentTx(
      page: page,
      pageSize: pageSize,
      id: id,
      idCoaDebit: idWallet,
      idCoaKredit: idWallet,
      sort: sort,
      idJenisTransaksi: idJenisTransaksi,
      idWallet: idWallet,
      tglAwal: tglAwal,
      tglAkhir: tglAkhir,
    );
    result.fold(
      (failure) {
        emit(TransaksiState.error(
            message: failure.message ?? 'Failed to get recent transactions',
            data: TransaksiStateData()));
      },
      (transactions) {
        emit(TransaksiState.loaded(
            data: TransaksiStateData(transactions: transactions.data)));
        // emit(TransaksiTransactionsLoaded(transactions: transactions));
      },
    );
  }

  Future<void> getTxOne({dynamic id}) async {
    emit(TransaksiState.loading(data: TransaksiStateData()));

    final result = await transaksiRepository.getTxOne(id: id);

    result.fold(
      (failure) {
        emit(TransaksiState.error(
            message: failure.message ?? 'Failed to get transaction',
            data: TransaksiStateData()));
      },
      (transaction) {
        emit(TransaksiState.loaded(
            data: TransaksiStateData(transaction: transaction)));
      },
    );
  }

  Future<void> createTransaksi(List<dynamic> transaksi) async {
    emit(TransaksiState.loading(data: TransaksiStateData()));

    final result = await transaksiRepository.createTransaksi(transaksi);

    result.fold(
      (failure) {
        emit(TransaksiState.error(
            message: failure.message ?? 'Failed to create transaction',
            data: TransaksiStateData()));
      },
      (response) {
        emit(TransaksiState.loaded(data: TransaksiStateData()));
      },
    );
  }

  Future<void> updateTransaksi(dynamic transaksi) async {
    emit(TransaksiState.loading(data: TransaksiStateData()));

    final result = await transaksiRepository.updateTransaksi(transaksi);

    result.fold(
      (failure) {
        emit(TransaksiState.error(
            message: failure.message ?? 'Failed to update transaction',
            data: TransaksiStateData()));
      },
      (response) {
        emit(TransaksiState.loaded(data: TransaksiStateData()));
      },
    );
  }
}
