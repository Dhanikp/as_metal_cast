// ignore_for_file: avoid_print

import 'dart:async';

import 'package:as_metal_cast/config/color_file.dart';
import 'package:as_metal_cast/config/route_names.dart';
import 'package:as_metal_cast/models/itemList.dart';
import 'package:as_metal_cast/models/molassesProductDataMethod.dart';
import 'package:as_metal_cast/models/purchaseProductData.dart';
import 'package:as_metal_cast/models/sellsProductData.dart';
import 'package:as_metal_cast/models/stockAddMinusMethod.dart';
import 'package:as_metal_cast/models/stockProductData.dart';
// import 'package:as_metal_cast/config/routes_name.dart';
// import 'package:as_metal_cast/models/invoice_data.dart';
// import 'package:as_metal_cast/screens/receipt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/database_references.dart';
import '../methods/snackbar.dart';

class AppData extends ChangeNotifier {
  String userAdminData = '';
  String userPassword = '';
  String userName = '';
  String selectedIndex = '0';
  bool isExpandedDrawer = false;
  int calculateDiscountPrice = 0;
  bool isAddItemClicked = false;
  String itemPrice = "0.0";
  String purchaseRoundOff = "0.0";
  List<String> purchaseItemList = [];
  String totalPurchaseAmount = "0.0";
  String sellsKey = '';
  List<String> sellItemNameList = [];
  List<String> sellItemnQtyList = [];
  List<String> sellItemnPriceList = [];
  List<String> sellItemPerPriceList = [];
  List<ItemList> itemsNameList = [];
  double subTotalPrice = 0.0;
  double subTotalQty = 0.0;
  String itemDetails = '';
  List<String> itemNameStringList = [];
  List<String> itemSellNameStringList = [];
  double todayStockQty = 0.0;
  var todayStockClosingQty;
  List<StockAddMinusMethod> todayStockList = [];
  String? startDateString, endDateString;
  var stockDatabalanceString;
  bool isaDateRangeSelected = false;

  List<PurchaseProductDataMethod> purchaseProductData = [];
  List<SellsProductDataMethod> sellsProductData = [];
  List<StockProductDataMethod> stockProductList = [];
  List<StockAddMinusMethod> stockAddList = [];

  MolassesProductDataMethod molassesProductDataMethod =
      MolassesProductDataMethod();
  PurchaseProductDataMethod productDataMethod = PurchaseProductDataMethod();
  SellsProductDataMethod sellsProductDataMethod = SellsProductDataMethod();
  StockProductDataMethod stockProductDataMethod = StockProductDataMethod();
  StockAddMinusMethod stockAddMinusMethod = StockAddMinusMethod();
  ItemList itemList = ItemList();
  Future<void> getIndex(String index) async {
    selectedIndex = index;
    notifyListeners();
  }

  Future<void> getExpandedDrawerValue(bool index) async {
    isExpandedDrawer = index;
    notifyListeners();
  }

  Future<void> getDateRangeBool(bool index) async {
    isaDateRangeSelected = index;
    notifyListeners();
  }

  Future<void> setDateRange(String startDate, String endDate) async {
    startDateString = startDate;
    endDateString = endDate;
    getDateRangeBool(true);
    notifyListeners();
  }

  Future<void> getItemPrice(double price) async {
    itemPrice = price.toString();
    notifyListeners();
  }

  Future<void> getSellsKey(String price) async {
    sellsKey = price.toString();
    notifyListeners();
  }

  Future<void> getPriceRoundOff(double price, bool empty) async {
    if (empty) {
      purchaseRoundOff = "0.0";
      notifyListeners();
    } else {
      purchaseRoundOff = price.toString().substring(0, 5);
      notifyListeners();
    }
  }

  Future<void> getPurchaseTotalAmount(double price) async {
    totalPurchaseAmount = price.toString();
    notifyListeners();
  }

  Future<void> setSubTotal(double index) async {
    subTotalPrice = index;
    notifyListeners();
    print(subTotalPrice);
  }

  Future<void> setSubQty(double index) async {
    subTotalQty = index;
    notifyListeners();
    print(subTotalQty);
  }

  Future<void> setTodayStockQty(double index) async {
    todayStockQty = index;
    notifyListeners();
    print(todayStockQty);
  }

