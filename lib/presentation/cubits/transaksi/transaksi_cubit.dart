import 'package:digit/core/utils/constant/appconstants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digit/domain/repository/transaksi_repository.dart';
import 'transaksi_state.dart';

class TransaksiCubit extends Cubit<TransaksiState> {
  final TransaksiRepository transaksiRepository;

  TransaksiCubit(this.transaksiRepository)
      : super(const TransaksiState.initial());

// Add these methods to your TransaksiCubit:
  Future<void> refreshAll() async {
    await getRecentTx(
        pageSize: AppConstants.pageSize, idWallet: AppConstants.IdJenisWallet);
    // Refresh wallets, transactions, and beranda
  }

  void initialize() {
    // Initial load transactions
    getRecentTx(
        pageSize: AppConstants.pageSize, idWallet: AppConstants.IdJenisWallet);
  }

  Future<void> loadMoreTransactions(String page) async {
    emit(const TransaksiState.loading());

    final result = await transaksiRepository.getRecentTx(
        pageSize: AppConstants.pageSize,
        idWallet: AppConstants.IdJenisWallet,
        page: page);

    result.fold(
      (failure) {
        emit(TransaksiState.error(
            message: failure.message ?? 'Failed to get jenis transaksi'));
      },
      (res) {
        emit(TransaksiState.loaded(transactions: res));
      },
    );
    // Load next page of transactions
  }

  void refreshTransactions() {
    // Refresh current wallet's transactions
  }
  Future<void> getJenisTransaksi() async {
    emit(const TransaksiState.loading());

    final result = await transaksiRepository.getJenisTransaksi();

    result.fold(
      (failure) {
        emit(TransaksiState.error(
            message: failure.message ?? 'Failed to get jenis transaksi'));
      },
      (jenisTransaksi) {
        emit(TransaksiState.loaded());
      },
    );
  }

  Future<void> getRecentTx({
    String? page,
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
    emit(const TransaksiState.loading());

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
    var lengt = state.transactions.length;
    result.fold(
      (failure) {
        emit(TransaksiState.error(
            message: failure.message ?? 'Failed to get recent transactions'));
      },
      (transactions) {
        transactions.length = lengt + transactions.length;
        emit(TransaksiState.loaded(transactions: transactions));
        // emit(TransaksiTransactionsLoaded(transactions: transactions));
      },
    );
  }

  Future<void> getTxOne({dynamic id}) async {
    emit(const TransaksiState.loading());

    final result = await transaksiRepository.getTxOne(id: id);

    result.fold(
      (failure) {
        emit(TransaksiState.error(
            message: failure.message ?? 'Failed to get transaction'));
      },
      (transaction) {
        emit(TransaksiState.loaded(transaction: transaction));
      },
    );
  }

  Future<void> createTransaksi(List<dynamic> transaksi) async {
    emit(const TransaksiState.loading());

    final result = await transaksiRepository.createTransaksi(transaksi);

    result.fold(
      (failure) {
        emit(TransaksiState.error(
            message: failure.message ?? 'Failed to create transaction'));
      },
      (response) {
        emit(TransaksiState.created(message: response));
      },
    );
  }

  Future<void> updateTransaksi(dynamic transaksi) async {
    emit(const TransaksiState.loading());

    final result = await transaksiRepository.updateTransaksi(transaksi);

    result.fold(
      (failure) {
        emit(TransaksiState.error(
            message: failure.message ?? 'Failed to update transaction'));
      },
      (response) {
        emit(TransaksiState.updated(message: response));
      },
    );
  }
}
