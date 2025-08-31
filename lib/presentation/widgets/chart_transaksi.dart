import 'package:flutter/material.dart';
import 'package:digit/data/models/response_go.dart';

class ChartTransaksiApp extends StatefulWidget {
  static const routeName = '/chart';
  const ChartTransaksiApp({super.key, required this.idWallet});
  final int idWallet;

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
    // This will be handled by the cubit
    setState(() {
      // Update beranda data
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
                      ? BoxDecoration(
                          color: const Color(0xff2C14DD),
                          borderRadius: BorderRadius.circular(8),
                        )
                      : BoxDecoration(
                          color: const Color(0xffF5F7FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                  child: Center(
                    child: Text(
                      'Harian',
                      textAlign: TextAlign.center,
                      style: isHarian == 1
                          ? const TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffffffff),
                            )
                          : const TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff5C616F),
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
                      ? BoxDecoration(
                          color: const Color(0xff2C14DD),
                          borderRadius: BorderRadius.circular(8),
                        )
                      : BoxDecoration(
                          color: const Color(0xffF5F7FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                  child: Center(
                    child: Text(
                      'Mingguan',
                      textAlign: TextAlign.center,
                      style: isMingguan == 1
                          ? const TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffffffff),
                            )
                          : const TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff5C616F),
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
                      ? BoxDecoration(
                          color: const Color(0xff2C14DD),
                          borderRadius: BorderRadius.circular(8),
                        )
                      : BoxDecoration(
                          color: const Color(0xffF5F7FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                  child: Center(
                    child: Text(
                      'Bulanan',
                      textAlign: TextAlign.center,
                      style: isBulanan == 1
                          ? const TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffffffff),
                            )
                          : const TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff5C616F),
                            ),
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
          child: Center(
            child: Text(
              'Chart will be implemented here',
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 14,
                color: Color(0xff5C616F),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
