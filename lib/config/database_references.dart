import 'package:firebase_database/firebase_database.dart';

DatabaseReference databaseReference =
    FirebaseDatabase.instance.ref('Purchase Product Data');

DatabaseReference productItemReference =
    FirebaseDatabase.instance.ref("purchaseItemList");

DatabaseReference sellDataReference =
    FirebaseDatabase.instance.ref("Sells Data");

DatabaseReference invoiceReference = FirebaseDatabase.instance.ref('Invoices');

DatabaseReference itemReference = FirebaseDatabase.instance.ref('Items');

DatabaseReference stockReference = FirebaseDatabase.instance.ref('Stocks');

DatabaseReference stortedStockReference =
    FirebaseDatabase.instance.ref('SortedStocks');
