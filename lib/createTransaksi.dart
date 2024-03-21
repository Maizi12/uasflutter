import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
      decoration: BoxDecoration(
        color: Color(0xfff5f7ff),
      ),
      child: Column(children: [
        SizedBox(
          height: 25,
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
          height: 64,
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
          height: 66,
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
            )
          ]),
        )
      ]),
    ));
  }
}