  Future<void> uploadrecieptItemData(
    String itemKey,
    String itemDesc,
    String itemQty,
    String itemPrice,
  ) async {
    double price;
    price = double.parse(itemQty) * double.parse(itemPrice);
    if (sellsKey == '') {
      print('key not available');
      DatabaseReference newRef = sellDataReference.push();
      String newKey = newRef.key!;
      getSellsKey(newKey);

      await newRef.child("items").push().set({
        'itemKey': itemKey,
        'itemDesc': itemDesc,
        'itemQty': itemQty,
        'itemPerPrice': itemPrice.toString(),
        'itemPrice': price.toString(),
      });
    } else {
      print('key  available');
      sellDataReference.child(sellsKey).child("items").push().set({
        'itemKey': itemKey,
        'itemDesc': itemDesc,
        'itemQty': itemQty,
        'itemPerPrice': itemPrice.toString(),
        'itemPrice': price.toString(),
      });

      // }

    }
  }

  Future<void> getSellsItemData(
    String itemDesc,
    String itemQty,
    String itemPrice,
  ) async {
    int price;
    price = int.parse(itemQty) * int.parse(itemPrice);
    if (sellsKey == '') {
      DatabaseReference newRef = sellDataReference.push();
      String newKey = newRef.key!;
      getSellsKey(newKey);

      await newRef.child("items").push().set({
        'itemDesc': itemDesc,
        'itemQty': itemQty,
        'itemPrice': price.toString(),
      });
    } else {
      sellDataReference.child(sellsKey).child("items").push().set({
        'itemDesc': itemDesc,
        'itemQty': itemQty,
        'itemPrice': price.toString(),
      });
    }
  }

  Future<void> getSubTotalPrice(String invoiceNo) async {
    print(invoiceNo);
    sellDataReference
        .child(invoiceNo)
        .child('items')
        .onValue
        .listen((event) async {
      setSubTotal(0.0);
      var dataSnapshot = event.snapshot;

      Map<String, dynamic> data =
          Map<String, dynamic>.from(dataSnapshot.value as Map);
      if (dataSnapshot.value != null) {
        // notifyListeners();
        print(dataSnapshot.value);

        data.forEach((key, values) {
          subTotalPrice += double.parse(values['itemPrice']);
          setSubTotal(subTotalPrice);
          notifyListeners();
        });
      } else {
        print('nooooa');
      }
    });

    notifyListeners();
  }

  Future<void> getSubTotalQty(String invoiceNo) async {
    print(invoiceNo);
    sellDataReference
        .child(invoiceNo)
        .child('items')
        .onValue
        .listen((event) async {
      setSubQty(0.0);
      var dataSnapshot = event.snapshot;

      Map<String, dynamic> data =
          Map<String, dynamic>.from(dataSnapshot.value as Map);
      if (dataSnapshot.value != null) {
        // notifyListeners();
        print(dataSnapshot.value);

        data.forEach((key, values) {
          subTotalQty += double.parse(values['itemQty']);
          setSubQty(subTotalQty);
          notifyListeners();
        });
      } else {
        print('nooooa');
      }
    });

    notifyListeners();
  }

  Future<void> uploadPurchaseProductData(
      String? key,
      String? invoiceNo,
      String? customerName,
      String? itemName,
      String? itemQty,
      String? itemPerPrice,
      String? cgstNo,
      String? sgstNo,
      String? igstNo,
      String? invoiceDate,
      String? itemPrice,
      String? roundOff,
      String? grandTotal) async {
    DatabaseReference newRef = databaseReference.push();
    String newKey = newRef.key!;
    productDataMethod = PurchaseProductDataMethod(
      keyString: newKey,
      itemkeyString: key,
      invoiceNo: invoiceNo,
      customerName: customerName,
      itemName: itemName,
      itemQty: itemQty,
      itemPerPrice: itemPerPrice,
      cgstNo: cgstNo,
      sgstNo: sgstNo,
      igstNo: igstNo,
      invoiceDate: invoiceDate,
      itemPrice: itemPrice,
      roundOff: roundOff,
      grandTotal: grandTotal,
    );
    Timer(Duration(seconds: 2), () async {
      await newRef.set(productDataMethod.toJson()).whenComplete(() {
        getItemStockQty(newKey, key!, invoiceDate!, itemQty!, true)
            .whenComplete(() {});
      });
    });
  }

