import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:intl/intl.dart';
import "package:collection/collection.dart";
import 'package:as_metal_cast/DataHandler/appData.dart';
import 'package:as_metal_cast/config/route_names.dart';
import 'package:as_metal_cast/methods/snackbar.dart';
import 'package:as_metal_cast/models/purchaseProductData.dart';
import 'package:as_metal_cast/models/stockAddMinusMethod.dart';
import 'package:as_metal_cast/widgets/add_purchase.dart';
import 'package:as_metal_cast/widgets/loader.dart';
import 'package:as_metal_cast/widgets/purchaseList.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import '../config/color_file.dart';
import '../widgets/date_picker.dart';
import '../widgets/stockAddMinusList.dart';

class StockDetailScreen extends StatefulWidget {
  String? stockKey;
  String? itemName;

  StockDetailScreen({this.stockKey, this.itemName});

  @override
  State<StockDetailScreen> createState() => _StockDetailScreenState();
}

class _StockDetailScreenState extends State<StockDetailScreen> {
  List<String> multiPath = [];
  List<StockAddMinusMethod> productData = [];
  List<StockAddMinusMethod> filteredList = [];

  var total = 0.0;
  var totalll = 0.0;
  var str;
  List<StockAddMinusMethod> filteredData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<AppData>(context, listen: false)
          .getStockDetails(widget.stockKey.toString())
          .whenComplete(() {
        productData = Provider.of<AppData>(context, listen: false).stockAddList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: Consumer<AppData>(builder: (context, data, child) {
        return Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        // margin: EdgeInsets.only(top: 20),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: blackVariable,
                          size: 20,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            widget.itemName! + " Details",
                            style: GoogleFonts.montserrat(
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                                color: blackVariable),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  // print(set);
                                  total = 0.0;
                                  totalll = 0.0;
                                  str = productData.toSet().toList();
                                  for (int i = 0; i < productData.length; i++) {
                                    // productData.removeLast();

                                    // print(productData[i].toJson());

                                    if (str[i].date == str[i].date) {
                                      // filteredList.add(str[i]);
                                      // productData.removeAt(i);
                                      if (str[i].isAdded == "false") {
                                        // print(str[i].stockQty);

                                        total = total +
                                            double.parse(
                                                str[i].stockQty.toString());
                                        print("t " + total.toString());
                                      } else {
                                        // print(str[i].stockQty);
                                        // productData.removeAt(i);
                                        totalll = totalll +
                                            double.parse(
                                                str[i].stockQty.toString());
                                        print("total " + totalll.toString());
                                      }
                                    }
                                  }
                                  // print(str.length);

                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          Loader());
                                  generateCSVFIle(
                                      total,
                                      totalll,
                                      data.isaDateRangeSelected
                                          ? filteredData
                                          : productData);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: greyTextColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.file_download,
                                        color: blackVariable,
                                        size: 22,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text('Download .xls',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: blackVariable,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              InkWell(
                                onTap: () async {
                                  if (data.isaDateRangeSelected) {
                                    data.getDateRangeBool(false);
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            CustomDatePicker()).then((value) {
                                      if (data.isaDateRangeSelected) {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                Loader());
                                        itemsBetweenDates(
                                            list: productData,
                                            startString: data.startDateString!,
                                            endString: data.endDateString!);
                                        // Navigator.pop(context);

                                      }
                                    });

                                    // var startDate = DateTime.utc(2022, 01, 15);
                                    // var endDate = DateTime.utc(2022, 02, 31);

                                  }

                                  //   print(filteredData);
                                  //   for (int i = 0; i < filteredData.length; i++) {
                                  //     print(filteredData[i].invoiceDate.toString() +
                                  //         " : " +
                                  //         filteredData[i].itemName.toString());
                                  //   }
                                  // });

                                  // String? locale;
                                  // final localeObj = locale != null ? Locale(locale) : null;
                                  // final selected = await showMonthYearPicker(
                                  //   context: context,
                                  //   initialDate: _selected ?? DateTime.now(),
                                  //   firstDate: DateTime(2019),
                                  //   lastDate: DateTime(2024),
                                  //   locale: localeObj,
                                  // );
                                  // if (selected != null) {
                                  //   setState(() {
                                  //     _selected = selected;
                                  //     month = _selected.toString().substring(5, 7);
                                  //     year = _selected.toString().substring(0, 4);
                                  //     searchBook(month.toString(), year.toString());
                                  //   });
                                  // }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: greyTextColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        data.isaDateRangeSelected
                                            ? Icons.filter_list_off_outlined
                                            : Icons.filter_list,
                                        color: data.isaDateRangeSelected
                                            ? primaryColor
                                            : blackVariable,
                                        size: 22,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                          data.isaDateRangeSelected
                                              ? 'Filtered'
                                              : 'Filter',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: data.isaDateRangeSelected
                                                ? primaryColor
                                                : blackVariable,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              (data.isaDateRangeSelected
                      ? filteredData.isNotEmpty
                      : data.stockAddList.isNotEmpty)
                  ? MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.isaDateRangeSelected
                                ? filteredData.length
                                : data.stockAddList.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return StockAddMinusList(data.isaDateRangeSelected
                                  ? filteredData[index]
                                  : data.stockAddList[index]);
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
            ],
            // }),
          ),
        );
      }),
    ));
  }

  Future<void> generateCSVFIle(var total, var totall, var list) async {
    // List<PurchaseProductDataMethod> data = [];
    // data.addAll(productData);
    double stockQty;
    double stockClosingQty;

    // }
    List<List<dynamic>> csvData = [
      <String>[
        'Date',
        // 'Party Name',
        'Item Detail',
        'Stock Added',
        'Stock Deducted',
        'Closing Stock'
      ],
      ...list.map((item) => [
            item.date,
            item.itemName,
            // totalll.toString(),
            // total.toString(),
            (item.isAdded == "true") ? item.stockQty.toString() + " kg/g" : "",
            (item.isAdded == "false") ? item.stockQty.toString() + " kg/g" : "",
            item.closingStockQty.toString() + " kg/g",
          ]),
    ];
    String csv = const ListToCsvConverter().convert(csvData);
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String dirPath = dir +
        '/' +
        DateTime.now().toString().replaceAll(' ', "_").replaceAll("/", "_") +
        ".csv";

    File file = File(dirPath);
    await file.writeAsString(csv);
    Directory? documentDirectory;
    if (Platform.isIOS) {
      documentDirectory = await getApplicationDocumentsDirectory();
    } else {
      documentDirectory = await getExternalStorageDirectory();
    }

    String documentPath = documentDirectory!.path;
    multiPath.add(dirPath);

    Timer(Duration(seconds: 3), () {
      Navigator.pop(context);
      Share.shareFiles(multiPath);
    });
  }

  List<StockAddMinusMethod> itemsBetweenDates({
    // required List<String> list1,
    required List<StockAddMinusMethod>? list,
    required String startString,
    required String endString,
  }) {
    list = [];
    filteredData.clear();
    assert(productData.length == productData.length);
    print('hello');
    // print(list.toList());
    var dateFormat = DateFormat('dd/MM/yyyy');
    // filteredData.clear();
    List<StockAddMinusMethod> output = [];
    for (var i = 0; i < productData.length; i += 1) {
      var date = dateFormat.parse(productData[i].date.toString(), true);
      var start = dateFormat.parse(startString.toString(), true);
      var end = dateFormat.parse(endString.toString(), true);
      if (date.compareTo(start) >= 0 && date.compareTo(end) <= 0) {
        output.add(productData[i]);
      }
    }
    filteredData.addAll(output);
    // print(filteredData);

    Navigator.pop(context);

    return output;
  }
}
