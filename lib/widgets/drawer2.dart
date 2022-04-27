// import 'package:as_metal_cast/data/data.dart';
import 'package:as_metal_cast/methods/snackbar.dart';
// import 'package:as_metal_cast/widget/drawerList.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../DataHandler/appData.dart';
import '../config/color_file.dart';
import '../data/data.dart';
import 'drawerList.dart';

class Drawer2 extends StatefulWidget {
  @override
  State<Drawer2> createState() => _Drawer2State();
}

class _Drawer2State extends State<Drawer2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.1),
        body: Row(
          children: [
            Expanded(
              child: Container(
                color: white,
                width: 200,
                child: Consumer<AppData>(builder: (context, data, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 20,
                        ),
                        child: Center(
                          child: Image(
                            image: AssetImage('assets/images/logo.png'),
                            width: data.isExpandedDrawer ? 40 : 80,
                            height: data.isExpandedDrawer ? 50 : 90,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Expanded(
                          child: ListView.builder(
                              itemCount: drawerItem.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return Column(
                                  children: [
                                    DrawerList(
                                      index: drawerItem[index].index,
                                      title: drawerItem[index].title,
                                      icon: drawerItem[index].icon,
                                      color: drawerItem[index].color,
                                      isClicked: index.toString(),
                                    )
                                  ],
                                );
                              }),
                        ),
                      ),
                      Container(
                        height: 40,
                        margin: EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Visibility(
                                      visible:
                                          data.isExpandedDrawer ? false : true,
                                      child: Expanded(
                                        child: Text(
                                          "v 1.0.0",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: greyTextColor),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // Icon(

                                Row(
                                  children: [
                                    Visibility(
                                      visible:
                                          data.isExpandedDrawer ? false : true,
                                      child: Expanded(
                                        child: Text(
                                          "Powered By DRPYDEV",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: primaryColor),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                                // Icon(
                                //   Icons.arrow_back,
                                //   color: lightestBlackColor,
                                //   size: 20,
                                // ),
                                ,
                              ]),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
            Expanded(
              child: InkWell(
                splashColor: Colors.black.withOpacity(0.1),
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
            )
          ],
        ));
  }
}
