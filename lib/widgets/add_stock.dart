import 'dart:async';

import 'package:as_metal_cast/config/color_file.dart';
import 'package:as_metal_cast/config/database_references.dart';
import 'package:as_metal_cast/methods/snackbar.dart';
import 'package:as_metal_cast/models/itemList.dart';
import 'package:as_metal_cast/models/purchaseProductData.dart';
import 'package:as_metal_cast/widgets/text_field.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../DataHandler/appData.dart';
import 'loader.dart';

class AddStock extends StatefulWidget {
  bool isAddItemClicked = false;
  String invoiceNo = '';
  double pricess = 0;
  bool _isUploading = false;

  @override
  State<AddStock> createState() => _AddStockState();
}

class _AddStockState extends State<AddStock> {
  TextEditingController invoiceNoController = new TextEditingController();
  TextEditingController custNameController = new TextEditingController();
  TextEditingController cgstNoController = new TextEditingController();
  TextEditingController sgstNoController = new TextEditingController();
  TextEditingController igstNoController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  TextEditingController distPriceController = new TextEditingController();
  TextEditingController taxController = new TextEditingController();
  TextEditingController paymentByController = new TextEditingController();

  TextEditingController paymentMethodController = new TextEditingController();
  TextEditingController termsController = new TextEditingController();
  TextEditingController noteController = new TextEditingController();

  TextEditingController itmDescController = new TextEditingController();
  TextEditingController itmQtyController = new TextEditingController();
  TextEditingController itmPriceController = new TextEditingController();

  get lighgtGrayTxtColor => null;
  bool isPrice = false;
  double rate = 0.0;
  double rounfOff = 0.0;
  double totalAmount = 0.0;
  String? selectedItemKey;
  double amount = 0.0;
  List<String> itemNameData = [];
  List<ItemList> itemKey = [];
  String? selectedItemName;

  // static const Map<String, Duration> frequencyOptions = {
  //   "30 seconds": Duration(seconds: 30),
  //   "1 minute": Duration(minutes: 1),
  //   "2 minutes": Duration(minutes: 2),
  // };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<AppData>(context, listen: false).getItems("2");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SingleChildScrollView(
      child: Consumer<AppData>(builder: (context, data, child) {
        return Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80,
                ),
                Container(
                  // margin: EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Stock Data",
                        style: GoogleFonts.montserrat(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: blackVariable),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          color: blackVariable,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // margin: EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add stock details according to you!",
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: greyTextColor),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Inventory No',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: greyTextColor,
                    )),
                EditText('Enter Inventory No', TextInputType.number, false,
                    50.0, 1, 1, invoiceNoController, 5),
                SizedBox(
                  height: 10,
                ),

                Text('Item Name',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: greyTextColor,
                    )),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color: Color.fromARGB(255, 224, 224, 224))),
                  padding: EdgeInsets.only(left: 10, right: 5),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      isExpanded: true,
                      iconSize: 18,
                      hint: Text(
                        'Select Item',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: greyTextColor,
                        ),
                      ),
                      value: selectedItemKey,
                      onChanged: (newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedItemKey = newValue.toString();
                          });
                        } else {
                          print('EMpty');
                        }
                      },
                      items: data.itemsNameList.map((value) {
                        return DropdownMenuItem(
                            child: Text(value.itemPurchasName.toString(),
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: blackVariable,
                                )),
                            value: value.itemPurchasName.toString() +
                                '/' +
                                value.itemKey.toString());
                      }).toList(),
                    ),
                  ),
                ),

                // //drop button

                SizedBox(
                  height: 10,
                ),
                Text('Quantity',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: greyTextColor,
                    )),
                EditText('Enter stock quantity(kg)', TextInputType.number,
                    false, 50.0, 1, 1, itmQtyController, 5),

                Text('Date',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: greyTextColor,
                    )),
                EditText('Enter Date', TextInputType.text, false, 50.0, 1, 1,
                    dateController, 5),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    if (invoiceNoController.text.length < 0 ||
                        invoiceNoController.text == '') {
                      showSnackBar(context, "Please enter inventory No", 0);
                    } else if (itmQtyController.text.length < 0 ||
                        dateController.text == '') {
                      showSnackBar(context, "Please enter stock quantity", 0);
                    } else if (dateController.text.length < 0 ||
                        dateController.text == '') {
                      showSnackBar(context, "Please enter invoice date", 0);
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => Loader());
                      Provider.of<AppData>(context, listen: false)
                          .uploadStockData(
                        selectedItemKey.toString().split('/')[1],
                        invoiceNoController.text.toString(),
                        selectedItemKey.toString().split('/')[0],
                        itmQtyController.text.toString(),
                        dateController.text.toString(),
                      )
                          .whenComplete(() {
                        clearText();
                        Navigator.pop(context);
                        // Navigator.pop(context);
                      });
                    }
                  },
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 1, 59, 3),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.upload,
                          color: white,
                          size: 16,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Upload Stock Detail',
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: white,
                            )),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ));
      }),
    ));
  }

  clearText() {
    invoiceNoController.clear();
    itmQtyController.clear();
    dateController.clear();
  }
  // dataSnapshot.value.forEach((key, values) async {
  //   // counter++;
  //   workCategoryList.add(key.toString());
  //   print(key.toString());

}
