import 'package:flutter/material.dart';

class AppColors {
  static const Color bgColor = Color(0xffF6F6F6);
//  static const Color HRed = Color(0xFFFF4B00);
  static const Color HRed = Color(0xFF684AE7);
  static const Color redy = Color(0xFFCA1818);
  static const Color red1 = Color(0xFFDA020E);
  static const Color baseColor = Color(0xFF9B86F2);
  static const Color lBlack = Color(0xFF222232);
 // static const Color red = Color(0xFF#9B86F2);
  //static const Color red = Color(0xFFF9A785);
  static const Color red = Color(0xFF9B86F2);
  static const Color cE8E8E8 = Color(0xFFE8E8E8);
  static const Color tableColor = Color(0xFF2E2F3E);
  static const Color playerBg = Color(0xFFE6E6E6);
  static const Color statistic = Color(0xFF242539);
  static const Color textColor = Color(0xFF797979);
  static const Color textColor2 = Color(0xFFD2B5FF);
  static const Color green = Color(0xFF4ECD8A);
  static const Color light_red = Color(0xFFFF5252);
  static const Color chartC = Color(0xFF21233A);
  static const Color chartC2 = Color(0xFF9399AB);
  static const Color contentColorCyan = Color(0xFF50E4FF);
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color white = Color(0xFFF3F4F5);
  static const Color purple = Color(0xFFBFBFBF);
  static const Color violit = Color(0xFF9B86F2);
  static const Color cyan = Color(0xFF84F4D4);
  static const Color mainGridLineColor = Colors.white10;



  static const Color primary = contentColorCyan;
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
}

extension ColorBrightness on Color {
  /// Darkens the color by [amount] where amount is a double between 0.0 and 1.0
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1, 'Amount must be between 0.0 and 1.0');
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}
