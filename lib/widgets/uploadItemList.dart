import 'dart:async';

import 'package:as_metal_cast/config/color_file.dart';
import 'package:as_metal_cast/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../DataHandler/appData.dart';
import '../methods/snackbar.dart';
import 'loader.dart';

class UploadItemPage extends StatefulWidget {
  @override
  State<UploadItemPage> createState() => _UploadItemPageState();
}

class _UploadItemPageState extends State<UploadItemPage> {
  TextEditingController itemNoController = new TextEditingController();
  TextEditingController purchaseItemNameController =
      new TextEditingController();
  TextEditingController sellItemNameController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Builder(builder: (context) {
        return SingleChildScrollView(
          child: Container(
            color: white,
            padding: EdgeInsets.only(left: 20, right: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 100,
              ),
              Container(
                // margin: EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Upload Items",
                      style: GoogleFonts.poppins(
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
                      "Add Items according to you!",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: greyTextColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text('Item No',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: greyTextColor,
                  )),
              EditText('Enter item no', TextInputType.text, false, 50.0, 1, 1,
                  itemNoController, 5),
              SizedBox(
                height: 10,
              ),
              Text('Purchase Item Name',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: greyTextColor,
                  )),
              EditText('Enter purchase item name', TextInputType.text, false,
                  50.0, 1, 1, purchaseItemNameController, 5),
              SizedBox(
                height: 10,
              ),
              Text('Sell Item Name',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: greyTextColor,
                  )),
              EditText('Enter sell item names', TextInputType.text, false, 50.0,
                  1, 1, sellItemNameController, 5),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  if (itemNoController.text.isEmpty ||
                      purchaseItemNameController.text.isEmpty ||
                      sellItemNameController.text.isEmpty) {
                    showSnackBar(context, "All fields are mandatory", 1);
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => Loader());

                    Provider.of<AppData>(context, listen: false)
                        .uploadItems(
                            itemNoController.text,
                            purchaseItemNameController.text,
                            sellItemNameController.text)
                        .whenComplete(() {
                      Timer(Duration(seconds: 2), () {
                        clearText();
                        Navigator.pop(context);
                        showSucessSnackBar(
                            context, "Data Uploaded Successfully", 2);
                      });
                    });
                  }
                },
                child: Container(
                  height: 50,
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: primaryColor,
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
                      Text('Upload Purchases Detail',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: white,
                          )),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        );
      }),
    );
  }

  clearText() {
    itemNoController.clear();
    purchaseItemNameController.clear();
    sellItemNameController.clear();
  }
}
