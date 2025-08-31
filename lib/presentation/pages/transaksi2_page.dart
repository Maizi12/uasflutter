import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:digit/presentation/cubits/transaksi/transaksi_cubit.dart';
import 'package:digit/presentation/cubits/transaksi/transaksi_state.dart';
import 'package:digit/presentation/widgets/chart_transaksi.dart';
import 'package:digit/presentation/widgets/dropdown_wallet.dart';
import 'package:digit/presentation/widgets/list_transaksi_card.dart';
import 'package:digit/presentation/widgets/footer_card.dart';
import 'package:digit/data/models/response_go.dart';
import 'package:digit/domain/helper/currency_format.dart';
import 'package:go_router/go_router.dart';

// constants/app_constants.dart
class AppDimensions {
  static const double defaultMargin = 16.0;
  static const double cardRadius = 8.0;
  static const double cardPadding = 12.0;
  static const double iconSize = 16.0;
  static const double logoSize = 30.0;
}

class AppColors {
  static const Color background = Color(0xffF5F7FF);
  static const Color cardBackground = Color(0xffffffff);
  static const Color primary = Color(0xff2C14DD);
  static const Color primaryButton = Color.fromARGB(255, 30, 0, 255);
  static const Color textPrimary = Color(0xff161719);
  static const Color textSecondary = Color(0xff5C616F);
  static const Color shadow = Color.fromARGB(5, 17, 20, 177);
}

// models/dashboard_state.dart
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

// widgets/dashboard_header.dart
class DashboardHeader extends StatelessWidget {
  final List<GetWalletModel> wallets;
  final GetWalletModel? selectedWallet;
  final VoidCallback onWalletChanged;

