class PurchaseProductDataMethod {
  String? keyString;
  String? itemkeyString;
  String? stockKey;
  String? innerStockKey;
  String? invoiceNo;
  String? customerName;
  String? itemName;
  String? itemQty;
  String? itemPerPrice;
  String? cgstNo;
  String? sgstNo;
  String? igstNo;
  String? invoiceDate;
  String? itemPrice;
  String? roundOff;

  String? grandTotal;

  PurchaseProductDataMethod({
    this.keyString,
    this.itemkeyString,
    this.stockKey,
    this.innerStockKey,
    this.invoiceNo,
    this.customerName,
    this.itemName,
    this.itemQty,
    this.itemPerPrice,
    this.cgstNo,
    this.sgstNo,
    this.igstNo,
    this.invoiceDate,
    this.itemPrice,
    this.roundOff,
    this.grandTotal,
  });

  Map toJson() => {
        'keyString': keyString,
        'itemkeyString': itemkeyString,
        'stockKey': stockKey,
        'innerStockKey': innerStockKey,
        'invoiceNo': invoiceNo,
        'customerName': customerName,
        'itemName': itemName,
        'itemQty': itemQty,
        'itemPerPrice': itemPerPrice,
        'cgstNo': cgstNo,
        'sgstNo': sgstNo,
        'igstNo': igstNo,
        'invoiceDate': invoiceDate,
        'itemPrice': itemPrice,
        'roundOff': roundOff,
        'grandTotal': grandTotal,
      };
}
