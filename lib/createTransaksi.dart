import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uas_flutter/transaksi.dart';
import 'package:uas_flutter/transaksi2.dart';

class CreateTransaksiApp extends StatefulWidget {
  CreateTransaksiApp({Key? key});

  @override
  State<CreateTransaksiApp> createState() => CreateTransaksi();
}

class CreateTransaksi extends State<CreateTransaksiApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: 375,
      height: 820,
      decoration: BoxDecoration(
        color: Color(0xffF5F7FF),
      ),
      child: Column(children: [
        SizedBox(
          height: 44,
        ),
        Container(
          width: 375,
          height: 40,
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(16, 8, 0, 0),
                  child: IconButton(
                    iconSize: 24,
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      if (context.mounted) Navigator.of(context).pop();
                    },
                  )),
              Container(
                margin: EdgeInsets.fromLTRB(50, 20, 0, 0),
                width: 125,
                height: 24,
                child: const Text(
                  'Buat Transaksi',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    // color: Color.fromARGB(0, 0, 0, 0),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 24,
        ),
        Container(
          width: 343,
          height: 42,
          margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
          child: Row(children: [
            Container(
                width: 165.5,
                height: 34,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(1, 245, 247, 255),
                      offset: Offset(0, 2),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "Pengeluaran",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )),
            Container(
                width: 165.5,
                height: 34,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x0c000000),
                      offset: Offset(0, 2),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "Pemasukan",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ))
          ]),
        ),
        SizedBox(
          height: 24,
        ),
        Container(
          width: 335,
          height: 575,
          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Column(children: [
            Container(
                child: Center(
              child: Text(
                "JUMLAH TRANSAKSI",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )),
            Container(
              margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: Row(children: [
                Container(
                    width: 36,
                    height: 36,
                    margin: EdgeInsets.fromLTRB(11, 0, 0, 0),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(17, 10, 0, 0),
                      child: SvgPicture.asset(
                        'assets/button-rounded-minus.svg',
                        height: 24,
                        width: 24,
                      ),
                    )),
                Container(
                  margin: EdgeInsets.fromLTRB(104, 0, 0, 0),
                  child: Text(
                    "0",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(240, 29, 1, 214)),
                  ),
                ),
                Container(
                    width: 36,
                    height: 36,
                    margin: EdgeInsets.fromLTRB(110, 4, 0, 0),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(6, 10, 0, 0),
                      child: SvgPicture.asset(
                        'assets/button-rounded-plus.svg',
                        height: 24,
                        width: 24,
                      ),
                    )),
              ]),
            ),
            Divider(thickness: 1, color: Colors.black),
            Container(
              width: 335,
              height: 33,
              child: Row(
                children: [
                  Container(
                      width: 99,
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(117, 0, 102, 255),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0, 2),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "Rp 100,000",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'DM Sans',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 44, 20, 221)),
                        ),
                      )),
                  SizedBox(
                    width: 3,
                  ),
                  Container(
                      width: 99,
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(117, 0, 102, 255),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0, 2),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "Rp 500,000",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'DM Sans',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 44, 20, 221)),
                        ),
                      )),
                  SizedBox(
                    width: 7,
                  ),
                  Container(
                      width: 99,
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(117, 0, 102, 255),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0, 2),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "Rp 1,000,000",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'DM Sans',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 44, 20, 221)),
                        ),
                      )),
                ],
              ),
            ),
            Container(
              width: 335,
              height: 55,
              margin: EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Container(
                width: 271,
                height: 39,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text("Nama Transaksi",
                            style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff5C616F))),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        child: Text("Beli Makan",
                            style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff3E3E3E))),
                      )
                    ]),
              ),
            ),
            Container(
              width: 335,
              height: 55,
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(children: [
                Container(
                  width: 271,
                  height: 39,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text("Tanggal Transaksi",
                              style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff5C616F))),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          child: Text("Pilih Tanggal",
                              style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff3E3E3E))),
                        )
                      ]),
                ),
                Container(
                    child: Center(
                        child: SvgPicture.asset(
                  'assets/Calendar.svg',
                  width: 18,
                  height: 20,
                )))
              ]),
            ),
            Container(
              width: 335,
              height: 71,
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(children: [
                Container(
                  width: 271,
                  height: 39,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text("Kategori",
                              style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff5C616F))),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          child: Text("Pilih Kategori",
                              style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff3E3E3E))),
                        )
                      ]),
                ),
                Container(
                    child: Center(
                        child: SvgPicture.asset(
                  'assets/chevron-left.svg',
                  width: 20,
                  height: 20,
                )))
              ]),
            ),
            Container(
              width: 335,
              height: 71,
              margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Row(children: [
                Container(
                  width: 271,
                  height: 39,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text("Dompet",
                              style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff5C616F))),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          child: Text("Pilih Dompet",
                              style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff3E3E3E))),
                        )
                      ]),
                ),
                Container(
                    child: Center(
                        child: SvgPicture.asset(
                  'assets/chevron-left.svg',
                  width: 20,
                  height: 20,
                )))
              ]),
            ),
            Container(
              width: 335,
              height: 71,
              margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Row(children: [
                Container(
                  width: 271,
                  height: 39,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text("Pilih Dompet",
                              style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff5C616F))),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                            child: Row(
                          children: [
                            Container(
                              // frame204Jp (116:2555)
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
                              child: Text("Dompet Saya",
                                  style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff131313))),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(54, 0, 0, 0),
                              child: Text("Rp 5,200,00",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff161719))),
                            )
                          ],
                        )),
                      ]),
                ),
                Container(
                    child: Center(
                        child: SvgPicture.asset(
                  'assets/chevron-left.svg',
                  width: 20,
                  height: 20,
                )))
              ]),
            )
          ]),
        ),
        Container(
          width: 335,
          height: 48,
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          decoration: BoxDecoration(
            color: const Color(0xff2c14dd),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: Center(
                child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Transaksi2App()));
              },
              child: Text(
                'Tambah',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.26,
                  color: Color(0xfffbfbfb),
                ),
              ),
            )),
          ),
        ),
      ]),
    ));
  }
}
