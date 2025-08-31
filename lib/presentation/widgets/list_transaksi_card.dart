import 'package:flutter/material.dart';
import 'package:digit/domain/helper/currency_format.dart';

class ListTransaksiCard extends StatelessWidget {
  final String keteranganTransaksi;
  final num nominal;
  final num sisaSaldo;
  final String tglTransaksi;
  final String debitKredit;
  final int idTransaksi;
  
  const ListTransaksiCard(
    this.keteranganTransaksi,
    this.nominal,
    this.sisaSaldo,
    this.tglTransaksi,
    this.debitKredit,
    this.idTransaksi,
    {super.key}
  );
  
  @override
  Widget build(BuildContext context) {
    double baseWidth = 380;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    
    return Container(
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  // Navigate to edit transaction
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => EditTransaksiApp(
                  //           IdTransaksi: idTransaksi,
                  //         )));
                },
                child: Container(
                  width: 320,
                  height: 55,
                  margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0),
                  child: Row(children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(15 * fem, 0, 0 * fem, 0),
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 238, 242, 248),
                        borderRadius: BorderRadius.circular(80),
                      ),
                      child: Center(
                        child: Text(
                          keteranganTransaksi.isNotEmpty ? keteranganTransaksi[0] : "",
                          style: const TextStyle(
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
                      margin: EdgeInsets.fromLTRB(15 * fem, 0 * fem, 0 * fem, 0 * fem),
                      width: 120,
                      height: 38,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 14,
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
                          Container(
                            height: 12,
                            decoration: const BoxDecoration(),
                            child: Text(
                              tglTransaksi.isNotEmpty ? tglTransaksi.substring(0, 10) : "",
                              style: const TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 1.26,
                                color: Color.fromARGB(127, 19, 19, 19),
                              ),
                            ),
                          ),
                          if (sisaSaldo != 0)
                            Container(
                              height: 12,
                              child: const Text(
                                "Sisa Saldo",
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  height: 1.26,
                                  color: Color.fromARGB(127, 19, 19, 19),
                                ),
                              ),
                            ),
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
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  nominal != 0
                                      ? CurrencyFormat.convertToIdr(
                                          debitKredit == 'D' ? -nominal : nominal, 2)
                                      : "",
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    height: 1.26,
                                    color: Color.fromARGB(255, 22, 154, 0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (sisaSaldo != 0)
                            Container(
                              height: 18,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  width: 125,
                                  height: double.infinity,
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      sisaSaldo != 0
                                          ? CurrencyFormat.convertToIdr(sisaSaldo, 2)
                                          : "",
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        height: 1.26,
                                        color: Color.fromARGB(255, 22, 154, 0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
