import 'package:flutter/material.dart';

import 'package:as_metal_cast/widgets/custom_snack_bar.dart';
import '../widgets/custom_snack_bar.dart';

var redVariable = Colors.red[600];
var blackVariable = Colors.grey[800];
var greenVariable = Colors.green[800];

Color? selectColor(int i) {
  if (i == 0) {
    return redVariable;
  } else if (i == 1) {
    return blackVariable;
  } else if (i == 2) {
    return greenVariable;
  } else {
    return redVariable;
  }
}

showSnackBar(BuildContext context, String title, int i) {
  Scaffold.of(context).showSnackBar(SnackBar(
    backgroundColor: selectColor(i),
    content: CustomSnackBar(title, Icons.error_outline_rounded),
    behavior: SnackBarBehavior.floating,
  ));
}

showSucessSnackBar(BuildContext context, String title, int i) {
  Scaffold.of(context).showSnackBar(SnackBar(
    backgroundColor: selectColor(i),
    content: CustomSnackBar(title, Icons.check_circle_outline_rounded),
    behavior: SnackBarBehavior.floating,
  ));
}
