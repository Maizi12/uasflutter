// lib/presentation/widgets/dashboard/transactions_list.dart
import 'package:digit/core/utils/constant/appconstants.dart';
import 'package:digit/data/models/response_go.dart';
import 'package:digit/presentation/cubits/transaksi/transaksi_cubit.dart';
import 'package:digit/presentation/cubits/transaksi/transaksi_state.dart';
import 'package:digit/presentation/widgets/list_transaksi_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsList extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final List<GetTxModel> transactions = List<GetTxModel>.empty(growable: true);
  final bool isLoading = false;
  final bool hasMore = false;
  final int currentPage = 1;
  bool _canScroll = false;
  void _onScroll(BuildContext context) {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (hasMore && !isLoading) {
        currentPage + 1;
        context
            .read<TransaksiCubit>()
            .loadMoreTransactions(currentPage.toString());
      } else {
        _canScroll = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() => _onScroll(context));
    return BlocConsumer<TransaksiCubit, TransaksiState>(
        listener: (context, state) {
      // Show error snackbars
      if (state.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.errorMessage ?? 'An error occurred'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }, builder: (context, state) {
      return _buildContent(state, _scrollController, _canScroll);
    });
  }
}

Widget _buildContent(
    TransaksiState state, ScrollController _scrollController, bool _canScroll) {
  return CustomScrollView(
    slivers: [
      SliverToBoxAdapter(
        child: Container(
          height: 200,
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
          child: state.transactions.isEmpty
              ? const _EmptyTransactions()
              : ListView.separated(
                  physics: _canScroll
                      ? AlwaysScrollableScrollPhysics()
                      : NeverScrollableScrollPhysics(),
                  controller: _scrollController,
                  padding: const EdgeInsets.all(AppDimensions.cardPadding),
                  itemCount: state.transactions.length +
                      (state.hasMoreTransactions ? 1 : 0),
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    if (index >= state.transactions.length) {
                      return const _LoadingItem();
                    }

                    final transaction = state.transactions[index];
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
        ),
      ),
    ],
  );
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
