import 'package:as_metal_cast/config/color_file.dart';
import 'package:as_metal_cast/methods/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../DataHandler/appData.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<AppData>(context, listen: false)
          .getPurchaseProductData()
          .whenComplete(() => {
                Provider.of<AppData>(context, listen: false)
                    .getSellProductData()
                    .whenComplete(() {
                  Provider.of<AppData>(context, listen: false)
                      .getItems('6')
                      .whenComplete(() {
                    Provider.of<AppData>(context, listen: false).getStockList();
                  });
                })
              });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(builder: (context, data, child) {
      return Container(
        color: white,
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Icon(
                Icons.explore_outlined,
                color: blackVariable,
                size: 18,
              ),
              SizedBox(
                width: 5,
              ),
              Text('Explore',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: blackVariable,
                  )),
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
          Row(
            //
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Provider.of<AppData>(context, listen: false)
                        .getIndex(1.toString());
                  },
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: lighgtGrayTxtColor1.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10),

                      border:
                          Border.all(color: Color.fromARGB(255, 224, 224, 224)),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey,
                      //     blurRadius: 2.0,
                      //   )
                      // ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image(
                        //   image: AssetImage('assets/images/product_purchase.png'),
                        //   width: 35,
                        //   height: 35,
                        // ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Purchases',
                              style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),

                            SizedBox(
                              width: 120,
                              child: Text(
                                data.purchaseProductData.length.toString() +
                                    ' Products',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: greyTextColor,
                                ),
                              ),
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
                width: 15,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Provider.of<AppData>(context, listen: false)
                        .getIndex(2.toString());
                  },
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: lighgtGrayTxtColor1.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10),

                      border:
                          Border.all(color: Color.fromARGB(255, 224, 224, 224)),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey,
                      //     blurRadius: 2.0,
                      //   )
                      // ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image(
                        //   image: AssetImage('assets/images/product_sell.png'),
                        //   width: 35,
                        //   height: 35,
                        // ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sells',
                              style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),

                            SizedBox(
                              width: 120,
                              child: Text(
                                'Total ' +
                                    data.sellsProductData.length.toString() +
                                    ' Sells',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: greyTextColor,
                                ),
                              ),
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
          SizedBox(
            height: 20,
          ),
          Row(
            //
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Provider.of<AppData>(context, listen: false)
                        .getIndex(3.toString());
                  },
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: lighgtGrayTxtColor1.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10),

                      border:
                          Border.all(color: Color.fromARGB(255, 224, 224, 224)),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey,
                      //     blurRadius: 2.0,
                      //   )
                      // ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image(
                        //   image: AssetImage('assets/images/product_stock.png'),
                        //   width: 35,
                        //   height: 35,
                        // ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Stock',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),

                            SizedBox(
                              width: 120,
                              child: Text(
                                'Total ' +
                                    data.stockProductList.length.toString() +
                                    ' Stock ',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: greyTextColor,
                                ),
                              ),
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
                width: 15,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Provider.of<AppData>(context, listen: false)
                        .getIndex(4.toString());
                  },
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: lighgtGrayTxtColor1.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10),

                      border:
                          Border.all(color: Color.fromARGB(255, 224, 224, 224)),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey,
                      //     blurRadius: 2.0,
                      //   )
                      // ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image(
                        //   image: AssetImage('assets/images/product_stock.png'),
                        //   width: 35,
                        //   height: 35,
                        // ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Items',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),

                            SizedBox(
                              width: 120,
                              child: Text(
                                'Total ' +
                                    data.itemsNameList.length.toString() +
                                    ' Items ',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: greyTextColor,
                                ),
                              ),
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
          )
        ]),
      );
    });
  }
}
