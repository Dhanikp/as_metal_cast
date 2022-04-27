import 'package:as_metal_cast/config/color_file.dart';
import 'package:as_metal_cast/methods/snackbar.dart';
import 'package:as_metal_cast/models/month.dart';
import 'package:flutter/material.dart';

import 'package:as_metal_cast/widgets/drawerList.dart';

List<DrawerList> drawerItem = [
  DrawerList(
      index: "0",
      title: "Dashboard",
      icon: 'assets/images/dashboard.png',
      color: primaryColor),
  DrawerList(
      index: "1",
      title: "Purchases",
      icon: 'assets/images/product_purchase.png',
      color: primaryColor),
  DrawerList(
      index: "2",
      title: "Sells",
      icon: 'assets/images/product_sell.png',
      color: primaryColor),
  DrawerList(
      index: "3",
      title: "Stock",
      icon: 'assets/images/product_stock.png',
      color: primaryColor),
  DrawerList(
      index: "4",
      title: "My Items",
      icon: 'assets/images/product_stock.png',
      color: primaryColor),
];

List<Month> monthList = [
  Month(name: "January", value: "01"),
  Month(name: "February", value: "02"),
  Month(name: "March", value: "03"),
  Month(name: "April", value: "04"),
  Month(name: "May", value: "05"),
  Month(name: "June", value: "06"),
  Month(name: "July", value: "07"),
  Month(name: "August", value: "08"),
  Month(name: "September", value: "09"),
  Month(name: "October", value: "10"),
  Month(name: "November", value: "11"),
  Month(name: "December", value: "12"),
];

List<String> days = [
  "01",
  "02",
  "03",
  "04",
  "05",
  "06",
  "07",
  "08",
  "09",
  "10",
  "11",
  "12",
  "13",
  "14",
  "15",
  "16",
  "17",
  "18",
  "19",
  "20",
  "21",
  "22",
  "23",
  "24",
  "25",
  "26",
  "27",
  "28",
  "29",
  "30",
  "31",
];

List<String> years = [];