  Future<void> uploadMolassesProductData(
    String? key,
    String? itemName,
    String? itemQty,
    String? invoiceDate,
  ) async {
    DatabaseReference newRef = databaseReference.push();
    String newKey = newRef.key!;
    molassesProductDataMethod = MolassesProductDataMethod(
      keyString: newKey,
      itemkeyString: key,
      itemName: itemName,
      itemQty: itemQty,
      invoiceDate: invoiceDate,
    );
    Timer(Duration(seconds: 2), () async {
      // await newRef.set(molassesProductDataMethod.toJson()).whenComplete(() {
      getItemStockQty(
        newKey,
        key!,
        invoiceDate!,
        itemQty!,
        false,
      ).whenComplete(() {});
      // });
    });
  }

  Future<void> uploadStockData(
    String? keyString,
    String? inventoryNo,
    String? itemName,
    String? itemQty,
    String? invoiceDate,
  ) async {
    DatabaseReference newRef = stockReference.push();
    String newKey = newRef.key!;
    stockProductDataMethod = StockProductDataMethod(
      itemKey: keyString,
      inventoryNo: inventoryNo,
      itemName: itemName,
      itemQty: itemQty,
      invoiceDate: invoiceDate,
    );
    await newRef.set(stockProductDataMethod.toJson()).whenComplete(() {
      // Timer(Duration(seconds: 2), () async {
      //   await newRef.set(productDataMethod.toJson()).whenComplete(() {
      //     getItemStockQty(newKey, keyString!, invoiceDate!, itemQty!, true)
      //         .whenComplete(() {});
      //   });
      // });
    });
  }

  Future<void> uploadSellsProductData(
      String? invoiceNo,
      String? customerName,
      String? cgstNo,
      String? sgstNo,
      String? igstNo,
      String? invoiceDate,
      String? itemPrice,
      String? roundOff,
      String? grandTotal) async {
    sellsProductDataMethod = SellsProductDataMethod(
      keyString: sellsKey,
      invoiceNo: invoiceNo,
      customerName: customerName,
      cgstNo: cgstNo,
      sgstNo: sgstNo,
      igstNo: igstNo,
      invoiceDate: invoiceDate,
      itemPrice: subTotalPrice.toString(),
      itemQty: subTotalQty.toString(),
      roundOff: roundOff,
      grandTotal: grandTotal,
    );
    Timer(Duration(seconds: 2), () async {
      await sellDataReference.child(sellsKey).update({
        'key': sellsProductDataMethod.keyString,
        'invoiceNo': sellsProductDataMethod.invoiceNo,
        'customerName': sellsProductDataMethod.customerName,
        'cgstNo': sellsProductDataMethod.cgstNo,
        'sgstNo': sellsProductDataMethod.sgstNo,
        'igstNo': sellsProductDataMethod.igstNo,
        'invoiceDate': sellsProductDataMethod.invoiceDate,
        'itemPrice': sellsProductDataMethod.itemPrice,
        'itemQty': sellsProductDataMethod.itemQty,
        'roundOff': sellsProductDataMethod.roundOff,
        'grandTotal': sellsProductDataMethod.grandTotal,
      }).whenComplete(() {
        getSellsKey('');
      });
      // });
    });
  }

