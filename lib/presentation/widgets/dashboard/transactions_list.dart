// lib/presentation/widgets/dashboard/transactions_list.dart
import 'package:digit/core/utils/constant/appconstants.dart';
import 'package:digit/data/models/response_go.dart';
import 'package:digit/presentation/cubits/transaksi/transaksi_cubit.dart';
import 'package:digit/presentation/cubits/transaksi/transaksi_state.dart';
import 'package:digit/presentation/widgets/list_transaksi_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsList extends StatefulWidget {
  final GetWalletModel wallet;
  TransactionsList(this.wallet, {super.key});

  @override
  State<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final state = context.read<TransaksiCubit>().state;
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    // The check is now much cleaner
    if (currentScroll >= maxScroll * 0.9 && state.canLoadMore) {
      context
          .read<TransaksiCubit>()
          .loadMoreTransactions(widget.wallet.idWallet);
    }
  }

  final ScrollController _scrollController = ScrollController();
  List<GetWalletModel> wallets = List<GetWalletModel>.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TransaksiCubit, TransaksiState>(
          listener: (context, state) {
            if (state.hasError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'An error occurred'),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
        ),
      ],
      child: BlocBuilder<TransaksiCubit, TransaksiState>(
        builder: (context, state) {
          return _buildContent(state, _scrollController);
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

Widget _buildContent(TransaksiState state, ScrollController _scrollController) {
  return Container(
      margin: const EdgeInsets.all(AppDimensions.defaultMargin),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            offset: Offset(0, 3),
            blurRadius: 3,
          ),
        ],
      ),
      child: state.data.transactions.isEmpty
          ? const _EmptyTransactions()
          : ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.all(AppDimensions.cardPadding),
              itemCount: state.data.transactions.length +
                  (state.data.hasMoreData ? 1 : 0),
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                if (index >= state.data.transactions.length) {
                  return const _LoadingItem();
                }

                final transaction = state.data.transactions[index];
                return ListTransaksiCard(
                  transaction.KeteranganTransaksi,
                  transaction.nominal,
                  transaction.sisaSaldo,
                  transaction.TanggalTransaksi,
                  transaction.DebitKredit,
                  transaction.idTransaksi,
                );
              },
            ));
}

class _EmptyTransactions extends StatelessWidget {
  const _EmptyTransactions();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 48,
              color: AppColors.textSecondary,
            ),
            SizedBox(height: 8),
            Text(
              "Belum ada transaksi",
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingItem extends StatelessWidget {
  const _LoadingItem();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: const Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}
