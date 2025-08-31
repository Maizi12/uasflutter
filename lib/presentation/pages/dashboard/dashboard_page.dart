import 'package:digit/core/utils/constant/appconstants.dart';
import 'package:digit/presentation/widgets/dashboard/balance_card.dart';
import 'package:digit/presentation/widgets/dashboard/dashboard_header.dart';
import 'package:digit/presentation/widgets/dashboard/section_header.dart';
import 'package:digit/presentation/widgets/dashboard/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:digit/presentation/cubits/transaksi/transaksi_cubit.dart';
import 'package:digit/presentation/cubits/transaksi/transaksi_state.dart';
import 'package:digit/presentation/widgets/chart_transaksi.dart';
import 'package:digit/presentation/widgets/footer_card.dart';
import 'package:digit/data/models/response_go.dart';
import 'package:go_router/go_router.dart';

// main dashboard page
class DashboardPage extends StatefulWidget {
  static const routeName = '/dashboard';
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() {
    context.read<TransaksiCubit>().getWallet(AppConstants.IdJenisWallet);
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

// class DashboardPage extends StatefulWidget {
//   static const routeName = '/transaksi';
//   const DashboardPage({super.key});

//   @override
//   State<DashboardPage> createState() => DashboardPageState();
// }

// class DashboardPageState extends State<DashboardPage> {
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
