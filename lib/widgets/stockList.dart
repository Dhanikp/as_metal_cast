import 'package:as_metal_cast/methods/snackbar.dart';
import 'package:as_metal_cast/models/stockProductData.dart';
import 'package:as_metal_cast/screen/stocDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/color_file.dart';

class StockListUI extends StatefulWidget {
  StockProductDataMethod stockProductDataMethod = StockProductDataMethod();
  StockListUI(this.stockProductDataMethod);

  @override
  State<StockListUI> createState() => _StockListUIState();
}

class _StockListUIState extends State<StockListUI> {
  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        onTap: () {
          print(widget.stockProductDataMethod.inventoryNo);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => StockDetailScreen(
                        stockKey: widget.stockProductDataMethod.stockKey,
                        itemName:
                            widget.stockProductDataMethod.itemName.toString(),
                      )));
          // );
        },
        child: Container(
            margin: EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: lighgtGrayTxtColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.stockProductDataMethod.inventoryNo ?? '00',
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: greyTextColor,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.stockProductDataMethod.itemName ?? '-',
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: blackVariable,
                                )),
                            Text(
                                'Closing stock : ' +
                                    widget.stockProductDataMethod.itemQty
                                        .toString() +
                                    ' kg/g',
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: greyTextColor1,
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: greyTextColor,
                    size: 16,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ]),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 1,
                  margin: EdgeInsets.only(left: 65, right: 10, bottom: 10),
                  color: lighgtGrayTxtColor.withOpacity(0.1),
                ),
              ],
            )),
      ),
    );
  }
}
