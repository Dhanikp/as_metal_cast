import 'dart:async';

import 'package:as_metal_cast/config/color_file.dart';
import 'package:as_metal_cast/methods/snackbar.dart';
import 'package:as_metal_cast/widgets/loader.dart';
import 'package:as_metal_cast/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../DataHandler/appData.dart';

class AddSells extends StatefulWidget {
  bool isAddItemClicked = false;
  String invoiceNo = '';
  int pricess = 0;

  bool _isUploading = false;
  @override
  State<AddSells> createState() => _AddSellsState();
}

class _AddSellsState extends State<AddSells> {
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
  get primaryColor => null;

  double rate = 0.0;
  double rounfOff = 0.0;
  double totalAmount = 0.0;
  double amount = 0.0;
  bool isSgst = false;
  bool isIgst = false;
  var selectedItemKey;
  List<String> itemNameData = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<AppData>(context, listen: false).getPriceRoundOff(0.0, true);
      Provider.of<AppData>(context, listen: false).getPurchaseTotalAmount(0.0);
      Provider.of<AppData>(context, listen: false).getItemPrice(0.0);
      Provider.of<AppData>(context, listen: false)
          .getItems("1")
          .whenComplete(() => {
                itemNameData = Provider.of<AppData>(context, listen: false)
                    .itemSellNameStringList,
              });
      cgstNoController.addListener(() {
        if (cgstNoController.text.isNotEmpty) {
          setState(() {
            isSgst = true;
          });
        } else {
          setState(() {
            isSgst = false;
          });
        }
      });

      sgstNoController.addListener(() {
        if (sgstNoController.text.isNotEmpty) {
          setState(() {
            isIgst = true;
          });
        } else {
          setState(() {
            isIgst = false;
          });
        }
      });
      igstNoController.addListener(() {
        amount = ((double.parse(cgstNoController.text) / 100) +
                (double.parse(sgstNoController.text) / 100) +
                (double.parse(igstNoController.text) / 100)) *
            Provider.of<AppData>(context, listen: false).subTotalPrice;
        print("Amount" + amount.toString());
        totalAmount =
            Provider.of<AppData>(context, listen: false).subTotalPrice + amount;

        Provider.of<AppData>(context, listen: false)
            .getPurchaseTotalAmount(totalAmount.round().toDouble());

        rounfOff = double.parse(Provider.of<AppData>(context, listen: false)
                .totalPurchaseAmount) -
            totalAmount;
        Provider.of<AppData>(context, listen: false)
            .getPriceRoundOff(rounfOff, false);
      });
    });

