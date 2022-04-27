import 'package:as_metal_cast/methods/snackbar.dart';
import 'package:as_metal_cast/models/stockAddMinusMethod.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/color_file.dart';

class StockAddMinusList extends StatefulWidget {
  StockAddMinusMethod stockProductDataMethod = StockAddMinusMethod();
  StockAddMinusList(this.stockProductDataMethod);

  @override
  State<StockAddMinusList> createState() => _StockAddMinusListState();
}

class _StockAddMinusListState extends State<StockAddMinusList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(
                          image: (widget.stockProductDataMethod.isAdded ==
                                  "true")
                              ? AssetImage('assets/images/purchase_icon.png')
                              : AssetImage('assets/images/sell_icon.png'),
                          width: 25,
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                (widget.stockProductDataMethod.isAdded ==
                                        "true")
                                    ? widget.stockProductDataMethod.itemName
                                            .toString() +
                                        " Added to stock."
                                    : widget.stockProductDataMethod.itemName
                                            .toString() +
                                        " Sell from stock.",
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: blackVariable,
                                )),
                            Text(
                                (widget.stockProductDataMethod.isAdded ==
                                        "true")
                                    ? "+ " +
                                        widget.stockProductDataMethod.stockQty
                                            .toString() +
                                        " Kg/gram"
                                    : "- " +
                                        widget.stockProductDataMethod.stockQty
                                            .toString() +
                                        " Kg/gram",
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      (widget.stockProductDataMethod.isAdded ==
                                              "true")
                                          ? greenVariable
                                          : redVariable,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.stockProductDataMethod.date.toString(),
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: greyTextColor1,
                                )),
                            Text(
                                'Closing Stock : ' +
                                    widget
                                        .stockProductDataMethod.closingStockQty
                                        .toString() +
                                    ' kg/gram',
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: greyTextColor1,
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15,
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
        ));
  }
}
