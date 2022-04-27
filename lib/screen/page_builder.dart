import 'package:as_metal_cast/config/color_file.dart';
import 'package:as_metal_cast/screen/dashboard.dart';
import 'package:as_metal_cast/screen/my_items.dart';
import 'package:as_metal_cast/screen/purchases.dart';
import 'package:as_metal_cast/screen/sell.dart';
import 'package:as_metal_cast/screen/stock.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../DataHandler/appData.dart';
import '../methods/snackbar.dart';
import '../widgets/drawer2.dart';

class PageBuilder extends StatefulWidget {
  const PageBuilder({Key? key}) : super(key: key);

  @override
  State<PageBuilder> createState() => _PageBuilderState();
}

class _PageBuilderState extends State<PageBuilder> {
  String timeGretting = '';
  String _currentPageIndex = '';
  PageController _pageViewController = PageController(initialPage: 0);
  List<Widget> _pages = [
    Dashboard(),
    PurchasePage(),
    SellPage(),
    StockPage(),
    MyItemsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Consumer<AppData>(builder: (conteaxt, data, child) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10, left: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Ink(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: lighgtGrayTxtColor2),
                        child: InkWell(
                          onTap: () async {
                            //  print("Hello");
                            data.getExpandedDrawerValue(false);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => Drawer2());
                          },
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: lighgtGrayTxtColor2),
                            child: Center(
                              child: Icon(
                                Icons.menu,
                                color: Color.fromARGB(255, 117, 117, 117),
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        // flex: 1,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Company Dashboard',
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: blackVariable),
                              ),
                              //  SizedBox(height: 1,),
                              Text(
                                'Hi, ' + greeting(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: lighgtGrayTxtColor),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: PageView.builder(
                        controller: _pageViewController,
                        physics: const NeverScrollableScrollPhysics(),
                        onPageChanged: (index) {
                          setState(() {
                            WidgetsBinding.instance
                                ?.addPostFrameCallback((_) => setState(() {}));

                            // _currentPageIndex =
                            // print(_currentPageIndex);
                          });
                        },
                        itemCount: _pages.length,
                        itemBuilder: (_, index) {
                          return _pages[int.parse(data.selectedIndex)];
                        })),
              ]);
        }),
      ),
    );
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning!';
    }
    if (hour < 17) {
      return 'Good Afternoon!';
    }
    return 'Good Evening!';
  }
}
