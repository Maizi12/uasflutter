import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uas_flutter/chart_bar.dart';
import 'package:uas_flutter/models/response-go.dart';
import 'package:uas_flutter/pages/components/box-decoration.dart';
import 'package:uas_flutter/util/data-fetch/beranda_helper.dart';
import 'package:uas_flutter/view/transaksi/cubit/transaksi_cubit.dart';

class ChartTransaksiApp extends StatefulWidget {
  static const routeName = '/chart';
  const ChartTransaksiApp({super.key, required this.idWallet});
  final int idWallet;
  // GetTx.GetTransaksi meta;

  @override
  State<ChartTransaksiApp> createState() => ChartTransaksiCard();
}

class ChartTransaksiCard extends State<ChartTransaksiApp> {
  void didUpdateWidget(covariant ChartTransaksiApp oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.idWallet != oldWidget.idWallet) {
      UpdateChart(isHarian, isMingguan, isBulanan);
      GetBeranda();
    }
  }

  int isHarian = 0;
  int isMingguan = 0;
  int isBulanan = 1;
  GetBerandaModel getberanda = GetBerandaModel.empty();
  String tanggal = "";
  List<GetJenisTransaksiModel> listJenisTransaksi = [
    GetJenisTransaksiModel(
        NamaJenisTransaksi: "Create Kategori", idJenisTransaksi: 0)
  ];

  GetJenisTransaksiModel selectedjenisTransaksi = GetJenisTransaksiModel(
      NamaJenisTransaksi: "Create Kategori", idJenisTransaksi: 0);
  String? dropdownJenisTransaksiValue;
  @override
  void initState() {
    super.initState();
    UpdateChart(0, 0, 1);
    GetBeranda();
  }

  void GetBeranda() async {
    final res = await fetchBeranda(context, widget.idWallet);
    setState(() {
      getberanda = res;
    });
  }

  UpdateChart(int isHarian, int isMingguan, int isBulanan) async {
    setState(() {
      this.isHarian = isHarian;
      this.isMingguan = isMingguan;
      this.isBulanan = isBulanan;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 311,
      height: 304,
      margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(5, 17, 20, 177),
            offset: Offset(0, 3),
            blurRadius: 3,
          ),
        ],
      ),
      child: Column(children: [
        Container(
          width: 319,
          height: 38,
          margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
          child: Row(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () async {
                  UpdateChart(1, 0, 0);
                  GetBeranda();
                },
                child: Container(
                  width: 97,
                  height: 34,
                  margin: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                  decoration: isHarian == 1
                      ? CustomBoxDecorations.BoxActive()
                      : CustomBoxDecorations.BoxNonActive(),
                  child: Center(
                    child: Text(
                      'Harian',
                      textAlign: TextAlign.center,
                      style: isHarian == 1
                          ? CustomBoxDecorations.FontBoxActive()
                          : CustomBoxDecorations.FontBoxNonActive()
                    ),
                  ),
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () async {
                  UpdateChart(0, 1, 0);
                  GetBeranda();
                },
                child: Container(
                  width: 97,
                  height: 34,
                  margin: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                  decoration: isMingguan == 1
                      ? CustomBoxDecorations.BoxActive()
                      : CustomBoxDecorations.BoxNonActive(),
                  child:  Center(
                    child: Text(
                      'Mingguan',
                      textAlign: TextAlign.center,
                      style: isMingguan == 1
                          ? CustomBoxDecorations.FontBoxActive()
                          : CustomBoxDecorations.FontBoxNonActive()
                    ),
                  ),
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () async {
                  UpdateChart(0, 0, 1);
                  GetBeranda();
                },
                child: Container(
                  width: 97,
                  height: 34,
                  margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                  decoration: isBulanan == 1
                      ? CustomBoxDecorations.BoxActive()
                      : CustomBoxDecorations.BoxNonActive(),
                  child: Center(
                    child: Text(
                      'Bulanan',
                      textAlign: TextAlign.center,
                      style: isBulanan == 1
                          ? CustomBoxDecorations.FontBoxActive()
                          : CustomBoxDecorations.FontBoxNonActive()
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 242,
          width: double.infinity,
          child: BarChartSample4(
            getberanda: getberanda,
            isBulanan: isBulanan,
            isHarian: isHarian,
            isMingguan: isMingguan,
          ),
        ),
      ]),
    );
  }
}
