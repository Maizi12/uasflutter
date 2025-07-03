import 'package:flutter/material.dart';

class CustomBoxDecorations {
  static BoxDecoration BoxNonActive() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      boxShadow: const [
        BoxShadow(
          color: Color(0x3fe7e7e7),
          offset: Offset(0, 4),
          blurRadius: 1,
        ),
      ],
    );
  }

  static BoxDecoration BoxActive() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      boxShadow: const [
        BoxShadow(
          color: Color(0x0c000000),
          offset: Offset(0, 1),
          blurRadius: 2,
        ),
      ],
    );
  }
}
