import 'package:as_metal_cast/models/itemList.dart';
import 'package:as_metal_cast/models/purchaseProductData.dart';
import 'package:as_metal_cast/DataHandler/appData.dart';
import 'package:as_metal_cast/config/database_references.dart';
import 'package:as_metal_cast/methods/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../DataHandler/appData.dart';
import '../config/color_file.dart';

class ItemListPage extends StatefulWidget {
  ItemList itemList = ItemList();
  ItemListPage(this.itemList);
  @override
  State<ItemListPage> createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(builder: (context, data, child) {
      return Container(
        color: white,
        child: Column(children: [
          Container(
            // padding: EdgeInsets.symmetric(horizontal: 5),
            margin: EdgeInsets.only(top: 5),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: Text("Item No : " + widget.itemList.itemNo.toString(),
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: greyTextColor,
                      )),
                ),
              ],
            ),
          ),
          Container(
            // padding: EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    child: Text(
                        "Sells Name : " +
                            widget.itemList.itemSellName.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: blackVariable,
                        )),
                  ),
                ),
              ],
            ),
          ),
          Container(
            // padding: EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                      "Purchased Name : " +
                          widget.itemList.itemPurchasName.toString(),
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: blackVariable,
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
                              title: Text('Item Data',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: darkTxt)),
                              content: Text(
                                  'Are you sure want to delete this item ?',
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

                                      itemReference
                                          .child(widget.itemList.itemKey
                                              .toString())
                                          .remove()
                                          .whenComplete(() => {
                                                showSucessSnackBar(
                                                    context,
                                                    "Data Removed Successfully",
                                                    2),
                                              });
                                    })
                              ],
                            ));
                  },
                  child: Container(
                    width: 80,
                    height: 25,
                    // margin: EdgeInsets.only(top: 6),
                    // padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.redAccent.withOpacity(0.3)),
                    child: Center(
                      child: Text('Delete',
                          style: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.red)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 1,
            color: greyTextColor.withOpacity(0.2),
            margin: EdgeInsets.only(left: 10, right: 5),
          )
        ]),
      );
    });
  }
}
