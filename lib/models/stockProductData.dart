class StockProductDataMethod {
  String? itemKey;
  String? stockKey;
  String? inventoryNo;
  String? itemName;
  String? itemQty;
  String? invoiceDate;

  StockProductDataMethod({
    this.itemKey,
    this.stockKey,
    this.inventoryNo,
    this.itemName,
    this.itemQty,
    this.invoiceDate,
  });

  Map toJson() => {
        'itemKey': itemKey,
        'stockKey': stockKey,
        'inventoryNo': inventoryNo,
        'itemName': itemName,
        'itemQty': itemQty,
        'invoiceDate': invoiceDate,
      };
}
