class MolassesProductDataMethod {
  String? keyString;
  String? itemkeyString;

  String? itemName;
  String? itemQty;
  String? invoiceDate;

  MolassesProductDataMethod({
    this.keyString,
    this.itemkeyString,
    this.itemName,
    this.itemQty,
    this.invoiceDate,
  });

  Map toJson() => {
        'keyString': keyString,
        'itemkeyString': itemkeyString,
        'itemName': itemName,
        'itemQty': itemQty,
        'invoiceDate': invoiceDate,
      };
}
