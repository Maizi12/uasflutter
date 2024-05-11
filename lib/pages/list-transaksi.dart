import 'package:flutter/material.dart';

class ListTransaksiCard extends StatelessWidget {
  final String keteranganTransaksi;
  final String nominal;
  final String waktuTransaksi;
  const ListTransaksiCard(
      this.keteranganTransaksi, this.nominal, this.waktuTransaksi,
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
                SizedBox(
                    width: 303,
                    height: 37,
                    child: Row(children: [
                      Container(
                        // frame2777Nk (117:2833)
                        margin: EdgeInsets.fromLTRB(16 * fem, 0, 12 * fem, 0),
                        width: 36,
                        // height: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xffeef2f8),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Center(
                          child: Text(
                            'F',
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
                            0 * fem, 0 * fem, 100 * fem, 0 * fem),
                        // height: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // titleVu6 (117:2836)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 0 * fem),
                              child: Text(
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
                            const Text(
                              // titlecyi (117:2837)
                              '31 Januari 2024',
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                height: 1.26,
                                color: Color(0xff131313),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // titleNCC (117:2838)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 1 * fem),
                        child: Text(
                          nominal,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 1.26,
                            color: Color(0xff1fde00),
                          ),
                        ),
                      ),
                    ])),
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
