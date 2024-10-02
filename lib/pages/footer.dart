import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uas_flutter/pages/all-tx.dart';

class FooterCard extends StatelessWidget {
  const FooterCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 390,
      color: const Color(0xffFFFFFF),
      child: Row(children: [
        Container(
          // padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          width: 360,
          height: 40,
          decoration: const BoxDecoration(
            color: Color(0xccffffff),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // tabsG8U (113:628)
                // margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                height: 40,
                width: 360,
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // tab1aex (114:675)
                      width: 65,
                      // margin: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                      // padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                      height: double.infinity,
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // option1t9r (114:682)
                            margin: const EdgeInsets.fromLTRB(0.33, 0, 8, 0),
                            width: 24,
                            height: 24,
                            child: SvgPicture.asset(
                              'assets/Overview.svg',
                              height: 24,
                              width: 24,
                            ),
                          ),
                          const Center(
                            // titleyh6 (114:679)
                            child: Text(
                              'Overview',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 1.3333333333,
                                color: Color(0xff2c14dd),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllTxApp()));
                      },
                      child: Container(
                        // tab572c (114:691)
                        width: 65,
                        margin: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              // iconlylightwalletF8p (114:798)
                              // margin: const EdgeInsets.fromLTRB(0, 0, 0, 1),
                              width: 24,
                              height: 24,
                              child: SvgPicture.asset(
                                'assets/Transaksi.svg',
                                height: 24,
                                width: 24,
                              ),
                            ),
                            const Center(
                              // titleLvx (114:695)
                              child: Text(
                                'Transaksi',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  height: 1.3333333333,
                                  color: Color(0xff64748b),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllTxApp()));
                      },
                      child: Container(
                        // tab572c (114:691)
                        width: 65,
                        margin: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              // iconlylightwalletF8p (114:798)
                              // margin: const EdgeInsets.fromLTRB(0, 0, 0, 1),
                              width: 24,
                              height: 24,
                              child: SvgPicture.asset(
                                'assets/COA.svg',
                                height: 24,
                                width: 24,
                              ),
                            ),
                            const Center(
                              // titleLvx (114:695)
                              child: Text(
                                'COA',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  height: 1.3333333333,
                                  color: Color(0xff64748b),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllTxApp()));
                      },
                      child: Container(
                        // tab572c (114:691)
                        width: 65,
                        margin: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              // iconlylightwalletF8p (114:798)
                              // margin: const EdgeInsets.fromLTRB(0, 0, 0, 1),
                              width: 24,
                              height: 24,
                              child: SvgPicture.asset(
                                'assets/report.svg',
                                height: 24,
                                width: 24,
                              ),
                            ),
                            const Center(
                              // titleLvx (114:695)
                              child: Text(
                                'Report',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  height: 1.3333333333,
                                  color: Color(0xff64748b),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllTxApp()));
                      },
                      child: Container(
                        // tab572c (114:691)
                        width: 65,
                        margin: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              // iconlylightwalletF8p (114:798)
                              // margin: const EdgeInsets.fromLTRB(0, 0, 0, 1),
                              width: 24,
                              height: 24,
                              child: SvgPicture.asset(
                                'assets/Setting.svg',
                                height: 24,
                                width: 24,
                              ),
                            ),
                            const Center(
                              // titleLvx (114:695)
                              child: Text(
                                'Setting',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  height: 1.3333333333,
                                  color: Color(0xff64748b),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
