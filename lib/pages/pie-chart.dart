import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uas_flutter/models/response-go.dart';
import 'package:uas_flutter/pages/box-decoration.dart';
import 'package:uas_flutter/view/transaksi/cubit/transaksi_cubit.dart';

class PieChartTransaksiApp extends StatefulWidget {
  static const routeName = '/piechart';
  const PieChartTransaksiApp({
    super.key,
  });
  // GetTx.GetTransaksi meta;

  @override
  State<PieChartTransaksiApp> createState() => PieChartTransaksiCard();
}

class PieChartTransaksiCard extends State<PieChartTransaksiApp> {
  int isHarian = 0;
  int isMingguan = 0;
  int isBulanan = 1;

  String tanggal = "";
  List<GetJenisTransaksiModel> listJenisTransaksi = [
    GetJenisTransaksiModel(
        NamaJenisTransaksi: "Create Kategori", idJenisTransaksi: 0)
  ];

  GetJenisTransaksiModel selectedjenisTransaksi = GetJenisTransaksiModel(
      NamaJenisTransaksi: "Create Kategori", idJenisTransaksi: 0);
  String? dropdownJenisTransaksiValue;
  UpdateChart(int isHarian, int isMingguan, int isBulanan) async {
    setState(() {
      this.isHarian = isHarian;
      this.isMingguan = isMingguan;
      this.isBulanan = isBulanan;
    });
  }

  GetBerandaModel getberanda = GetBerandaModel(
    totalDebit: 0,
    totalKredit: 0,
    totalSisa: 0,
    isget: 0,
    idCoa: 0,
    harian: List.empty(),
    pekanan: List.empty(),
    bulanan: List.empty(),
  );
  GetBeranda() async {
    final cubit = context.read<TransaksiCubit>();
    if (getberanda.isget == 0) {
      final result = await cubit.getBeranda(idWallet: 1);
      result.fold(
        (failure) {},
        (data) {
          setState(() {
            getberanda = data;
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('David', 25),
      ChartData('Steve', 38),
      ChartData('Jack', 34),
      ChartData('Others', 52)
    ];
    return Column(
      children: [
        Container(
          width: 319,
          height: 38,
          // margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
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
                  child: const Center(
                    child: Text(
                      'Harian',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 1.26,
                        color: Color(0xff131313),
                      ),
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
                  child: const Center(
                    child: Text(
                      'Mingguan',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 1.26,
                        color: Color(0xff131313),
                      ),
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
                  child: const Center(
                    child: Text(
                      'Bulanan',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 1.26,
                        color: Color(0xff131313),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SfCircularChart(
          series: <CircularSeries>[
            // Render pie chart
            PieSeries<ChartData, String>(
                dataLabelSettings: DataLabelSettings(isVisible: true),
                dataSource: chartData,
                pointColorMapper: (ChartData data, _) => data.color,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y)
          ],
        ),
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}
