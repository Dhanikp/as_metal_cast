import 'package:as_metal_cast/config/route_names.dart';
import 'package:as_metal_cast/methods/snackbar.dart';
import 'package:as_metal_cast/models/stockProductData.dart';
import 'package:as_metal_cast/widgets/stockList.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../DataHandler/appData.dart';
import '../config/color_file.dart';

class StockPage extends StatefulWidget {
  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  DateTime? _selected;
  List<String> multiPath = [];
  String? month, year;
  List<StockProductDataMethod> productData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<AppData>(context, listen: false).getStockList();
      productData =
          Provider.of<AppData>(context, listen: false).stockProductList;
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
              Image(
                image: AssetImage('assets/images/product_stock.png'),
                width: 20,
                height: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text('Stock Info',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: blackVariable,
                    )),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AddStockPage);
                  // showDialog(
                  //     context: context,
                  //     builder: (BuildContext context) => AddInvoice());
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
                        size: 16,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Add Details',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: blackVariable,
                          )),
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
          (productData.isNotEmpty)
              ? MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: productData.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return StockListUI(productData[index]);
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