  const DashboardHeader({
    super.key,
    required this.wallets,
    required this.selectedWallet,
    required this.onWalletChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/Logo.svg',
                height: AppDimensions.logoSize,
                width: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownWalletApp(
                  ListCoa: wallets,
                  selectedcoa: selectedWallet ?? GetWalletModel.empty(),
                  selectCoa: (wallet) {
                    context.read<TransaksiCubit>().selectWallet(wallet);
                    onWalletChanged();
                  },
                  onupdate: onWalletChanged,
                  icon: SvgPicture.asset(
                    'assets/caret-arrow-up.svg',
                    height: AppDimensions.iconSize,
                    width: AppDimensions.iconSize,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Keuangan Kamu Terlihat Sehat",
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// widgets/balance_card.dart
class BalanceCard extends StatefulWidget {
  final GetWalletModel? selectedWallet;

  const BalanceCard({
    super.key,
    required this.selectedWallet,
  });

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  bool _isBalanceVisible = false;

  @override
  Widget build(BuildContext context) {
    final wallet = widget.selectedWallet;
    if (wallet == null) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.all(AppDimensions.defaultMargin),
      padding: const EdgeInsets.all(AppDimensions.defaultMargin),
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Dari",
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/Logo.svg',
                    height: AppDimensions.logoSize,
                    width: AppDimensions.logoSize,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    wallet.NamaWallet,
                    style: const TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Total Saldo",
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _isBalanceVisible
                          ? CurrencyFormat.convertToIdr(wallet.TotalSaldo, 2)
                          : "••••••••",
                      style: const TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isBalanceVisible = !_isBalanceVisible;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: SvgPicture.asset(
                    _isBalanceVisible ? 'assets/eye.svg' : 'assets/eye.svg',
                    height: AppDimensions.iconSize,
                    width: AppDimensions.iconSize,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// widgets/section_header.dart
class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onActionTap;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionText,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.symmetric(horizontal: AppDimensions.defaultMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          if (actionText != null && onActionTap != null)
            GestureDetector(
              onTap: onActionTap,
              child: Row(
                children: [
                  Text(
                    actionText!,
                    style: const TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  SvgPicture.asset(
                    "assets/arrow_forward.svg",
                    width: AppDimensions.iconSize,
                    height: AppDimensions.iconSize,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// widgets/transactions_list.dart
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

// main dashboard page
class Transaksi2Page extends StatefulWidget {
  static const routeName = '/transaksi';
  const Transaksi2Page({super.key});

  @override
  State<Transaksi2Page> createState() => _Transaksi2PageState();
}

class _Transaksi2PageState extends State<Transaksi2Page> {
  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() {
    context.read<TransaksiCubit>().getWallet(1);
  }

  void _onWalletChanged() {
    context.read<TransaksiCubit>().refreshTransactions();
    context.read<TransaksiCubit>().getBeranda();
  }

  void _onLoadMoreTransactions() {
    context.read<TransaksiCubit>().loadMoreTransactions();
  }

  void _navigateToAllTransactions() {
    // Navigate to all transactions page
    context.push('/transactions');
  }

  void _navigateToCreateTransaction() {
    // Navigate to create transaction page
    context.push('/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransaksiCubit, TransaksiState>(
      listener: (context, state) {
        if (state is TransaksiFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: RefreshIndicator(
            onRefresh: () async {
              context.read<TransaksiCubit>().refreshAll();
            },
            child: CustomScrollView(
              slivers: [
                // Header
                SliverToBoxAdapter(
                  child: DashboardHeader(
                    wallets:
                        state is TransaksiLoaded ? state.wallets : List.empty(),
                    selectedWallet: state is TransaksiData
                        ? state.selectedWallet
                        : GetWalletModel.empty(),
                    onWalletChanged: _onWalletChanged,
                  ),
                ),

                // Balance Card
                SliverToBoxAdapter(
                  child: BalanceCard(
                    selectedWallet:
                        state is TransaksiData ? state.selectedWallet : null,
                  ),
                ),

                // Expense Report Section
                const SliverToBoxAdapter(
                  child: SizedBox(height: 4),
                ),
                const SliverToBoxAdapter(
                  child: SectionHeader(title: "Laporan Pengeluaran"),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 304,
                    margin: const EdgeInsets.all(AppDimensions.cardPadding),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.cardRadius),
                      color: AppColors.cardBackground,
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.shadow,
                          offset: Offset(0, 3),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child: ChartTransaksiApp(
                      idWallet: state is TransaksiData
                          ? state.selectedWallet.idWallet
                          : 0,
                    ),
                  ),
                ),

                // Transactions Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: SectionHeader(
                      title: "Transaksi Terbaru",
                      actionText: "Lihat Semua",
                      onActionTap: _navigateToAllTransactions,
                    ),
                  ),
                ),

                // Transactions List
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: TransactionsList(
                    transactions:
                        state is TransaksiLoaded ? state.transactions : [],
                    isLoading: state is TransaksiLoading,
                    hasMore: state is TransaksiLoaded ? true : false,
                    onLoadMore: _onLoadMoreTransactions,
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.primaryButton,
            onPressed: _navigateToCreateTransaction,
            child: SvgPicture.asset("assets/plus-white.svg"),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: SizedBox(
              height: 60,
              child: FooterCard(namaMenu: "Overview"),
            ),
          ),
        );
      },
    );
  }
}

// class Transaksi2Page extends StatefulWidget {
//   static const routeName = '/transaksi';
//   const Transaksi2Page({super.key});

//   @override
//   State<Transaksi2Page> createState() => Transaksi2PageState();
// }

// class Transaksi2PageState extends State<Transaksi2Page> {
//   final _scrollController = ScrollController();
//   int _currentPage = 1;

//   void _loadMore() {
//     if (_scrollController.position.pixels ==
//         _scrollController.position.maxScrollExtent) {
//       setState(() {
//         _currentPage++;
//       });
//     }
//   }

//   List<GetTxModel> transactions = [GetTxModel.empty()];
//   int isHarian = 0;
//   int isMingguan = 0;
//   int isBulanan = 1;
//   int isVisible = 1;
//   String textsaldo = "";
//   List<GetWalletModel> listWallet = [GetWalletModel.empty()];
//   GetWalletModel selectedlistWallet = GetWalletModel.empty();
//   GetBerandaModel getberanda = GetBerandaModel.empty();

//   bool _isLoading = true;
//   String? error;
//   bool _isFirstLoad = true;

//   @override
//   void initState() {
//     super.initState();
//     LoadWallet();
//     if (_isFirstLoad && !_isLoading) {
//       isBulanan = 1;
//       _isFirstLoad = false;
//     }
//     _scrollController.addListener(_loadMore);
//   }

//   void RecentTx() async {
//     await context.read<TransaksiCubit>().getRecentTx(
//           idWallet: selectedlistWallet.idWallet,
//           page: _currentPage.toString(),
//         );
//   }

//   void LoadWallet() async {
//     context
//         .read<TransaksiCubit>()
//         .getWallet(1); // Assuming 1 is the wallet jenis coa
//   }

//   void GetBeranda() async {
//     context
//         .read<TransaksiCubit>()
//         .getBeranda(idWallet: selectedlistWallet.idWallet);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<TransaksiCubit, TransaksiState>(
//       listener: (context, state) {
//         if (state is TransaksiFailed) {
//           setState(() {
//             error = state.message;
//           });
//         } else if (state is TransaksiWalletLoaded) {
//           setState(() {
//             listWallet.clear();
//             listWallet.addAll(state.wallets);
//             if (listWallet.isNotEmpty) {
//               selectedlistWallet = listWallet.first;
//             }
//           });
//           RecentTx();
//         } else if (state is TransaksiBerandaLoaded) {
//           setState(() {
//             getberanda = state.beranda;
//           });
//         } else if (state is TransaksiTransactionsLoaded) {
//           setState(() {
//             transactions = state.transactions;
//           });
//         }
//       },
//       child: Scaffold(
//         body: Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           decoration: const BoxDecoration(
//             color: Color(0xffF5F7FF),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 30),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height * 0.07,
//                 margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
//                 child: Column(children: [
//                   Container(
//                     width: MediaQuery.of(context).size.width,
//                     height: 20,
//                     margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
//                     child: Row(
//                       children: [
//                         Container(
//                           margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//                           width: 30,
//                           height: 20,
//                           child: SvgPicture.asset(
//                             'assets/Logo.svg',
//                             height: 30,
//                             width: 20,
//                           ),
//                         ),
//                         Container(
//                           margin: const EdgeInsets.fromLTRB(8, 0, 0, 0),
//                           width: 130,
//                           height: 20,
//                           child: DropdownWalletApp(
//                             ListCoa: listWallet,
//                             selectedcoa: selectedlistWallet,
//                             selectCoa: (GetWalletModel select) {
//                               context
//                                   .read<TransaksiCubit>()
//                                   .selectWallet(select);
//                               selectedlistWallet = select;
//                               if (isVisible == 1) {
//                                 textsaldo = "";
//                               } else {
//                                 textsaldo = CurrencyFormat.convertToIdr(
//                                     selectedlistWallet.TotalSaldo, 2);
//                               }
//                               _isLoading = false;
//                             },
//                             onupdate: () {
//                               RecentTx();
//                               GetBeranda();
//                             },
//                             icon: Container(
//                               margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//                               child: SvgPicture.asset(
//                                 'assets/caret-arrow-up.svg',
//                                 height: 16,
//                                 width: 16,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
//                     height: 26,
//                     alignment: Alignment.centerLeft,
//                     child: const Text(
//                       "Keuangan Kamu Terlihat Sehat",
//                       textAlign: TextAlign.left,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                         fontFamily: 'Plus Jakarta Sans',
//                         fontSize: 12,
//                         fontWeight: FontWeight.w400,
//                         height: 1.26,
//                         color: Color(0xff5C616F),
//                       ),
//                     ),
//                   ),
//                 ]),
//               ),
//               Container(
//                 margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
//                 width: 343,
//                 height: 103,
//                 decoration: BoxDecoration(
//                   color: const Color(0xffffffff),
//                   shape: BoxShape.rectangle,
//                   borderRadius: BorderRadius.circular(8),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Color.fromARGB(5, 17, 20, 177),
//                       offset: Offset(0, 3),
//                       blurRadius: 3,
//                     ),
//                   ],
//                 ),
//                 child: Column(children: [
//                   Container(
//                     width: 343,
//                     height: 14,
//                     margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 20,
//                           margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//                           child: const Text(
//                             "Dari",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontFamily: 'Plus Jakarta Sans',
//                               fontSize: 10,
//                               fontWeight: FontWeight.w600,
//                               color: Color(0xff131313),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 160),
//                         Container(
//                           margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//                           width: 30,
//                           height: 30,
//                           child: SvgPicture.asset(
//                             'assets/Logo.svg',
//                             height: 30,
//                             width: 30,
//                           ),
//                         ),
//                         Container(
//                           width: 80,
//                           margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//                           child: Text(
//                             selectedlistWallet.NamaWallet,
//                             textAlign: TextAlign.center,
//                             style: const TextStyle(
//                               fontFamily: 'Plus Jakarta Sans',
//                               fontSize: 10,
//                               fontWeight: FontWeight.w600,
//                               color: Color(0xff131313),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     width: 400,
//                     height: 49,
//                     alignment: Alignment.centerLeft,
//                     margin: const EdgeInsets.fromLTRB(16, 12, 50, 16),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               width: 258,
//                               height: 13,
//                               margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
//                               child: const Text(
//                                 "Total Saldo",
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                   fontFamily: 'Plus Jakarta Sans',
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.w500,
//                                   color: Color(0xff5C616F),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 258,
//                               height: 28,
//                               child: Row(children: [
//                                 Container(
//                                   width: 200,
//                                   height: 28,
//                                   margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
//                                   child: Text(
//                                     textsaldo,
//                                     textAlign: TextAlign.left,
//                                     style: const TextStyle(
//                                       fontFamily: 'Plus Jakarta Sans',
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.w800,
//                                       color: Color(0xff161719),
//                                     ),
//                                   ),
//                                 ),
//                                 GestureDetector(
//                                   behavior: HitTestBehavior.opaque,
//                                   onTap: () {
//                                     setState(() {
//                                       if (isVisible == 1) {
//                                         isVisible = 0;
//                                         textsaldo = CurrencyFormat.convertToIdr(
//                                             selectedlistWallet.TotalSaldo, 2);
//                                       } else {
//                                         isVisible = 1;
//                                         textsaldo = "";
//                                       }
//                                     });
//                                   },
//                                   child: SizedBox(
//                                     width: 24,
//                                     height: 16,
//                                     child: SvgPicture.asset(
//                                       'assets/eye.svg',
//                                       height: 16,
//                                       width: 16,
//                                     ),
//                                   ),
//                                 )
//                               ]),
//                             )
//                           ],
//                         )
//                       ],
//                     ),
//                   )
//                 ]),
//               ),
//               const SizedBox(height: 4),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: 20,
//                 margin: const EdgeInsets.fromLTRB(8, 0, 0, 0),
//                 child: const Row(
//                   children: [
//                     SizedBox(width: 16),
//                     Text(
//                       "Laporan Pengeluaran",
//                       textAlign: TextAlign.left,
//                       style: TextStyle(
//                         fontFamily: 'Plus Jakarta Sans',
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xff161719),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 width: 343,
//                 height: 304,
//                 margin: const EdgeInsets.fromLTRB(12, 0, 12, 0),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   shape: BoxShape.rectangle,
//                   color: const Color.fromARGB(255, 255, 255, 255),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Color.fromARGB(5, 17, 20, 177),
//                       offset: Offset(0, 3),
//                       blurRadius: 3,
//                     ),
//                   ],
//                 ),
//                 child: ChartTransaksiApp(
//                   idWallet: selectedlistWallet.idWallet,
//                 ),
//               ),
//               Container(
//                 width: 343,
//                 height: 20,
//                 margin: const EdgeInsets.fromLTRB(16, 10, 0, 10),
//                 child: Row(
//                   children: [
//                     Container(
//                       width: 120,
//                       height: 20,
//                       margin: const EdgeInsets.fromLTRB(0, 1.5, 120, 1.5),
//                       child: const Text(
//                         "Transaksi Terbaru",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontFamily: 'Plus Jakarta Sans',
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: Color(0xff5C616F),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       behavior: HitTestBehavior.opaque,
//                       onTap: () {
//                         // Navigate to all transactions
//                         // context.push('/all-transactions');
//                       },
//                       child: SizedBox(
//                         width: 86,
//                         height: 17,
//                         child: Row(children: [
//                           const Text(
//                             "Lihat Semua",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontFamily: 'Plus Jakarta Sans',
//                               fontSize: 12,
//                               fontWeight: FontWeight.w500,
//                               color: Color(0xff2C14DD),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 16,
//                             height: 16,
//                             child: SvgPicture.asset(
//                               "assets/arrow_forward.svg",
//                               width: 16,
//                               height: 16,
//                             ),
//                           )
//                         ]),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.fromLTRB(16, 0, 16, 5),
//                 child: Container(
//                   width: 343,
//                   height: 170,
//                   decoration: BoxDecoration(
//                     color: const Color(0xffffffff),
//                     shape: BoxShape.rectangle,
//                     borderRadius: BorderRadius.circular(10),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Color.fromARGB(5, 17, 20, 177),
//                         offset: Offset(0, 3),
//                         blurRadius: 3,
//                       ),
//                     ],
//                   ),
//                   child: SizedBox(
//                     width: 330,
//                     child: Column(
//                       children: <Widget>[
//                         Expanded(
//                           child: SizedBox(
//                             child: ListView.builder(
//                               controller: _scrollController,
//                               padding: EdgeInsets.zero,
//                               itemCount:
//                                   (_currentPage * 10 >= transactions.length
//                                       ? transactions.length
//                                       : _currentPage * 10),
//                               itemBuilder: (BuildContext context, int index) {
//                                 var transaksis = transactions[index];
//                                 return ListTransaksiCard(
//                                   transaksis.KeteranganTransaksi,
//                                   transaksis.nominal,
//                                   transaksis.sisaSaldo,
//                                   transaksis.TanggalTransaksi,
//                                   transaksis.DebitKredit,
//                                   transaksis.idTransaksi,
//                                 );
//                               },
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         floatingActionButton: SizedBox(
//           height: 40,
//           width: 40,
//           child: FittedBox(
//             child: FloatingActionButton(
//               backgroundColor: const Color.fromARGB(255, 30, 0, 255),
//               onPressed: () {
//                 // Navigate to create transaction
//                 // Navigator.push(
//                 //     context,
//                 //     MaterialPageRoute(
//                 //         builder: (context) => CreateMultiTransaksiApp()));
//               },
//               elevation: 12,
//               child: Container(
//                 child: SvgPicture.asset("assets/plus-white.svg"),
//               ),
//             ),
//           ),
//         ),
//         bottomNavigationBar: Padding(
//           padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//           child: Container(
//             width: 390,
//             height: 60,
//             margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//             child: FooterCard(
//               namaMenu: "Overview",
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