  Future<void> getSellProductData() async {
    sellsProductData.clear();
    notifyListeners();
    sellDataReference.onValue.listen((event) async {
      sellsProductData.clear();
      notifyListeners();
      var dataSnapshot = event.snapshot;
      Map<String, dynamic> data =
          Map<String, dynamic>.from(dataSnapshot.value as Map);
      if (dataSnapshot.value != null) {
        data.forEach((key, values) async {
          sellDataReference
              .child(key)
              .child("items")
              .onValue
              .listen((event) async {
            sellItemNameList.clear();
            sellItemnPriceList.clear();
            sellItemnQtyList.clear();
            sellItemPerPriceList.clear();
            var dataSnapshot = event.snapshot;
            Map<String, dynamic> data =
                Map<String, dynamic>.from(dataSnapshot.value as Map);
            if (dataSnapshot.value != null) {
              data.forEach((key, values1) async {
                sellItemNameList.add(await values1['itemDesc']);
                sellItemnQtyList.add(await values1['itemQty']);
                sellItemnPriceList.add(await values1['itemPrice']);
                sellItemPerPriceList.add(await values1['itemPerPrice']);
                notifyListeners();
              });
              // }
              sellsProductData.add(SellsProductDataMethod(
                keyString: await values['keyString'],
                stockKey: await values['stockKey'],
                innerStockKey: await values['innerStockKey'],
                invoiceNo: await values['invoiceNo'],
                customerName: await values['customerName'],
                cgstNo: await values['cgstNo'],
                sgstNo: await values['sgstNo'],
                igstNo: await values['igstNo'],
                invoiceDate: await values['invoiceDate'],
                itemPrice: await values['itemPrice'],
                itemQty: await values['itemQty'],
                roundOff: await values['roundOff'],
                itemNameList: sellItemNameList,
                itemPriceList: sellItemnPriceList,
                itemQtyList: sellItemnQtyList,
                itemPerPriceList: sellItemPerPriceList,
                grandTotal: await values['grandTotal'],
              ));
              notifyListeners();
            }
          });
          sellsProductData.sort((a, b) {
            var adate = a.invoiceNo.toString();
            //  a["validUpto"]; //before -> var adate = a.expiry;
            var bdate =
                b.invoiceNo.toString(); //before -> var bdate = b.expiry;
            return adate.compareTo(
                bdate); //to get the order other way just switch `adate & bdate`
          });

          notifyListeners();
          notifyListeners();
        });
      }
    });
    notifyListeners();
  }

  Future<void> getPurchaseProductData() async {
    purchaseProductData.clear();
    databaseReference.onValue.listen((event) async {
      purchaseProductData.clear();
      DataSnapshot dataSnapshot = event.snapshot;
      Map<String, dynamic> data =
          Map<String, dynamic>.from(dataSnapshot.value as Map);
      if (dataSnapshot.value != null) {
        data.forEach((key, values) async {
          purchaseProductData.add(PurchaseProductDataMethod(
            keyString: await values['keyString'],
            itemkeyString: await values['itemkeyString'],
            stockKey: await values['stockKey'],
            innerStockKey: await values['innerStockKey'],
            invoiceNo: await values['invoiceNo'],
            customerName: await values['customerName'],
            itemName: await values['itemName'],
            itemQty: await values['itemQty'],
            itemPerPrice: await values['itemPerPrice'],
            cgstNo: await values['cgstNo'],
            sgstNo: await values['sgstNo'],
            igstNo: await values['igstNo'],
            invoiceDate: await values['invoiceDate'],
            itemPrice: await values['itemPrice'],
            roundOff: await values['roundOff'],
            grandTotal: await values['grandTotal'],
          ));
          purchaseProductData.sort((a, b) {
            var adate = a.invoiceNo.toString();
            //  a["validUpto"]; //before -> var adate = a.expiry;
            var bdate =
                b.invoiceNo.toString(); //before -> var bdate = b.expiry;
            return adate.compareTo(
                bdate); //to get the order other way just switch `adate & bdate`
          });

          notifyListeners();
          // notifyListeners();
        });
      }
    });
    // notifyListeners();
  }

  Future<void> setAddItemClicked(bool index) async {
    isAddItemClicked = index;
    notifyListeners();
  }

  Future<void> uploadItems(
    String? itemNo,
    String? itemPurchaseName,
    String? itemSellName,
  ) async {
    DatabaseReference newRef = itemReference.push();
    String newKey = newRef.key!;
    itemList = ItemList(
        itemKey: newKey,
        itemNo: itemNo,
        itemPurchasName: itemPurchaseName,
        itemSellName: itemSellName);
    await newRef.set(itemList.toJson());
  }

