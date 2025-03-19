import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:uas_flutter/route.dart';

class HeaderCard extends StatelessWidget implements PreferredSizeWidget {
  final String namaMenu;
  const HeaderCard({super.key, required this.namaMenu});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const SizedBox(
        height: 50,
      ),
      SizedBox(
          height: 37,
          child: Row(children: [
            // SizedBox(
            //   width: 16,
            // ),
            GestureDetector(
              child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Transform.rotate(
                    angle: 180 * pi / 180,
                    child: SvgPicture.asset(
                      "assets/arrow_forward.svg",
                      width: 50,
                      height: 50,
                    ),
                  )),
              onTap: () {
                if (navigationHistory.previousRoute != null) {
                  context.go(navigationHistory.previousRoute!);
                } else {
                  context.pop();
                }
              },
            ),
            SizedBox(
              width: 94,
            ),
            Align(
              alignment: FractionalOffset.center,
              child: Text(
                namaMenu,
              ),
            ),
          ])),
    ]));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class AppHeaderCard extends AppBar {
  final String namaMenu;
  AppHeaderCard({super.key, required this.namaMenu});
  Widget build(BuildContext context) {
    print("namaMenu");
    print(namaMenu);
    return AppBar(
      actions: [
        Container(
            child: Column(children: [
          const SizedBox(
            height: 32,
          ),
          SizedBox(
              height: 37,
              child: Row(children: [
                SizedBox(
                  width: 16,
                ),
                GestureDetector(
                  child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Transform.rotate(
                        angle: 180 * pi / 180,
                        child: SvgPicture.asset(
                          "assets/arrow_forward.svg",
                          width: 50,
                          height: 50,
                        ),
                      )),
                  onTap: () {
                    if (context.mounted) Navigator.of(context).pop();
                  },
                ),
                SizedBox(
                  width: 94,
                ),
                Align(
                  alignment: FractionalOffset.center,
                  child: Text(
                    namaMenu,
                  ),
                ),
              ])),
        ]))
      ],
    );
  }
}
