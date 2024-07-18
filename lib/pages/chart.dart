import 'package:flutter/material.dart';

class ChartTransaksiCard extends StatelessWidget {
  const ChartTransaksiCard(
      // this.keteranganTransaksi, this.nominal, this.waktuTransaksi,
      {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 311,
      height: 232,
      // margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      child: Column(
        children: [
          Container(
            width: 311,
            height: 181,
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(children: [
              Container(
                width: 302,
                height: 162,
                margin: const EdgeInsets.fromLTRB(9, 0, 0, 3),
              ),
              Container(
                width: 311,
                height: 16,
                margin: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: Row(children: [
                  Container(
                    width: 22,
                    height: 16,
                    margin: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                    child: const Text(
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
                    margin: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                    child: const Text(
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
                    margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: const Text(
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
                    margin: const EdgeInsets.fromLTRB(0, 0, 27, 0),
                    child: const Text(
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
                    margin: const EdgeInsets.fromLTRB(0, 0, 22, 0),
                    child: const Text(
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
                    margin: const EdgeInsets.fromLTRB(0, 0, 14, 0),
                    child: const Text(
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
                    margin: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                    child: const Text(
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
            margin: const EdgeInsets.fromLTRB(16, 0, 0, 0),
            child: Row(children: [
              SizedBox(
                width: 93,
                height: 35,
                child: Column(children: [
                  Container(
                    width: 67,
                    height: 13,
                    margin: const EdgeInsets.fromLTRB(4, 0, 22, 0),
                    child: Row(children: [
                      Container(
                        // oval8P6 (117:2777)
                        margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              width: 2, color: const Color(0xff1fde00)),
                          color: const Color(0xffffffff),
                        ),
                      ),
                      const SizedBox(
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
                    margin: const EdgeInsets.fromLTRB(0, 4, 4, 0),
                    child: const Text(
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
              SizedBox(
                width: 93,
                height: 35,
                child: Column(children: [
                  Container(
                    width: 67,
                    height: 13,
                    margin: const EdgeInsets.fromLTRB(0, 0, 22, 0),
                    child: Row(children: [
                      Container(
                        // oval8P6 (117:2777)
                        margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              width: 2, color: const Color(0xffff4040)),
                          color: const Color(0xffffffff),
                        ),
                      ),
                      const SizedBox(
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
                    margin: const EdgeInsets.fromLTRB(0, 4, 4, 0),
                    child: const Text(
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
              SizedBox(
                width: 93,
                height: 35,
                child: Column(children: [
                  Container(
                    width: 67,
                    height: 13,
                    margin: const EdgeInsets.fromLTRB(0, 0, 22, 0),
                    child: Row(children: [
                      Container(
                        // oval8P6 (117:2777)
                        margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color(0xffffffff),
                          border: const Border(),
                        ),
                      ),
                      const SizedBox(
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
                    margin: const EdgeInsets.fromLTRB(0, 4, 4, 0),
                    child: const Text(
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
    ); //
  }
}
