import 'package:digit/data/models/response_go.dart';

abstract class TransaksiState {
  const TransaksiState();
}

class TransaksiInitial extends TransaksiState {
  const TransaksiInitial();
}

class TransaksiLoading extends TransaksiState {
  const TransaksiLoading();
}

class TransaksiFailed extends TransaksiState {
  final String message;
  const TransaksiFailed(this.message);
}

class TransaksiData extends TransaksiState {
  final GetWalletModel selectedWallet;
  const TransaksiData({required this.selectedWallet});
}

class TransaksiList extends TransaksiState {
  final List<GetWalletModel> listselectedWallet;
  const TransaksiList({required this.listselectedWallet});
}

class TransaksiWalletLoaded extends TransaksiState {
  final List<GetWalletModel> wallets;
  const TransaksiWalletLoaded({required this.wallets});
}

class TransaksiLoaded extends TransaksiState {
  final List<GetWalletModel> wallets;
  final List<GetTxModel> transactions;
  final GetWalletModel selectedWallet;
  final GetBerandaModel? berandaData;
  // ... other data fields

  TransaksiLoaded({
    this.wallets = const [],
    GetWalletModel? selectedWallet,
    this.transactions = const [],
    this.berandaData,
  }) : selectedWallet = selectedWallet ?? GetWalletModel.createWallet();

  // copyWith allows for easy updates without re-fetching everything
  TransaksiLoaded copyWith({
    List<GetWalletModel>? wallets,
    List<GetTxModel>? transactions,
    GetWalletModel? selectedWallet,
    GetBerandaModel? berandaData,
  }) {
    return TransaksiLoaded(
      wallets: wallets ?? this.wallets,
      transactions: transactions ?? this.transactions,
      berandaData: berandaData ?? this.berandaData,
      selectedWallet: selectedWallet ?? this.selectedWallet,
    );
  }
}

class TransaksiJenisTransaksiLoaded extends TransaksiState {
  final List<GetJenisCoaModel> jenisTransaksi;
  const TransaksiJenisTransaksiLoaded({required this.jenisTransaksi});
}

class TransaksiBerandaLoaded extends TransaksiState {
  final GetBerandaModel beranda;
  const TransaksiBerandaLoaded({required this.beranda});
}

class TransaksiTransactionsLoaded extends TransaksiState {
  final List<GetTxModel> transactions;
  const TransaksiTransactionsLoaded({required this.transactions});
}

class TransaksiTransactionLoaded extends TransaksiState {
  final GetTxModelDetail transaction;
  const TransaksiTransactionLoaded({required this.transaction});
}

class TransaksiTransactionCreated extends TransaksiState {
  final dynamic response;
  const TransaksiTransactionCreated({required this.response});
}

class TransaksiTransactionUpdated extends TransaksiState {
  final dynamic response;
  const TransaksiTransactionUpdated({required this.response});
}
