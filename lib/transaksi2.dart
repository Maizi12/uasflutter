import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Transaksi2App extends StatefulWidget {
  Transaksi2App({Key? key});

  @override
  State<Transaksi2App> createState() => Transaksi2();
}

class Transaksi2 extends State<Transaksi2App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: 375,
            height: 891,
            decoration: BoxDecoration(
              color: Color(0xffF5F7FF),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 44,
                ),
                Container(
                  width: 375,
                  height: 64,
                  child: Row(children: [
                    Container(
                      width: 170,
                      height: 46,
                      margin: EdgeInsets.fromLTRB(20, 9, 114, 0),
                      child: Column(
                        children: [
                          Container(
                            width: 152,
                            height: 20,
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                  width: 18,
                                  height: 18,
                                  child: SvgPicture.asset(
                                    'assets/Logo.svg',
                                    height: 18,
                                    width: 18,
                                  ),
                                ),
                                Container(
                                  width: 102,
                                  margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                  child: Text(
                                    "Dompet Saya",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      height: 1.26,
                                      color: Color(0xff131313),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: SvgPicture.asset(
                                    'assets/caret-arrow-up.svg',
                                    height: 16,
                                    width: 16,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 170,
                            height: 18,
                            margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                            child: Text(
                              "Keuangan Kamu Terlihat Sehat",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                height: 1.26,
                                color: Color(0xff5C616F),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 12, 16, 12),
                      child: SvgPicture.asset(
                        'assets/notif.svg',
                        height: 40,
                        width: 40,
                      ),
                    )
                  ]),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(16, 16, 16, 24),
                  width: 343,
                  height: 107,
                  decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x3fe7e7e7),
                        offset: Offset(0, 4),
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(children: [
                    Container(
                      width: 311,
                      height: 14,
                      margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            margin: EdgeInsets.fromLTRB(0, 0, 194, 0),
                            child: Text(
                              "Dari",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff131313),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 1, 4, 1),
                            width: 12,
                            height: 12,
                            child: SvgPicture.asset(
                              'assets/Logo.svg',
                              height: 12,
                              width: 12,
                            ),
                          ),
                          Container(
                            width: 65,
                            child: Text(
                              "Dompet Saya",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                height: 1.26,
                                color: Color(0xff2C3235),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 256,
                      height: 49,
                      margin: EdgeInsets.fromLTRB(16, 12, 141, 16),
                      child: Column(children: [
                        Container(
                          width: 101,
                          height: 13,
                          margin: EdgeInsets.fromLTRB(0, 0, 85, 8),
                          child: Text(
                            "Total Pengeluaran",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff5C616F),
                            ),
                          ),
                        ),
                        Container(
                          width: 195,
                          height: 28,
                          // margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Row(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 127,
                                  height: 28,
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Text(
                                    "Rp 5,200,00",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xff161719),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 6, 0, 6),
                                  width: 24,
                                  height: 16,
                                  child: SvgPicture.asset(
                                    'assets/eye.svg',
                                    height: 16,
                                    width: 16,
                                  ),
                                )
                              ]),
                        )
                      ]),
                    )
                  ]),
                ),
                Container(
                  width: 139,
                  height: 20,
                  margin: EdgeInsets.fromLTRB(16, 0, 150, 12),
                  child: Text(
                    "Laporan Pengeluaran",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff161719),
                    ),
                  ),
                ),
                Container(
                  width: 343,
                  height: 330,
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Column(children: [
                    Container(
                      width: 311,
                      height: 42,
                      child: Row(
                        children: [
                          Container(
                            width: 150,
                            height: 34,
                            margin: EdgeInsets.fromLTRB(4, 4, 4, 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x3fe7e7e7),
                                  offset: Offset(0, 4),
                                  blurRadius: 1,
                                ),
                              ],
                            ),
                            child: Center(
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
                          Container(
                            width: 149.5,
                            height: 34,
                            margin: EdgeInsets.fromLTRB(0, 4, 0, 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x0c000000),
                                  offset: Offset(0, 1),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            child: Center(
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
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 311,
                      height: 232,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Column(
                        children: [
                          Container(
                            width: 311,
                            height: 181,
                            margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: Column(children: [
                              Container(
                                width: 302,
                                height: 162,
                                margin: EdgeInsets.fromLTRB(9, 0, 0, 3),
                              ),
                              Container(
                                width: 311,
                                height: 16,
                                margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: Row(children: [
                                  Container(
                                    width: 22,
                                    height: 16,
                                    margin: EdgeInsets.fromLTRB(0, 0, 7, 0),
                                    child: Text(
                                      'Sun',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Nunito Sans',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff848A9C),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 25,
                                    height: 16,
                                    margin: EdgeInsets.fromLTRB(0, 0, 25, 0),
                                    child: Text(
                                      'Mon',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Nunito Sans',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff848A9C),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 20,
                                    height: 16,
                                    margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                    child: Text(
                                      'Tue',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Nunito Sans',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff848A9C),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 27,
                                    height: 16,
                                    margin: EdgeInsets.fromLTRB(0, 0, 27, 0),
                                    child: Text(
                                      'Wed',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Nunito Sans',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff848A9C),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 22,
                                    height: 16,
                                    margin: EdgeInsets.fromLTRB(0, 0, 22, 0),
                                    child: Text(
                                      'Thu',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Nunito Sans',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff848A9C),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 14,
                                    height: 16,
                                    margin: EdgeInsets.fromLTRB(0, 0, 14, 0),
                                    child: Text(
                                      'Fri',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Nunito Sans',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff848A9C),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 19,
                                    height: 16,
                                    margin: EdgeInsets.fromLTRB(0, 0, 7, 0),
                                    child: Text(
                                      'Sat',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Nunito Sans',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff848A9C),
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                            ]),
                          ),
                          Container(
                            width: 311,
                            height: 35,
                            margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
                            child: Row(children: [
                              Container(
                                width: 93,
                                height: 35,
                                child: Column(children: [
                                  Container(
                                    width: 67,
                                    height: 13,
                                    margin: EdgeInsets.fromLTRB(4, 0, 22, 0),
                                    child: Row(children: [
                                      Container(
                                        // oval8P6 (117:2777)
                                        margin: EdgeInsets.fromLTRB(0, 0, 4, 0),
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                              width: 2,
                                              color: Color(0xff1fde00)),
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                      Container(
                                        width: 55,
                                        height: 13,
                                        child: Text(
                                          // shoppingS8t (117:2778)
                                          'Pemasukan',
                                          style: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff83899b),
                                          ),
                                        ),
                                      )
                                    ]),
                                  ),
                                  Container(
                                    width: 89,
                                    height: 18,
                                    margin: EdgeInsets.fromLTRB(0, 4, 4, 0),
                                    child: Text(
                                      "Rp 17,000,000",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff161719),
                                      ),
                                    ),
                                  )
                                ]),
                              ),
                              Container(
                                width: 93,
                                height: 35,
                                child: Column(children: [
                                  Container(
                                    width: 67,
                                    height: 13,
                                    margin: EdgeInsets.fromLTRB(0, 0, 22, 0),
                                    child: Row(children: [
                                      Container(
                                        // oval8P6 (117:2777)
                                        margin: EdgeInsets.fromLTRB(0, 0, 4, 0),
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                              width: 2,
                                              color: Color(0xffff4040)),
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                      Container(
                                        width: 55,
                                        height: 13,
                                        child: Text(
                                          // shoppingS8t (117:2778)
                                          'Pengeluaran',
                                          style: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff83899b),
                                          ),
                                        ),
                                      )
                                    ]),
                                  ),
                                  Container(
                                    width: 89,
                                    height: 18,
                                    margin: EdgeInsets.fromLTRB(0, 4, 4, 0),
                                    child: Text(
                                      "Rp 2,500,000",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff161719),
                                      ),
                                    ),
                                  )
                                ]),
                              ),
                              Container(
                                width: 93,
                                height: 35,
                                child: Column(children: [
                                  Container(
                                    width: 67,
                                    height: 13,
                                    margin: EdgeInsets.fromLTRB(0, 0, 22, 0),
                                    child: Row(children: [
                                      Container(
                                        // oval8P6 (117:2777)
                                        margin: EdgeInsets.fromLTRB(0, 0, 4, 0),
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: Color(0xffffffff),
                                          border: Border(),
                                        ),
                                      ),
                                      Container(
                                        width: 55,
                                        height: 13,
                                        child: Text(
                                          // shoppingS8t (117:2778)
                                          'Tersisa',
                                          style: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff83899b),
                                          ),
                                        ),
                                      )
                                    ]),
                                  ),
                                  Container(
                                    width: 89,
                                    height: 18,
                                    margin: EdgeInsets.fromLTRB(0, 4, 4, 0),
                                    child: Text(
                                      "Rp 2,500,000",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff161719),
                                      ),
                                    ),
                                  )
                                ]),
                              )
                            ]),
                          )
                        ],
                      ),
                    ),
                  ]),
                ),
                Container(
                  width: 343,
                  height: 20,
                  margin: EdgeInsets.fromLTRB(16, 0, 0, 12),
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        height: 20,
                        margin: EdgeInsets.fromLTRB(24, 1.5, 96, 1.5),
                        child: Text(
                          "Transaksi Terbaru",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff5C616F),
                          ),
                        ),
                      ),
                      Container(
                        width: 71,
                        height: 17,
                        child: Text(
                          "Lihat Semua",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff2C14DD),
                          ),
                        ),
                      ),
                      Container(
                        width: 16,
                        height: 16,
                        child: SvgPicture.asset(
                          "assets/arrow_forward.svg",
                          width: 16,
                          height: 16,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 343,
                  height: 134,
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 21),
                  child: Column(children: [
                    Container(
                      width: 311,
                      height: 102,
                      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Text("abcd"),
                    )
                  ]),
                ),
              ],
            )));
  }
}
