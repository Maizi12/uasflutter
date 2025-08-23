import 'package:flutter/material.dart';
import 'package:uas_flutter/helper/rupiah.dart';
import 'package:uas_flutter/view/transaksi/editTransaksi.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ListTransaksiCard extends StatelessWidget {
  final String keteranganTransaksi;
  final num nominal;
  final num sisaSaldo;
  final String tglTransaksi;
  final String debitKredit;
  final int idTransaksi;
  const ListTransaksiCard(this.keteranganTransaksi, this.nominal,
      this.sisaSaldo, this.tglTransaksi,this.debitKredit, this.idTransaksi,
      {super.key});
  @override
  Widget build(BuildContext context) {
    double baseWidth = 380;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Container(
      // margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        children: [
          Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditTransaksiApp(
                                    IdTransaksi: idTransaksi,
                                  )));
                    },
                    child: Container(
                        width: 320,
                        height: 55,
                        margin:
                            EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0),
                        child: Row(children: [
                          Container(
                            // frame2777Nk (117:2833)
                            margin:
                                EdgeInsets.fromLTRB(15 * fem, 0, 0 * fem, 0),
                            width: 36,
                            height: 36,
                            // height: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 238, 242, 248),
                              borderRadius: BorderRadius.circular(80),
                            ),
                            child: Center(
                              child: Text(
                                keteranganTransaksi != ""
                                    ? keteranganTransaksi[0]
                                    : "",
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  height: 1.26,
                                  color: Color.fromARGB(255, 44, 20, 221),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            // frame305miC (117:2835)
                            margin: EdgeInsets.fromLTRB(
                                15 * fem, 0 * fem, 0 * fem, 0 * fem),
                            // height: double.infinity,
                            width: 120,
                            height: 38,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: 14,
                                  // titleVu6 (117:2836)
                                  child: AutoSizeText(
                                    keteranganTransaksi,
                                    style: const TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: 1.26,
                                      color: Color(0xff131313),
                                    ),
                                  ),
                                ),
                                Container(
                                    height: 12,
                                    decoration: BoxDecoration(),
                                    child: AutoSizeText(
                                      // titlecyi (117:2837)
                                      tglTransaksi != ""
                                          ? tglTransaksi.substring(0, 10)
                                          : "",
                                      // '31 Januari 2024',
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        height: 1.26,
                                        color: Color.fromARGB(127, 19, 19, 19),
                                      ),
                                    )),
                                Container(
                                    height: 12,
                                    child: sisaSaldo != 0
                                        ? AutoSizeText(
                                            // titlecyi (117:2837)
                                            "Sisa Saldo",
                                            // '31 Januari 2024',
                                            style: TextStyle(
                                              fontFamily: 'Plus Jakarta Sans',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              height: 1.26,
                                              color: Color.fromARGB(
                                                  127, 19, 19, 19),
                                            ),
                                          )
                                        : null)
                              ],
                            ),
                          ),
                          Container(
                            height: 36,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                      alignment: Alignment.centerRight,
                                      width: 125,
                                      height: 18,
                                      // titleNCC (117:2838)
                                      // margin: EdgeInsets.fromLTRB(
                                      // 0 * fem, 0 * fem, 0 * fem, 1 * fem),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: AutoSizeText(
                                          nominal != 0
                                              ? CurrencyFormat.convertToIdr(
                                                 debitKredit=='D'?-nominal:nominal, 2)
                                              : "",
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            height: 1.26,
                                            color:
                                                Color.fromARGB(255, 22, 154, 0),
                                          ),
                                        ),
                                      )),
                                ),
                                Container(
                                  height: 18,
                                  child: sisaSaldo != 0
                                      ? Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                              alignment: Alignment.centerRight,
                                              width: 125,
                                              height: double.infinity,
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: AutoSizeText(
                                                  sisaSaldo != 0
                                                      ? CurrencyFormat
                                                          .convertToIdr(
                                                              sisaSaldo, 2)
                                                      : "",
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                    fontFamily:
                                                        'Plus Jakarta Sans',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.26,
                                                    color: Color.fromARGB(
                                                        255, 22, 154, 0),
                                                  ),
                                                ),
                                              )),
                                        )
                                      : null,
                                ),
                              ],
                            ),
                          ),
                        ]))),
              ])
          // const SizedBox(width: 8),
          // Divider(thickness: 16, color: Colors.black)
        ],
      ),
    );
  }

  toList() {}
}