  Future<void> getItems(String itemFilter) async {
    itemsNameList.clear();
    itemNameStringList.clear();
    itemSellNameStringList.clear();
    itemReference.onValue.listen((event) async {
      itemsNameList.clear();
      itemNameStringList.clear();
      itemSellNameStringList.clear();
      var dataSnapshot = event.snapshot;
      Map<String, dynamic> data =
          Map<String, dynamic>.from(dataSnapshot.value as Map);
      if (dataSnapshot.value != null) {
        data.forEach((key, values) async {
          if (itemFilter == "0") {
            if (await values['itemPurchasName'] == 'Molasses') {
              itemNameStringList.add(await values['itemPurchasName']!);
              itemSellNameStringList.add(await values['itemSellName']!);
              itemsNameList.add(ItemList(
                itemKey: key.toString(),
                itemNo: await values['itemNo'],
                itemPurchasName: await values['itemPurchasName'],
                itemSellName: await values['itemSellName'],
              ));
              print(await values['itemKey']);
              notifyListeners();
            }
          } else if (itemFilter == "1") {
            if (await values['itemPurchasName'] != 'Molasses') {
              itemNameStringList.add(await values['itemPurchasName']!);
              itemSellNameStringList.add(await values['itemSellName']!);
              itemsNameList.add(ItemList(
                itemKey: key.toString(),
                itemNo: await values['itemNo'],
                itemPurchasName: await values['itemPurchasName'],
                itemSellName: await values['itemSellName'],
              ));
              print(await values['itemKey']);
              notifyListeners();
            } else {
              print('nonono');
            }
          } else {
            itemNameStringList.add(await values['itemPurchasName']!);
            itemSellNameStringList.add(await values['itemSellName']!);
            itemsNameList.add(ItemList(
              itemKey: key.toString(),
              itemNo: await values['itemNo'],
              itemPurchasName: await values['itemPurchasName'],
              itemSellName: await values['itemSellName'],
            ));
            print(await values['itemKey']);
            notifyListeners();
          }

          // }
          // });
          itemsNameList.sort((a, b) {
            var adate = a.itemNo.toString();
            //  a["validUpto"]; //before -> var adate = a.expiry;
            var bdate = b.itemNo.toString(); //before -> var bdate = b.expiry;
            return adate.compareTo(
                bdate); //to get the order other way just switch `adate & bdate`
          });

          notifyListeners();
        });
      }
    });
    notifyListeners();
  }

  Future<void> getStockList() async {
    // stockProductList.clear();

    stockReference.once().then((event) async {
      stockProductList.clear();

      var dataSnapshot = event.snapshot;
      Map<String, dynamic> data =
          Map<String, dynamic>.from(dataSnapshot.value! as Map);
      if (dataSnapshot.value != null) {
        data.forEach((key, values) async {
          print(data.values);
          stockProductList.add(StockProductDataMethod(
              itemKey: await values['itemKey'],
              stockKey: key.toString(),
              inventoryNo: await values['inventoryNo'],
              itemName: await values['itemName'],
              itemQty: await values['itemQty'],
              invoiceDate: await values['invoiceDate']));
          // print(await values['itemKey']);
          notifyListeners();
          // }
          // });
          stockProductList.sort((a, b) {
            var adate = a.inventoryNo.toString();
            //  a["validUpto"]; //before -> var adate = a.expiry;
            var bdate =
                b.inventoryNo.toString(); //before -> var bdate = b.expiry;
            return adate.compareTo(
                bdate); //to get the order other way just switch `adate & bdate`
          });
          notifyListeners();
          // notifyListeners();
        });
      }
    });
    notifyListeners();
  }

  Future<void> getItemStockQty(String purchaseKey, String itemKey, String date,
      String qty, bool isPurchase) async {
    // stockReference.equalTo(key).

    stockReference
        .orderByChild('itemKey')
        .equalTo(itemKey)
        .once()
        .then((event) async {
      var dataSnapshot = event.snapshot;

      Map<String, dynamic> data =
          Map<String, dynamic>.from(dataSnapshot.value as Map);
      if (dataSnapshot.value != null) {
        data.forEach((key, values) async {
          print("hahagagaga");
          stockDatabalanceString = await values['itemQty'];
          // print(stockDatabalanceString!);
          notifyListeners();
          // if (isUndo) {
          //   if (isMinus) {
          //     stockDatabalanceString = double.parse(stockDatabalanceString) -
          //         double.parse(qty.toString());
          //     notifyListeners();

          //     stockReference
          //         .child(key)
          //         .update({'itemQty': stockDatabalanceString.toString()});
          //     notifyListeners();
          //   } else {
          //     stockDatabalanceString = double.parse(stockDatabalanceString) +
          //         double.parse(qty.toString());
          //     notifyListeners();

          //     stockReference
          //         .child(key)
          //         .update({'itemQty': stockDatabalanceString.toString()});
          //     notifyListeners();
          //   }
          // }
          if (isPurchase) {
            stockDatabalanceString = double.parse(stockDatabalanceString) +
                double.parse(qty.toString());
            notifyListeners();

            stockReference
                .child(key)
                .update({'itemQty': stockDatabalanceString.toString()});
            notifyListeners();
            print("item Key : - " + qty);
            // print("Stock Key: - " + stockDatabalanceString);
            uploadStockRealData(
                purchaseKey,
                itemKey,
                key,
                values['itemName'].toString(),
                qty,
                stockDatabalanceString.toString(),
                date,
                isPurchase);
            // todayStockQty = todayStockQty ?? 0.0 + double.parse(qty);
            // todayStockClosingQty = todayStockClosingQty ??
            //     0.0 + double.parse(stockDatabalanceString);

          } else {
            stockDatabalanceString = double.parse(stockDatabalanceString) -
                double.parse(qty.toString());
            notifyListeners();
            await stockReference.child(key).update(
              {
                'itemQty': stockDatabalanceString.toString(),
              },
            );
            // todayStockQty = todayStockQty! + double.parse(qty);
            // notifyListeners();
            // todayStockClosingQty =
            //     todayStockClosingQty! + double.parse(stockDatabalanceString);
            // notifyListeners();
            stockReference
                .child(key)
                .update({'itemQty': stockDatabalanceString.toString()});
            notifyListeners();
            print("item Key : - " + itemKey);
            print("Stock Key: - " + key);
            uploadStockRealData(
                    purchaseKey,
                    itemKey,
                    key,
                    values['itemName'].toString(),
                    qty,
                    stockDatabalanceString.toString(),
                    date,
                    false)
                .whenComplete(() {
              // uploadTodayTotalStock(itemKey, key, todayStockQty.toString(),
              //     todayStockClosingQty.toString(), date, isPurchase.toString());
            });

            notifyListeners();
          }
        });
      }
    });

    notifyListeners();
  }

