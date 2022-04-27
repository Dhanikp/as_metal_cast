import 'package:as_metal_cast/config/color_file.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../DataHandler/appData.dart';
import '../data/data.dart';
import '../methods/snackbar.dart';

class CustomDatePicker extends StatefulWidget {
  // const CustomDatePicker({Key? key}) : super(key: key);

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  String? startSelectedItemKey;
  String? startSelectDays;
  String? startSelectYear;

  String? endSelectedItemKey;
  String? endSelectDays;
  String? endSelectYear;
  bool isError = false;
  String? error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white.withOpacity(0.2),
        body: Container(
          margin: EdgeInsets.only(top: 50.0, left: 10.0, right: 10),
          child: Wrap(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(left: 10, top: 10),
                          child: Text(
                            "FILTER BY DATE RANGE",
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: blackVariable),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          "START DATE",
                          style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: blackVariable),
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              // width: 100,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color:
                                          Color.fromARGB(255, 224, 224, 224))),
                              padding: EdgeInsets.only(left: 10, right: 5),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  isExpanded: true,
                                  iconSize: 18,
                                  hint: Text(
                                    'Day',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: greyTextColor,
                                    ),
                                  ),
                                  value: startSelectDays,
                                  onChanged: (newValue) {
                                    if (newValue != null) {
                                      setState(() {
                                        isError = false;
                                        startSelectDays = newValue.toString();
                                        print(startSelectDays);
                                      });
                                    } else {
                                      print('EMpty');
                                    }
                                  },
                                  items: days.map((value) {
                                    return DropdownMenuItem(
                                        child: Text(value.toString(),
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: blackVariable,
                                            )),
                                        value: value.toString());
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              // width: 100,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color:
                                          Color.fromARGB(255, 224, 224, 224))),
                              padding: EdgeInsets.only(left: 10, right: 5),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  isExpanded: true,
                                  iconSize: 18,
                                  hint: Text(
                                    'month',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: greyTextColor,
                                    ),
                                  ),
                                  value: startSelectedItemKey,
                                  onChanged: (newValue) {
                                    if (newValue != null) {
                                      setState(() {
                                        isError = false;
                                        startSelectedItemKey =
                                            newValue.toString();
                                        print(startSelectedItemKey);
                                      });
                                    } else {
                                      print('EMpty');
                                    }
                                  },
                                  items: monthList.map((value) {
                                    return DropdownMenuItem(
                                        child: Text(value.name.toString(),
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: blackVariable,
                                            )),
                                        value: value.value.toString());
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              // width: 100,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color:
                                          Color.fromARGB(255, 224, 224, 224))),
                              padding: EdgeInsets.only(left: 10, right: 5),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  isExpanded: true,
                                  iconSize: 18,
                                  hint: Text(
                                    'Year',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: greyTextColor,
                                    ),
                                  ),
                                  value: startSelectYear,
                                  onChanged: (newValue) {
                                    if (newValue != null) {
                                      setState(() {
                                        isError = false;
                                        startSelectYear = newValue.toString();
                                        print(startSelectYear);
                                      });
                                    } else {
                                      print('EMpty');
                                    }
                                  },
                                  items: years.map((value) {
                                    return DropdownMenuItem(
                                        child: Text(value.toString(),
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: blackVariable,
                                            )),
                                        value: value.toString());
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          "FROM DATE",
                          style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: blackVariable),
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              width: 100,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color:
                                          Color.fromARGB(255, 224, 224, 224))),
                              padding: EdgeInsets.only(left: 10, right: 5),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  isExpanded: true,
                                  iconSize: 18,
                                  hint: Text(
                                    'Day',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: greyTextColor,
                                    ),
                                  ),
                                  value: endSelectDays,
                                  onChanged: (newValue) {
                                    if (newValue != null) {
                                      setState(() {
                                        isError = false;
                                        endSelectDays = newValue.toString();
                                        print(endSelectDays);
                                      });
                                    } else {
                                      print('EMpty');
                                    }
                                  },
                                  items: days.map((value) {
                                    return DropdownMenuItem(
                                        child: Text(value.toString(),
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: blackVariable,
                                            )),
                                        value: value.toString());
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              // width: 100,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color:
                                          Color.fromARGB(255, 224, 224, 224))),
                              padding: EdgeInsets.only(left: 10, right: 5),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  isExpanded: true,
                                  iconSize: 18,
                                  hint: Text(
                                    'month',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: greyTextColor,
                                    ),
                                  ),
                                  value: endSelectedItemKey,
                                  onChanged: (newValue) {
                                    if (newValue != null) {
                                      setState(() {
                                        isError = false;
                                        endSelectedItemKey =
                                            newValue.toString();
                                        print(endSelectedItemKey);
                                      });
                                    } else {
                                      print('EMpty');
                                    }
                                  },
                                  items: monthList.map((value) {
                                    return DropdownMenuItem(
                                        child: Text(value.name.toString(),
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: blackVariable,
                                            )),
                                        value: value.value.toString());
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              // width: 100,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color:
                                          Color.fromARGB(255, 224, 224, 224))),
                              padding: EdgeInsets.only(left: 10, right: 5),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  isExpanded: true,
                                  iconSize: 18,
                                  hint: Text(
                                    'Year',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: greyTextColor,
                                    ),
                                  ),
                                  value: endSelectYear,
                                  onChanged: (newValue) {
                                    if (newValue != null) {
                                      setState(() {
                                        isError = false;
                                        endSelectYear = newValue.toString();
                                        print(endSelectYear);
                                      });
                                    } else {
                                      print('EMpty');
                                    }
                                  },
                                  items: years.map((value) {
                                    return DropdownMenuItem(
                                        child: Text(value.toString(),
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: blackVariable,
                                            )),
                                        value: value.toString());
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Visibility(
                        visible: isError,
                        child: Container(
                          margin: EdgeInsets.only(left: 25, top: 20),
                          child: Text(
                            "Error: " + error!,
                            style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: redVariable),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Consumer<AppData>(builder: (context, data, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {
                                String startDate;
                                String endDate;
                                if (startSelectDays == null) {
                                  // please select date
                                  setState(() {
                                    isError = true;
                                    error = "Please Select Start Date Day.";
                                  });
                                } else if (startSelectedItemKey == null) {
                                  setState(() {
                                    isError = true;
                                    error = "Please Select Start Date Month.";
                                  });
                                } else if (startSelectYear == null) {
                                  setState(() {
                                    isError = true;
                                    error = "Please Select Start Date Year.";
                                  });
                                } else if (endSelectDays == null) {
                                  setState(() {
                                    isError = true;
                                    error = "Please Select End Date Day.";
                                  });
                                } else if (endSelectedItemKey == null) {
                                  setState(() {
                                    isError = true;
                                    error = "Please Select End Date Month.";
                                  });
                                } else if (endSelectYear == null) {
                                  setState(() {
                                    isError = true;
                                    error = "Please Select End Date Year.";
                                  });
                                } else {
                                  startDate = startSelectDays.toString() +
                                      '/' +
                                      startSelectedItemKey.toString() +
                                      '/' +
                                      startSelectYear.toString();
                                  endDate = endSelectDays.toString() +
                                      '/' +
                                      endSelectedItemKey.toString() +
                                      '/' +
                                      endSelectYear.toString();
                                  data
                                      .setDateRange(startDate, endDate)
                                      .whenComplete(() {
                                    data.getDateRangeBool(true);
                                    Navigator.pop(context);
                                  });
                                  print('start :' + startDate);
                                  print('from :' + endDate);
                                }
                              },
                              child: Container(
                                height: 35,
                                width: 100,
                                // margin: EdgeInsets.only(left: 40, right: 40),
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(1, 59, 3, 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Search',
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
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 35,
                                width: 100,
                                // margin: EdgeInsets.only(left: 40, right: 40),
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: greyTextColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Cancel',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: white,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      })
                    ]),
              ),
            ],
          ),
        ));
  }
}
