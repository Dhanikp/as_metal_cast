import 'dart:async';
import 'dart:io';
import 'package:as_metal_cast/data/data.dart';
import 'package:as_metal_cast/models/itemList.dart';
import 'package:as_metal_cast/models/month.dart';
import 'package:as_metal_cast/widgets/date_picker.dart';
import 'package:intl/intl.dart';

import 'package:as_metal_cast/DataHandler/appData.dart';
import 'package:as_metal_cast/config/route_names.dart';
import 'package:as_metal_cast/methods/snackbar.dart';
import 'package:as_metal_cast/models/purchaseProductData.dart';
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

class PurchasePage extends StatefulWidget {
  const PurchasePage({Key? key}) : super(key: key);

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  DateTime? _selected;
  List<String> multiPath = [];
  List<String> datesList = [];
  List<String> itemsList = [];
  String? month, year;

  List<PurchaseProductDataMethod> productData = [];
  List<PurchaseProductDataMethod> filteredData = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<AppData>(context, listen: false)
          .getPurchaseProductData()
          .whenComplete(() {
        // setState(() {
        productData =
            Provider.of<AppData>(context, listen: false).purchaseProductData;
        // });
      });

      for (int i = 1999; i <= 2200; i++) {
        years.add(i.toString());
        print(i.toString());
      }
    });
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
                child: Text('Purchase Information',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: blackVariable,
                    )),
              ),
              // Row(
              //   children: [
              //     Container(
              //       margin: EdgeInsets.only(top: 10),
              //       width: 100,
              //       height: 50,
              //       decoration: BoxDecoration(
              //           color: white,
              //           borderRadius: BorderRadius.circular(5),
              //           border: Border.all(
              //               color: Color.fromARGB(255, 224, 224, 224))),
              //       padding: EdgeInsets.only(left: 10, right: 5),
              //       child: DropdownButtonHideUnderline(
              //         child: DropdownButton(
              //           isExpanded: true,
              //           iconSize: 18,
              //           hint: Text(
              //             'Day',
              //             style: GoogleFonts.montserrat(
              //               fontSize: 14,
              //               fontWeight: FontWeight.w600,
              //               color: greyTextColor,
              //             ),
              //           ),
              //           value: selectDays,
              //           onChanged: (newValue) {
              //             if (newValue != null) {
              //               setState(() {
              //                 selectDays = newValue.toString();
              //                 print(selectDays);
              //               });
              //             } else {
              //               print('EMpty');
              //             }
              //           },
              //           items: days.map((value) {
              //             return DropdownMenuItem(
              //                 child: Text(value.toString(),
              //                     style: GoogleFonts.montserrat(
              //                       fontSize: 14,
              //                       fontWeight: FontWeight.w600,
              //                       color: blackVariable,
              //                     )),
              //                 value: value.toString());
              //           }).toList(),
              //         ),
              //       ),
              //     ),
              //     Container(
              //       margin: EdgeInsets.only(top: 10),
              //       width: 100,
              //       height: 50,
              //       decoration: BoxDecoration(
              //           color: white,
              //           borderRadius: BorderRadius.circular(5),
              //           border: Border.all(
              //               color: Color.fromARGB(255, 224, 224, 224))),
              //       padding: EdgeInsets.only(left: 10, right: 5),
              //       child: DropdownButtonHideUnderline(
              //         child: DropdownButton(
              //           isExpanded: true,
              //           iconSize: 18,
              //           hint: Text(
              //             'month',
              //             style: GoogleFonts.montserrat(
              //               fontSize: 14,
              //               fontWeight: FontWeight.w600,
              //               color: greyTextColor,
              //             ),
              //           ),
              //           value: selectedItemKey,
              //           onChanged: (newValue) {
              //             if (newValue != null) {
              //               setState(() {
              //                 selectedItemKey = newValue.toString();
              //                 print(selectedItemKey);
              //               });
              //             } else {
              //               print('EMpty');
              //             }
              //           },
              //           items: monthList.map((value) {
              //             return DropdownMenuItem(
              //                 child: Text(value.name.toString(),
              //                     style: GoogleFonts.montserrat(
              //                       fontSize: 14,
              //                       fontWeight: FontWeight.w600,
              //                       color: blackVariable,
              //                     )),
              //                 value: value.value.toString());
              //           }).toList(),
              //         ),
              //       ),
              //     ),
              //     Container(
              //       margin: EdgeInsets.only(top: 10),
              //       width: 100,
              //       height: 50,
              //       decoration: BoxDecoration(
              //           color: white,
              //           borderRadius: BorderRadius.circular(5),
              //           border: Border.all(
              //               color: Color.fromARGB(255, 224, 224, 224))),
              //       padding: EdgeInsets.only(left: 10, right: 5),
              //       child: DropdownButtonHideUnderline(
              //         child: DropdownButton(
              //           isExpanded: true,
              //           iconSize: 18,
              //           hint: Text(
              //             'Year',
              //             style: GoogleFonts.montserrat(
              //               fontSize: 14,
              //               fontWeight: FontWeight.w600,
              //               color: greyTextColor,
              //             ),
              //           ),
              //           value: selectYear,
              //           onChanged: (newValue) {
              //             if (newValue != null) {
              //               setState(() {
              //                 selectYear = newValue.toString();
              //                 print(selectYear);
              //               });
              //             } else {
              //               print('EMpty');
              //             }
              //           },
              //           items: years.map((value) {
              //             return DropdownMenuItem(
              //                 child: Text(value.toString(),
              //                     style: GoogleFonts.montserrat(
              //                       fontSize: 14,
              //                       fontWeight: FontWeight.w600,
              //                       color: blackVariable,
              //                     )),
              //                 value: value.toString());
              //           }).toList(),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),

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
                            builder: (BuildContext context) => Loader());
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
              SizedBox(width: 10),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => Loader());
                  generateCSVFIle(
                      data.isaDateRangeSelected ? filteredData : productData);
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
              SizedBox(width: 10),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AddPurchaseRoute);
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
          (data.isaDateRangeSelected
                  ? filteredData.isNotEmpty
                  : productData.isNotEmpty)
              ? MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.isaDateRangeSelected
                            ? filteredData.length
                            : productData.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return PurchaseDataList(
                            data.isaDateRangeSelected
                                ? filteredData[index]
                                : productData[index],
                          );
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

  void searchBook(String month, String year) {
    final books = productData.where((element) {
      final date = element.invoiceDate;
      final search = month + '/' + year;
      return date!.contains(search.toString());
    }).toList();
    setState(() {
      if (productData.isEmpty) {
        setState(() {
          productData =
              Provider.of<AppData>(context, listen: false).purchaseProductData;
        });
      } else {
        this.month = month;
        this.year = year;
        this.productData = books;
      }
    });
  }

  Future<void> generateCSVFIle(var list) async {
    // List<PurchaseProductDataMethod> data = [];
    // data.addAll(productData);
    List<List<dynamic>> csvData = [
      <String>[
        'Invoice No',
        'Date',
        'Company Name',
        'Item Detail',
        'Quantity Purchase',
        'Price/Item',
        'Gross Amount',
        'CGST No',
        'SGST No',
        'IGST No',
        'Round Off',
        'Grand Total',
      ],
      ...list.map((item) => [
            item.invoiceNo,
            item.invoiceDate,
            item.customerName,
            item.itemName,
            item.itemQty,
            item.itemPerPrice.toString(),
            item.itemPrice.toString(),
            item.cgstNo,
            item.sgstNo,
            item.igstNo,
            item.roundOff.toString(),
            item.grandTotal.toString()
          ]),
    ];
    String csv = const ListToCsvConverter().convert(csvData);
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String dirPath = dir +
        '/' +
        DateTime.now().toString().replaceAll(' ', "_").replaceAll("/", "_") +
        ".csv";
    multiPath.clear();
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

  List<PurchaseProductDataMethod> itemsBetweenDates({
    // required List<String> list1,
    required List<PurchaseProductDataMethod>? list,
    required String startString,
    required String endString,
  }) {
    list = [];

    assert(productData.length == productData.length);
    print('hello');
    // print(list.toList());
    var dateFormat = DateFormat('dd/MM/yyyy');
    // filteredData.clear();
    List<PurchaseProductDataMethod> output = [];
    for (var i = 0; i < productData.length; i += 1) {
      var date = dateFormat.parse(productData[i].invoiceDate.toString(), true);
      var start = dateFormat.parse(startString.toString(), true);
      var end = dateFormat.parse(endString.toString(), true);
      if (date.compareTo(start) >= 0 && date.compareTo(end) <= 0) {
        output.add(PurchaseProductDataMethod(
          keyString: productData[i].keyString,
          itemkeyString: productData[i].itemkeyString,
          invoiceNo: productData[i].invoiceNo,
          customerName: productData[i].customerName,
          itemName: productData[i].itemName,
          itemQty: productData[i].itemQty,
          itemPerPrice: productData[i].itemPerPrice,
          cgstNo: productData[i].cgstNo,
          sgstNo: productData[i].sgstNo,
          igstNo: productData[i].igstNo,
          invoiceDate: productData[i].invoiceDate,
          itemPrice: productData[i].itemPrice,
          roundOff: productData[i].roundOff,
          grandTotal: productData[i].grandTotal,
        ));
      }
    }
    filteredData.addAll(output);
    // print(filteredData);

    Navigator.pop(context);

    return output;
  }
}
