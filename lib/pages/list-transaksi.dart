import 'package:flutter/material.dart';
import 'package:uas_flutter/editTransaksi.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ListTransaksiCard extends StatelessWidget {
  final String keteranganTransaksi;
  final String nominal;
  final String waktuTransaksi;
  final int idTransaksi;
  const ListTransaksiCard(this.keteranganTransaksi, this.nominal,
      this.waktuTransaksi, this.idTransaksi,
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
                              builder: (context) =>
                                  EditTransaksiApp(IdTransaksi: idTransaksi)));
                    },
                    child: SizedBox(
                        width: 340,
                        height: 40,
                        child: Row(children: [
                          Container(
                            // frame2777Nk (117:2833)
                            margin:
                                EdgeInsets.fromLTRB(15 * fem, 0, 0 * fem, 0),
                            width: 36,
                            // height: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xffeef2f8),
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
                                  color: Color(0xff2c14dd),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            // frame305miC (117:2835)
                            margin: EdgeInsets.fromLTRB(
                                15 * fem, 0 * fem, 10 * fem, 0 * fem),
                            // height: double.infinity,
                            width: 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
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
                                    child: AutoSizeText(
                                  // titlecyi (117:2837)
                                  '31 Januari 2024',
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    height: 1.26,
                                    color: Color(0xff131313),
                                  ),
                                ))
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                                alignment: Alignment.center,
                                width: 145,
                                height: double.infinity,
                                // titleNCC (117:2838)
                                // margin: EdgeInsets.fromLTRB(
                                // 0 * fem, 0 * fem, 0 * fem, 1 * fem),
                                child: Container(
                                  width: double.infinity,
                                  child: AutoSizeText(
                                    nominal,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      height: 1.26,
                                      color: Color(0xff1fde00),
                                    ),
                                  ),
                                )),
                          ),
                        ]))),
                SizedBox(
                  height: 10 * fem,
                ),
              ])
          // const SizedBox(width: 8),
          // Divider(thickness: 16, color: Colors.black)
        ],
      ),
    );
  }

  toList() {}
}
