import 'package:as_metal_cast/DataHandler/appData.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../config/color_file.dart';
import '../methods/snackbar.dart';

class DrawerList extends StatefulWidget {
  String? index;
  String? title;
  String? icon;
  Color? color;

  String? isClicked;

  DrawerList({this.index, this.title, this.icon, this.color, this.isClicked});
  @override
  State<DrawerList> createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<AppData>(context, listen: false)
            .getIndex(widget.isClicked.toString());
        Navigator.pop(context);
      },
      child: Consumer<AppData>(builder: (context, data, child) {
        return Container(
          margin: EdgeInsets.all(2),
          height: 45,
          // padding: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: getSelectedIndex(data.selectedIndex)!
                ? primaryColor.withOpacity(0.15)
                : white.withOpacity(0),
          ),

          child: Row(
            children: [
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.circle,
                color: getSelectedIndex(data.selectedIndex)!
                    ? widget.color
                    : white.withOpacity(0),
                size: 5,
              ),
              SizedBox(
                width: 5,
              ),
              // Image(
              //   image: AssetImage(widget.icon.toString()),
              //   width: 25,
              //   height: 25,
              // ),

              // SizedBox(
              //   width: 10,
              // ),
              Visibility(
                visible: data.isExpandedDrawer ? false : true,
                child: Expanded(
                  child: Text(
                    widget.title ?? '',
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: getSelectedIndex(data.selectedIndex)!
                            ? widget.color
                            : lightestBlackColor),
                  ),
                ),
              ),
              // Container(
              //   width: 4,
              //   decoration: BoxDecoration(
              //     color: getSelectedIndex(Provider.of<AppData>(context, listen: false).selectedIndex.toString())!
              //         ? widget.color
              //         : white.withOpacity(0),
              //   ),
              //   height: MediaQuery.of(context).size.height,
              //   child: Text(
              //     '',
              //     style: GoogleFonts.montserrat(
              //       fontSize: 18,
              //       fontWeight: FontWeight.w300,
              //       color: getSelectedIndex(Provider.of<AppData>(context, listen: false).selectedIndex.toString())!
              //           ? widget.color
              //           : white.withOpacity(0),
              //     ),
              //   ),
              // ),
            ],
          ),
        );
      }),
    );
  }

  bool? getSelectedIndex(String index) {
    if (widget.index ==
        Provider.of<AppData>(context, listen: false).selectedIndex.toString()) {
      return true;
    } else {
      //  print("+"+widget.index.toString());
      // print(Provider.of<AppData>(context, listen: false).selectedIndex.toString());
      return false;
    }
  }
}