  Future<void> updateStockOnUndo(
      String stockKey, String qty, bool isPurchase) async {
    print(stockKey);
    stockReference.child(stockKey).once().then((event) async {
      var dataSnapshot = event.snapshot;

      if (dataSnapshot.value != null) {
        Map<String, dynamic> data =
            Map<String, dynamic>.from(dataSnapshot.value as Map);
        if (isPurchase) {
          stockDatabalanceString = data['itemQty'];
          stockDatabalanceString =
              double.parse(data['itemQty']) - double.parse(qty);
          stockReference
              .child(stockKey)
              .update({'itemQty': stockDatabalanceString.toString()});
        } else {
          stockDatabalanceString = data['itemQty'];
          stockDatabalanceString =
              double.parse(data['itemQty']) + double.parse(qty);
          stockReference
              .child(stockKey)
              .update({'itemQty': stockDatabalanceString.toString()});
        }
      }
    });
  }

  Future<void> uploadStockRealData(
    String originalKey,
    String itemkey,
    String stockKey,
    String itemName,
    String stockQty,
    String closingStockQty,
    String date,
    bool isPurchase,
  ) async {
    DatabaseReference newRef = stockReference.child(stockKey).push();
    String newKey = newRef.key!;
    String cbalance =
        closingStockQty; // stockAddMinusMethod = StockAddMinusMethod(
    //   itemKey: itemkey,
    //   stockKey: stockKey,
    //   itemName: itemName,
    //   stockQty: stockQty,
    //   closingStockQty: closingStockQty,
    //   date: date,
    //   isAdded: isPurchase,

    // );
    // print('hello' + closingStockQty);
    await newRef.update({
      'itemKey': itemkey,
      'stockKey': stockKey,
      'itemName': itemName,
      'stockQty': stockQty,
      'closingStockQty': closingStockQty,
      'date': date,
      'isAdded': isPurchase.toString()
    }).whenComplete(() async {
      if (isPurchase) {
        print("Original Key" + originalKey);
        print("Stock Key" + stockKey);
        print("Inner Stock Key" + newKey);
        await databaseReference
            .child(originalKey)
            .update({"stockKey": stockKey, "innerStockKey": newKey});
      } else {
        print("Sell Original Key" + originalKey);
        print("Sell Stock Key" + stockKey);
        print("Sell Inner Stock Key" + newKey);
        await sellDataReference
            .child(originalKey)
            .update({"stockKey": stockKey, "innerStockKey": newKey});
      }
    });
    // if (isPurchase) {
    //   getTodayQty(stockKey, date.replaceAll('/', '')).whenComplete(() {
    //     // todayStockQty =
    //     setTodayStockQty(todayStockQty + double.parse(stockQty))
    //         .whenComplete(() {
    //       print('StockQty ' + cbalance.toString());
    //       uploadTodayTotalStock(itemkey, stockKey, itemName,
    //           todayStockQty.toString(), cbalance, date, isPurchase.toString());
    //       notifyListeners();
    //     });
    //   });
    // } else {
    //   getTodayQty(stockKey, date.replaceAll('/', '')).whenComplete(() {
    //     setTodayStockQty(todayStockQty + double.parse(stockQty))
    //         .whenComplete(() {
    //       print('StockQty ' + cbalance.toString());
    //       uploadTodayTotalStock(itemkey, stockKey, itemName,
    //           todayStockQty.toString(), cbalance, date, isPurchase.toString());
    //       notifyListeners();
    //     });
    //   });
    // }
  }

