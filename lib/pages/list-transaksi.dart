import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListTransaksiCard extends StatelessWidget {
  final String keteranganTransaksi;
  final String nominal;
  final String waktuTransaksi;
  ListTransaksiCard(
    this.keteranganTransaksi,
    this.nominal,
    this.waktuTransaksi,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan,
      child: Row(
        children: [
          SizedBox(
            width: 80,
            height: 30,
            // child: SvgPicture.asset(
            //   'assets/profile-svgrepo-com.svg',
            //   height: 30,
            //   width: 80,
            // ),
          ),
          Expanded(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Container(
                  // frame2777Nk (117:2833)
                  margin: EdgeInsets.fromLTRB(0, 0.5, 12, 1.5),
                  width: 36,
                  // height: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xffeef2f8),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: Text(
                      'F',
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 1.26,
                        color: Color(0xff2c14dd),
                      ),
                    ),
                  ),
                ),
                Container(
                  // frame305miC (117:2835)
                  margin: EdgeInsets.fromLTRB(0, 0, 63, 0),
                  // height: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // titleVu6 (117:2836)
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 4),
                        child: Text(
                          '$keteranganTransaksi',
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 1.26,
                            color: Color(0xff131313),
                          ),
                        ),
                      ),
                      Text(
                        // titlecyi (117:2837)
                        '31 Januari 2024',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 1.26,
                          color: Color(0xff131313),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // titleNCC (117:2838)
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 1),
                  child: Text(
                    '$nominal',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1.26,
                      color: Color(0xff1fde00),
                    ),
                  ),
                ),
              ])),
          // const SizedBox(width: 16),
          // SizedBox(
          //   child: Text(waktuKuliah),
          // ),
          // const SizedBox(width: 8),
          // Divider(thickness: 16, color: Colors.black)
        ],
      ),
    );
  }

  toList() {}
}
