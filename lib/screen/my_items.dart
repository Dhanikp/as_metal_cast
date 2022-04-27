import 'dart:async';
import 'dart:io';

import 'package:as_metal_cast/DataHandler/appData.dart';
import 'package:as_metal_cast/config/route_names.dart';
import 'package:as_metal_cast/methods/snackbar.dart';
import 'package:as_metal_cast/models/itemList.dart';
import 'package:as_metal_cast/models/purchaseProductData.dart';
import 'package:as_metal_cast/widgets/add_purchase.dart';
import 'package:as_metal_cast/widgets/loader.dart';
import 'package:as_metal_cast/widgets/purchaseList.dart';
import 'package:as_metal_cast/widgets/uploadItemList.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import '../config/color_file.dart';
import '../widgets/itemList.dart';

class MyItemsPage extends StatefulWidget {
  const MyItemsPage({Key? key}) : super(key: key);

  @override
  State<MyItemsPage> createState() => _MyItemsPageState();
}

class _MyItemsPageState extends State<MyItemsPage> {
  DateTime? _selected;
  List<String> multiPath = [];
  String? month, year;
  List<ItemList> itemData = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<AppData>(context, listen: false)
          .getItems("2")
          .whenComplete(() {
        itemData = Provider.of<AppData>(context, listen: false).itemsNameList;
      });
    });
    //
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(builder: (context, data, child) {
      return Container(
        color: white,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text('My Items',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: blackVariable,
                    )),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AddItemPageRoute);
                },
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: greyTextColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.add,
                        color: blackVariable,
                        size: 22,
                      ),
                      // SizedBox(
                      //   width: 8,
                      // ),
                      // Text('Add Details',
                      //     style: GoogleFonts.poppins(
                      //       fontSize: 12,
                      //       fontWeight: FontWeight.w500,
                      //       color: blackVariable,
                      //     )),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: lighgtGrayTxtColor1.withOpacity(1),
            height: 1,
          ),
          SizedBox(
            height: 30,
          ),
          (itemData.isNotEmpty)
              ? MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: itemData.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return ItemListPage(itemData[index]);
                        }),
                  ),
                )
              : Center(
                  child: Text(
                    "No Information Found.",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: blackVariable),
                  ),
                ),
        ]),
      );
    });
  }
}