  Future<void> getStockDetails(String key1) async {
    stockReference.child(key1).onValue.listen((event) async {
      stockAddList.clear();

      var dataSnapshot = event.snapshot;
      Map<String, dynamic> data =
          Map<String, dynamic>.from(dataSnapshot.value as Map);
      if (dataSnapshot.value != null) {
        data.forEach((key, values) async {
          if (key.toString().contains('-')) {
            print('Enterssssss');
            getStockDoubleDetails(key1);
          } else {
            print('Emptttyyy');
          }

          notifyListeners();
        });
      }
    });
    notifyListeners();
  }

  Future<void> getStockDoubleDetails(String key1) async {
    stockAddList.clear();
    stockReference.child(key1).onValue.listen((event) async {
      stockAddList.clear();
      var dataSnapshot = event.snapshot;
      Map<String, dynamic> data =
          Map<String, dynamic>.from(dataSnapshot.value as Map);
      if (dataSnapshot.value != null) {
        data.forEach((key, values) async {
          if (values['stockQty'] != null) {
            stockAddList.add(StockAddMinusMethod(
                itemKey: await values['itemKey'],
                stockKey: await values['stockKey'],
                itemName: await values['itemName'],
                stockQty: await values['stockQty'],
                closingStockQty: await values['closingStockQty'],
                date: await values['date'],
                isAdded: await values['isAdded'] ?? "true"));

            getTodayQty(await values['stockKey'],
                await values['date'].toString().replaceAll('/', ''));
          } else {
            print('dataa iss nulll');
          }
          print(await values);

          notifyListeners();
          stockAddList.sort((a, b) {
            var adate = a.date.toString();
            //  a["validUpto"]; //before -> var adate = a.expiry;
            var bdate = b.date.toString(); //before -> var bdate = b.expiry;
            return adate.compareTo(
                bdate); //to get the order other way just switch `adate & bdate`
          });
          notifyListeners();
          // });
        });
      }
    });
  }

  Future<void> uploadTodayTotalStock(
    String itemkey,
    String stockKey,
    String itemName,
    String stockQty,
    String closingStockQty,
    String date,
    String isAdded,
  ) async {
    DatabaseReference newRef = stockReference.child(stockKey);
    String newKey = newRef.key!;

    notifyListeners();
    await newRef.child(date.replaceAll('/', '')).update({
      'date': date,
      'itemName': itemName,
      'todatStockQty': todayStockQty.toString(),
      'todayClosingStockQty': closingStockQty,
      'isAdded': isAdded
    });
  }

  Future<void> getTodayQty(
    String stockKey,
    String date,
  ) async {
    // todayStockQty = 0.0;
    // setTodayStockQty(0.0);
    todayStockList.clear();
    notifyListeners();
    stockReference.child(stockKey).child(date).onValue.listen((event) async {
      // todayStockQty = 0.0;
      // notifyListeners();
      var dataSnapshot = event.snapshot;
      Map<String, dynamic> data =
          Map<String, dynamic>.from(dataSnapshot.value as Map);
      if (dataSnapshot.value != null) {
        print(dataSnapshot.value);
        setTodayStockQty(double.parse(data['todatStockQty']));
        data.forEach((key, values) async {
          // todayStockList.add(StockAddMinusMethod(
          //     itemKey: values['itemKey'],
          //     stockKey: values['stockKey'],
          //     itemName: values['itemName'],
          //     stockQty: values['stockQty'],
          //     closingStockQty: values['closingStockQty'],
          //     date: values['date'],
          //     isAdded: values['isAdded'] ?? "true"));
          // notifyListeners();
        });
      }
    });
  }
}
