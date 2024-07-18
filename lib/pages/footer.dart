import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FooterCard extends StatelessWidget {
  const FooterCard({super.key});
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color(0xffFFFFFF),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
          width: 320,
          height: 100,
          decoration: const BoxDecoration(
            color: Color(0xccffffff),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // tabsG8U (113:628)
                // margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                height: 50,
                width: 360,
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // tab1aex (114:675)
                      width: 105,
                      margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
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
                    Container(
                      // tab572c (114:691)
                      width: 105,
                      // margin: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                      height: 59,
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
                              'assets/Wallet.svg',
                              height: 24,
                              width: 24,
                            ),
                          ),
                          const Center(
                            // titleLvx (114:695)
                            child: Text(
                              'Budget',
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
                    Container(
                      width: 105,
                      // tab457r (114:703)
                      // margin: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              // iconlylightsettingRSc (114:805)
                              // margin: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                              width: 24,
                              height: 24,
                              child: SvgPicture.asset(
                                'assets/Setting.svg',
                                height: 24,
                                width: 24,
                              )),
                          const Center(
                            // title7aL (114:707)
                            child: Text(
                              'Tools ',
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
