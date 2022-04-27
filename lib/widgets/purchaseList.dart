import 'dart:async';

import 'package:as_metal_cast/models/purchaseProductData.dart';
import 'package:as_metal_cast/DataHandler/appData.dart';
import 'package:as_metal_cast/config/database_references.dart';
import 'package:as_metal_cast/methods/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../DataHandler/appData.dart';
import '../config/color_file.dart';

class PurchaseDataList extends StatefulWidget {
  PurchaseProductDataMethod purchaseData = PurchaseProductDataMethod();

  PurchaseDataList(this.purchaseData);
  @override
  State<PurchaseDataList> createState() => _PurchaseDataListState();
}

class _PurchaseDataListState extends State<PurchaseDataList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(builder: (context, data, child) {
      return Container(
        color: white,
        child: Column(children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            margin: EdgeInsets.only(top: 5),
            child: Row(
              children: [
                Container(
                  child: Icon(
                    Icons.person,
                    color: blackVariable,
                    size: 16,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    child: Text(widget.purchaseData.customerName.toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: blackVariable,
                        )),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: Text('₹' + widget.purchaseData.grandTotal.toString(),
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: blackVariable,
                      )),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                Container(
                  child: Icon(
                    Icons.person,
                    color: white,
                    size: 16,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    child: Text(widget.purchaseData.itemName.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: blackVariable,
                        )),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: Text(widget.purchaseData.invoiceDate.toString(),
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: blackVariable,
                      )),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                Icon(
                  Icons.person,
                  color: white,
                  size: 16,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(widget.purchaseData.invoiceNo.toString(),
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: greyTextColor,
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text('Purchase Data',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: darkTxt)),
                              content: Text(
                                  'Are you sure want to delete this data ?',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: darkTxt)),
                              actions: [
                                FlatButton(
                                  child: Text('Cancel',
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: darkTxt)),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                                FlatButton(
                                    child: Text('Delete',
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: primaryColor)),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      print(widget.purchaseData.stockKey);
                                      print(widget.purchaseData.innerStockKey);

                                      stockReference
                                          .child(widget.purchaseData.stockKey
                                              .toString())
                                          .child(widget
                                              .purchaseData.innerStockKey
                                              .toString())
                                          .remove()
                                          .whenComplete(() {
                                        data
                                            .updateStockOnUndo(
                                                widget.purchaseData.stockKey
                                                    .toString(),
                                                widget.purchaseData.itemQty
                                                    .toString(),
                                                true)
                                            .whenComplete(() {
                                          databaseReference
                                              .child(widget
                                                  .purchaseData.keyString
                                                  .toString())
                                              .remove();
                                        });

                                        showSucessSnackBar(context,
                                            "Data remove successfully", 2);
                                        // });
                                      });
                                    })
                              ],
                            ));
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 6),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: redVariable),
                    child: Icon(
                      Icons.delete,
                      color: white,
                      size: 16,
                    ),
                  ),
                ),
                // }),
                // ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 1,
            margin: EdgeInsets.only(right: 10, left: 35),
            color: greyTextColor.withOpacity(0.5),
          )
        ]),
      );
    });
  }
}