//     Provider.of<AppData>(context, listen: false).getInvoiceReceiptData().whenComplete(() {
// widget.invoiceNo = (int.parse(Provider.of<AppData>(context, listen: false).invoiceNumber)+1).toString();
//  if(widget.invoiceNo.length==1){
// invoiceNoController.text = "00000"+widget.invoiceNo;
// }else if(widget.invoiceNo.length==2){
// invoiceNoController.text = "0000"+widget.invoiceNo;
// }
// else if(widget.invoiceNo.length==3){
// invoiceNoController.text = "00"+widget.invoiceNo;
// }
// else if(widget.invoiceNo.length==4){
// invoiceNoController.text = "0"+widget.invoiceNo;
// }
// else if(widget.invoiceNo.length==5){
// invoiceNoController.text = widget.invoiceNo;
// }

    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<AppData>(builder: (context, data, child) {
          return Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
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
                          "Sells Data",
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
                          "Add Sells details according to you!",
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
                  Text('Invoice No',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: greyTextColor,
                      )),
                  EditText('Enter Invoice No', TextInputType.number, false,
                      50.0, 1, 1, invoiceNoController, 5),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Invoice Date',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: greyTextColor,
                      )),
                  EditText('Enter Date', TextInputType.text, false, 50.0, 1, 1,
                      dateController, 5),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Customer Name',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: greyTextColor,
                      )),
                  EditText('Enter Customer Name', TextInputType.text, false,
                      50.0, 1, 1, custNameController, 5),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Consumer<AppData>(builder: (context, data, child) {
                    return Visibility(
                      visible: data.isAddItemClicked ? true : false,
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 240, 248, 254),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Item Description',
                                  style: GoogleFonts.poppins(
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
                                        color: Color.fromARGB(
                                            255, 224, 224, 224))),
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
                                          child: Text(
                                              value.itemSellName.toString(),
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: blackVariable,
                                              )),
                                          value: value.itemSellName.toString() +
                                              '/' +
                                              value.itemKey.toString());
                                    }).toList(),
                                  ),
                                ),
                              ),

                              // EditText('Enter Item Name', TextInputType.text,
                              //     false, 50.0, 1, 1, itmDescController, 5),
                              Text('Qty',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: greyTextColor,
                                  )),
                              EditText('Enter Item Qty', TextInputType.number,
                                  false, 50.0, 1, 1, itmQtyController, 5),
                              Text('Price',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: greyTextColor,
                                  )),
                              EditText('Enter Item Price', TextInputType.number,
                                  false, 50.0, 1, 1, itmPriceController, 5),
                              SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                  onTap: () {
                                    if (itmQtyController.text.length < 0 ||
                                        itmQtyController.text == "") {
                                      showSnackBar(
                                          context, "Please add item Qty", 1);
                                    } else if (dateController.text.length < 0 ||
                                        dateController.text == "") {
                                      showSnackBar(
                                          context, "Please enter date", 1);
                                    } else if (itmPriceController.text.length <
                                            0 ||
                                        itmPriceController.text == "") {
                                      showSnackBar(
                                          context, "Please add item Price", 1);
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              Loader());
                                      data
                                          .uploadrecieptItemData(
                                              selectedItemKey
                                                  .toString()
                                                  .split('/')[1],
                                              selectedItemKey
                                                  .toString()
                                                  .split('/')[0],
                                              itmQtyController.text,
                                              itmPriceController.text)
                                          .whenComplete(() => {
                                                Timer(Duration(seconds: 2), () {
                                                  data
                                                      .getItemStockQty(
                                                          data.sellsKey,
                                                          selectedItemKey
                                                              .toString()
                                                              .split('/')[1],
                                                          dateController.text,
                                                          itmQtyController.text,
                                                          false)
                                                      .whenComplete(() {
                                                    itmQtyController.text = "";
                                                    itmDescController.text = "";
                                                    itmPriceController.text =
                                                        "";
                                                    data.setAddItemClicked(
                                                        false);
                                                    data
                                                        .getSubTotalPrice(
                                                            data.sellsKey)
                                                        .whenComplete(() {
                                                      data.getSubTotalQty(
                                                          data.sellsKey);
                                                    });

                                                    print('Qtyyy' +
                                                        data.subTotalQty
                                                            .toString());
                                                    Navigator.pop(context);
                                                    showSucessSnackBar(
                                                        context,
                                                        "Item Uploaded Successfully",
                                                        2);
                                                  });
                                                }),
                                              });
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: 120,
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 207, 255, 208),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.upload,
                                              color:
                                                  Color.fromARGB(255, 2, 84, 4),
                                              size: 16,
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text('Upload Item',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromARGB(
                                                      255, 2, 84, 4),
                                                )),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      )
                                    ],
                                  )),
                            ]),
                      ),
                    );
                  }),
                  InkWell(
                    onTap: () {
                      widget.isAddItemClicked = !widget.isAddItemClicked;
                      data.setAddItemClicked(widget.isAddItemClicked);
                    },
                    child: Container(
                      width: 100,
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: data.isAddItemClicked
                            ? Color.fromARGB(255, 207, 207, 207)
                            : Color.fromARGB(255, 191, 220, 244),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            data.isAddItemClicked ? Icons.close : Icons.add,
                            color: data.isAddItemClicked
                                ? Colors.black
                                : Colors.blue,
                            size: 16,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(data.isAddItemClicked ? 'Cancel' : "Add Item",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: data.isAddItemClicked
                                    ? Colors.black
                                    : Colors.blue,
                              )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('CGST Percentage',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: greyTextColor,
                      )),
                  EditText('Enter CGST Percentage', TextInputType.number, false,
                      50.0, 1, 1, cgstNoController, 5),
                  SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: isSgst,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('SGST Percentage',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: greyTextColor,
                              )),
                          EditText(
                              'Enter SGST Percentage',
                              TextInputType.number,
                              false,
                              50.0,
                              1,
                              1,
                              sgstNoController,
                              5),
                        ]),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  Visibility(
                    visible: isIgst,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('IGST Percentage',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: greyTextColor,
                              )),
                          EditText(
                              'Enter IGST Percentage',
                              TextInputType.number,
                              false,
                              50.0,
                              1,
                              1,
                              igstNoController,
                              5),
                        ]),
                  ),

                  // Text('SGST Percentage',
                  //     style: GoogleFonts.poppins(
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.w600,
                  //       color: greyTextColor,
                  //     )),
                  // EditText('Enter SGST Percentage', TextInputType.number, false,
                  //     50.0, 1, 1, sgstNoController, 5),

                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Text('IGST Percentage',
                  //     style: GoogleFonts.poppins(
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.w600,
                  //       color: greyTextColor,
                  //     )),
                  // EditText('Enter IGST Percentage', TextInputType.number, false,
                  //     50.0, 1, 1, igstNoController, 5),

                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            'Total Item Rate : ₹' +
                                data.subTotalPrice.toString(),
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: blackVariable,
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Total Amount : ₹' + data.totalPurchaseAmount,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: blackVariable,
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Round off : ₹' + data.purchaseRoundOff,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: blackVariable,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      if (invoiceNoController.text.length < 0 ||
                          invoiceNoController.text == '') {
                        showSnackBar(context, "Please enter invoice No", 0);
                      } else if (custNameController.text.length < 0 ||
                          custNameController.text == '') {
                        showSnackBar(context, "Please enter Customer Name", 0);
                      } else if (igstNoController.text.length < 0 ||
                          igstNoController.text == '') {
                        showSnackBar(context, "Please enter IGST", 0);
                      } else if (dateController.text.length < 0 ||
                          dateController.text == '') {
                        showSnackBar(context, "Please enter invoice date", 0);
                      } else {
                        if (cgstNoController.text.isEmpty) {
                          cgstNoController.text = "0";
                        } else if (sgstNoController.text.isEmpty) {
                          sgstNoController.text = "0";
                        } else {
                          setState(() {
                            widget._isUploading = true;
                          });
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => Loader());
                          Provider.of<AppData>(context, listen: false)
                              .uploadSellsProductData(
                                  invoiceNoController.text.toString(),
                                  custNameController.text.toString(),
                                  cgstNoController.text.toString(),
                                  sgstNoController.text.toString(),
                                  igstNoController.text.toString(),
                                  dateController.text.toString(),
                                  data.itemPrice.toString(),
                                  data.purchaseRoundOff.toString(),
                                  data.totalPurchaseAmount.toString())
                              .whenComplete(() {
                            Timer(Duration(seconds: 2), () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            });
                          });
                        }
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
                          Text(
                              widget._isUploading
                                  ? 'Uploading...'
                                  : 'Upload Sells Data',
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
      ),
    );
  }
}
