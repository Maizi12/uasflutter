import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ButtonDelete extends StatelessWidget {
  final VoidCallback? ontap;

  const ButtonDelete({super.key, this.ontap});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      width: 335,
      child: Row(children: [
        SizedBox(
          width: 264,
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            ontap?.call();
          },
          child: SizedBox(
              // width: 184,
              height: 24,
              child: Row(
                children: [
                  SizedBox(
                    width: 34,
                    height: 24,
                    child: Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        "Delete",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Plus Jakarta Sans',
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 13,
                  ),
                  SvgPicture.asset(
                    'assets/Trash_icon.svg',
                    width: 24,
                    height: 24,
                    colorFilter:
                        ColorFilter.mode(Colors.red, BlendMode.srcATop),
                  ),
                ],
              )),
        ),
      ]),
    );
  }
}

class ButtonTambah extends StatelessWidget {
  final VoidCallback? ontap;

  const ButtonTambah({super.key, this.ontap});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xff2c14dd),
        borderRadius: BorderRadius.circular(100),
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          ontap?.call();
        }, // TODO: Implement Submit Logic
        child: const Center(
          child: Text(
            'Tambah',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xfffbfbfb),
            ),
          ),
        ),
      ),
    );
  }
}
