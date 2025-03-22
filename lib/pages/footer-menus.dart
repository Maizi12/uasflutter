import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:uas_flutter/main.dart';
import 'package:uas_flutter/models/menu.dart';

class FooterMenus extends StatefulWidget {
  const FooterMenus(
      {super.key, required this.categories, required this.namaMenu});
  final List<GetMenu> categories;
  final String namaMenu;
  @override
  State<FooterMenus> createState() => FooterMenusAll();
}

class FooterMenusAll extends State<FooterMenus> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        height: 40,
        width: 340,
        margin: EdgeInsets.all(0),
        child:
            // ListView(
            // scrollDirection: Axis.horizontal,
            // children: [
            ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.categories.length,
                itemBuilder: (BuildContext context, int categoryIndex) {
                  return Container(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        context.push(
                            widget.categories[categoryIndex].routeNameMenu);
                        context.namedLocation(
                            widget.categories[categoryIndex].routeNameMenu);
                        context
                            .go(widget.categories[categoryIndex].routeNameMenu);

                        // Navigator.pushNamed(context,
                        //     widget.categories[categoryIndex].routeNameMenu);
                      },
                      child: Container(
                        // tab1aex (114:675)
                        width: 55,
                        margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                        // padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                        height: double.infinity,
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // option1t9r (114:682)
                              margin: const EdgeInsets.fromLTRB(0.33, 0, 0, 0),
                              width: 24,
                              height: 24,
                              child: SvgPicture.asset(
                                  'assets/${widget.categories[categoryIndex].namaIcon}.svg',
                                  height: 24,
                                  width: 24,
                                  colorFilter: widget.categories[categoryIndex]
                                              .namaMenu ==
                                          widget.namaMenu
                                      ? ColorFilter.mode(
                                          Color(0xff2c14dd), BlendMode.srcIn)
                                      : ColorFilter.mode(
                                          Colors.black54, BlendMode.srcATop)),
                            ),
                            Center(
                              // titleyh6 (114:679)
                              child: Text(
                                widget.categories[categoryIndex].namaMenu,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  height: 1.3333333333,
                                  color: widget.categories[categoryIndex]
                                              .namaMenu ==
                                          widget.namaMenu
                                      ? Color(0xff2c14dd)
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })
        // ],
        );
  }
}
