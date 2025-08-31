import 'package:flutter/material.dart';

class CustomBoxDecorations {
  static BoxDecoration BoxNonActive() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(70, 92, 97, 111),
          offset: Offset(0, 1),
          blurRadius: 1,
        ),
      ],
    );
  }
  static TextStyle FontBoxNonActive(){
    return TextStyle(
      fontFamily:
      'Plus Jakarta Sans',
      fontSize: 14,
      fontWeight:
      FontWeight.w600,
      height: 1.26,
      color:
      Color(0xff131313),
    );
  }
  static BoxDecoration BoxActive() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      boxShadow: const [
        BoxShadow(
          color: Colors.blueGrey,
          offset: Offset(0, 1),
          blurRadius: 0.5,
        ),
      ],
    );
  }
  static TextStyle FontBoxActive(){
    return TextStyle(
      fontFamily:
      'Plus Jakarta Sans',
      fontSize: 14,
      fontWeight:
      FontWeight.w600,
      height: 1.26,
      color:Colors.white
      ,
    );
  }
}
