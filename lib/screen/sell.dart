import 'dart:async';
import 'dart:io';

import 'package:as_metal_cast/DataHandler/appData.dart';
import 'package:as_metal_cast/config/route_names.dart';
import 'package:as_metal_cast/methods/snackbar.dart';
import 'package:as_metal_cast/widgets/add_molasses.dart';
import 'package:intl/intl.dart';
import 'package:as_metal_cast/models/sellsProductData.dart';
import 'package:as_metal_cast/widgets/add_purchase.dart';
import 'package:as_metal_cast/widgets/add_sells.dart';
import 'package:as_metal_cast/widgets/purchaseList.dart';
import 'package:as_metal_cast/widgets/sellList.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import '../config/color_file.dart';
import '../data/data.dart';
import '../widgets/date_picker.dart';
import '../widgets/loader.dart';

class SellPage extends StatefulWidget {
  const SellPage({Key? key}) : super(key: key);

  @override
  State<SellPage> createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  DateTime? _selected;
  List<String> multiPath = [];
  String? month, year;
  final buffer = StringBuffer();
  String? itemNameString = "";
  List<SellsProductDataMethod> filteredData = [];
  List<SellsProductDataMethod> productData = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<AppData>(context, listen: false)
          .getSellProductData()
          .whenComplete(() {
        // setState(() {
        productData =
            Provider.of<AppData>(context, listen: false).sellsProductData;
        // });
      });
    });
    // });

    for (int i = 1999; i <= 2200; i++) {
      years.add(i.toString());
      print(i.toString());
    }
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
                child: Text('Sells Information',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: blackVariable,
                    )),
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
                  _onPressed();
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
                          return SellDataList(
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
              Provider.of<AppData>(context, listen: false).sellsProductData;
        });
      } else {
        this.month = month;
        this.year = year;
        this.productData = books;
      }
    });
  }

  Future<void> generateCSVFIle(var list) async {
    // String multilineString = "this\nis\nsome\ntext";
    // List<SellsProductDataMethod> data = [];
    // data.addAll(productData);
    SellsProductDataMethod sellsProductDataMethod = SellsProductDataMethod();
    print(sellsProductDataMethod.itemNameList);
    String? s = "Patel";
    s = s + "\n" + "dhanik";
    print(s);
    List<List<dynamic>> csvData = [
      <String>[
        'Invoice No',
        'Date',
        'Company Name',
        'Item Detail',
        'Quantity Purchase',
        'Price/Item',
        'Item Total Price',
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
            item.itemNameList
                .toString()
                .replaceAll(',', '\n')
                .replaceAll('[', '')
                .replaceAll(']', ''),
            item.itemQtyList
                .toString()
                .replaceAll(',', '\n')
                .replaceAll('[', '')
                .replaceAll(']', ''),
            item.itemPerPriceList
                .toString()
                .replaceAll(',', '\n')
                .replaceAll('[', '')
                .replaceAll(']', ''),
            item.itemPriceList
                .toString()
                .replaceAll(',', '\n')
                .replaceAll('[', '')
                .replaceAll(']', ''),
            item.itemPrice.toString(),
            item.cgstNo,
            item.sgstNo,
            item.igstNo,
            item.roundOff.toString(),
            item.grandTotal.toString(),
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

  List<SellsProductDataMethod> itemsBetweenDates({
    // required List<String> list1,
    required List<SellsProductDataMethod>? list,
    required String startString,
    required String endString,
  }) {
    list = [];

    assert(productData.length == productData.length);
    print('hello');
    // print(list.toList());
    var dateFormat = DateFormat('dd/MM/yyyy');
    // filteredData.clear();
    List<SellsProductDataMethod> output = [];
    for (var i = 0; i < productData.length; i += 1) {
      var date = dateFormat.parse(productData[i].invoiceDate.toString(), true);
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

  void _onPressed() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: white,
            height: 220,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 5,
                      width: 40,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: greyTextColor.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, AddSellRoute)
                              .then((value) => {
                                    print("hshahah"),
                                    // Navigator.pop(context),
                                    setState(() {
                                      productData.clear();
                                      Provider.of<AppData>(context,
                                              listen: false)
                                          .getSellProductData()
                                          .whenComplete(() {
                                        setState(() {
                                          productData = Provider.of<AppData>(
                                                  context,
                                                  listen: false)
                                              .sellsProductData;
                                        });
                                      });
                                    }),
                                  });
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          height: 80,
                          decoration: BoxDecoration(
                            color: greyTextColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.grey,
                            //     blurRadius: 2.0,
                            //   )
                            // ]
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Icon(
                              //   Icons.receipt_long,
                              //   color: Colors.black,
                              //   size: 25,
                              // ),
                              // SizedBox(
                              //   height: 5,
                              // ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Add Sell Data',
                                    style: GoogleFonts.nunito(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                  // ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, AddMolassesPage);
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          height: 80,
                          decoration: BoxDecoration(
                            color: greyTextColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.grey,
                            //     blurRadius: 2.0,
                            //   )
                            // ]
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Icon(
                              //   Icons.insert_emoticon,
                              //   color: blackVariable,
                              //   size: 25,
                              // ),
                              // SizedBox(
                              //   height: 5,
                              // ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Add Molasses Data',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.nunito(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: blackVariable),
                                  ),

                                  // ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    height: 60,
                    decoration: BoxDecoration(
                      color: greyTextColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey,
                      //     blurRadius: 2.0,
                      //   )
                      // ]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cancel',
                              style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            // ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
