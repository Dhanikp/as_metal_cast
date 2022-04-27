import 'package:firebase_database/firebase_database.dart';

class ItemList {
  String? itemKey;
  String? itemNo;
  String? itemPurchasName;
  String? itemSellName;

  ItemList(
      {this.itemKey, this.itemNo, this.itemPurchasName, this.itemSellName});

  ItemList.fromJson(Map data) {
    itemKey = data['itemKey'];
    itemNo = data['itemNo'];
    itemPurchasName = data['itemPurchasName'];
    itemSellName = data['itemSellName'];
  }
  Map toJson() => {
        "itemKey": itemKey,
        "itemNo": itemNo,
        "itemPurchasName": itemPurchasName,
        "itemSellName": itemSellName,
      };
}
