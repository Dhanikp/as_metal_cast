class SellsProductDataMethod {
  String? keyString;
  String? stockKey;
  String? innerStockKey;
  String? invoiceNo;
  String? customerName;
  String? cgstNo;
  String? sgstNo;
  String? igstNo;
  String? invoiceDate;
  String? itemPrice;
  String? itemQty;
  String? roundOff;
  List<String>? itemNameList;
  List<String>? itemPriceList;
  List<String>? itemQtyList;
  List<String>? itemPerPriceList;
  String? grandTotal;

  SellsProductDataMethod({
    this.keyString,
    this.stockKey,
    this.innerStockKey,
    this.invoiceNo,
    this.customerName,
    this.cgstNo,
    this.sgstNo,
    this.igstNo,
    this.invoiceDate,
    this.itemPrice,
    this.itemQty,
    this.roundOff,
    this.itemNameList,
    this.itemPriceList,
    this.itemQtyList,
    this.itemPerPriceList,
    this.grandTotal,
  });

  Map toJson() => {
        'key': keyString,
        'stockKey': stockKey,
        'innerStockKey': innerStockKey,
        'invoiceNo': invoiceNo,
        'customerName': customerName,
        'cgstNo': cgstNo,
        'sgstNo': sgstNo,
        'igstNo': igstNo,
        'invoiceDate': invoiceDate,
        'itemPrice': itemPrice,
        'itemQty': itemQty,
        'roundOff': roundOff,
        'grandTotal': grandTotal,
      };
}
