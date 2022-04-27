
import 'dart:ui';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

Color primaryColor = HexColor("#4982C3");
Color greyTextColor = HexColor("#979797");
Color bgColor = HexColor("#F7F6FB");
Color darkTxt = HexColor("#0E0E0E");
Color white = HexColor("#FFFFFF");
Color layoutColor = HexColor("#E5E5E5");
Color greyTextColor1 = HexColor("#919090");
Color editTextColor = HexColor("#444444");
Color darkGrayColor = HexColor("#32393F");
Color lighgtGrayTxtColor = HexColor("#A7A7A7");
Color lighgtGrayTxtColor1 = HexColor("#F2F2F2");
Color lighgtGrayTxtColor2 = HexColor("#F3F3F3");
Color lightBlackColor = HexColor("#32393F");
Color lightestBlackColor = HexColor("#444444");
Color sample1 = HexColor("#DEEBE4");
Color sample2 = HexColor("#050244");
Color sample3 = HexColor("#D1A245");
Color sample4 = HexColor("#9C2A37");
Color invoiceContainerColor = HexColor("#e7e7e7");







