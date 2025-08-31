// lib/presentation/widgets/dashboard/transactions_list.dart
import 'package:digit/core/utils/constant/appconstants.dart';
import 'package:digit/data/models/response_go.dart';
import 'package:digit/presentation/widgets/list_transaksi_card.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatefulWidget {
  final List<GetTxModel> transactions;
  final bool isLoading;
  final bool hasMore;
  final VoidCallback onLoadMore;

  const TransactionsList({
    super.key,
    required this.transactions,
    required this.isLoading,
    required this.hasMore,
    required this.onLoadMore,
  });

  @override
  State<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (widget.hasMore && !widget.isLoading) {
        widget.onLoadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
      child: widget.transactions.isEmpty
          ? const _EmptyTransactions()
          : ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.all(AppDimensions.cardPadding),
              itemCount: widget.transactions.length + (widget.hasMore ? 1 : 0),
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                if (index >= widget.transactions.length) {
                  return const _LoadingItem();
                }

                final transaction = widget.transactions[index];
                return ListTransaksiCard(
                  transaction.KeteranganTransaksi,
                  transaction.nominal,
                  transaction.sisaSaldo,
                  transaction.TanggalTransaksi,
                  transaction.DebitKredit,
                  transaction.idTransaksi,
                );
              },
            ),
    );
  }
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
