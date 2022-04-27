class StockAddMinusMethod {
  String? itemKey;
  String? stockKey;
  String? itemName;
  String? stockQty;
  String? closingStockQty;
  String? date;
  String? isAdded;

  StockAddMinusMethod({
    this.itemKey,
    this.stockKey,
    this.itemName,
    this.stockQty,
    this.closingStockQty,
    this.date,
    this.isAdded,
  });

  Map toJson() => {
        'itemKey': itemKey,
        'stockKey': stockKey,
        'itemName': itemName,
        'stockQty': stockQty,
        'closingStockQty': closingStockQty,
        'date': date,
        'isAdded': isAdded
      };
}
