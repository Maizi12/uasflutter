import 'package:digit/core/utils/constant/appconstants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digit/domain/repository/transaksi_repository.dart';
import 'package:digit/data/models/response_go.dart';
import 'transaksi_state.dart';

class TransaksiCubit extends Cubit<TransaksiState> {
  final TransaksiRepository transaksiRepository;

  TransaksiCubit(this.transaksiRepository) : super(const TransaksiInitial());

  void selectWallet(GetWalletModel wallet) {
    emit(TransaksiData(selectedWallet: wallet));
  }

  void listWallet(
      List<GetWalletModel> walletss, GetWalletModel selectedWallet) {
    emit(TransaksiLoaded(wallets: walletss, selectedWallet: selectedWallet));
    // emit(TransaksiList(listselectedWallet: wallet));
  }

  Future<void> getWallet(int idJenisCoa) async {
    emit(const TransaksiLoading());

    final result = await transaksiRepository.getWallet(idJenisCoa);

    result.fold(
      (failure) {
        emit(TransaksiFailed(failure.message ?? 'Failed to get wallet'));
      },
      (wallets) {
        emit(TransaksiLoaded(wallets: wallets, selectedWallet: wallets.last));
        // emit(TransaksiWalletLoaded(wallets: wallets));
      },
    );
  }

// Add these methods to your TransaksiCubit:
  void refreshAll() {
    getWallet(AppConstants.IdJenisWallet);
    // Refresh wallets, transactions, and beranda
  }

  void loadMoreTransactions() {
    // Load next page of transactions
  }

  void refreshTransactions() {
    // Refresh current wallet's transactions
  }
  Future<void> getJenisTransaksi() async {
    emit(const TransaksiLoading());

    final result = await transaksiRepository.getJenisTransaksi();

    result.fold(
      (failure) {
        emit(TransaksiFailed(
            failure.message ?? 'Failed to get jenis transaksi'));
      },
      (jenisTransaksi) {
        emit(TransaksiJenisTransaksiLoaded(jenisTransaksi: jenisTransaksi));
      },
    );
  }

  Future<void> getBeranda({int? idWallet, int? idCoaDebit}) async {
    emit(const TransaksiLoading());

    final result = await transaksiRepository.getBeranda(
        idWallet: idWallet, idCoaDebit: idCoaDebit);

    result.fold(
      (failure) {
        emit(TransaksiFailed(failure.message ?? 'Failed to get beranda'));
      },
      (beranda) {
        emit(TransaksiLoaded(berandaData: beranda));

        // emit(TransaksiBerandaLoaded(beranda: beranda));
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
    emit(const TransaksiLoading());

    final result = await transaksiRepository.getRecentTx(
      page: page,
      pageSize: pageSize,
      id: id,
      idCoaDebit: idCoaDebit,
      idCoaKredit: idCoaKredit,
      sort: sort,
      idJenisTransaksi: idJenisTransaksi,
      idWallet: idWallet,
      tglAwal: tglAwal,
      tglAkhir: tglAkhir,
    );

    result.fold(
      (failure) {
        emit(TransaksiFailed(
            failure.message ?? 'Failed to get recent transactions'));
      },
      (transactions) {
        emit(TransaksiLoaded(transactions: transactions));
        // emit(TransaksiTransactionsLoaded(transactions: transactions));
      },
    );
  }

  Future<void> getTxOne({dynamic id}) async {
    emit(const TransaksiLoading());

    final result = await transaksiRepository.getTxOne(id: id);

    result.fold(
      (failure) {
        emit(TransaksiFailed(failure.message ?? 'Failed to get transaction'));
      },
      (transaction) {
        emit(TransaksiTransactionLoaded(transaction: transaction));
      },
    );
  }

  Future<void> createTransaksi(List<dynamic> transaksi) async {
    emit(const TransaksiLoading());

    final result = await transaksiRepository.createTransaksi(transaksi);

    result.fold(
      (failure) {
        emit(
            TransaksiFailed(failure.message ?? 'Failed to create transaction'));
      },
      (response) {
        emit(TransaksiTransactionCreated(response: response));
      },
    );
  }

  Future<void> updateTransaksi(dynamic transaksi) async {
    emit(const TransaksiLoading());

    final result = await transaksiRepository.updateTransaksi(transaksi);

    result.fold(
      (failure) {
        emit(
            TransaksiFailed(failure.message ?? 'Failed to update transaction'));
      },
      (response) {
        emit(TransaksiTransactionUpdated(response: response));
      },
    );
  }
}
