import 'package:as_metal_cast/config/route_names.dart';
import 'package:as_metal_cast/screen/purchases.dart';
import 'package:as_metal_cast/screen/sell.dart';
import 'package:as_metal_cast/screen/splash_screen.dart';
import 'package:as_metal_cast/screen/stock.dart';
import 'package:as_metal_cast/widgets/add_molasses.dart';
import 'package:as_metal_cast/widgets/add_purchase.dart';
import 'package:as_metal_cast/widgets/add_sells.dart';
import 'package:as_metal_cast/widgets/add_stock.dart';
import 'package:as_metal_cast/widgets/uploadItemList.dart';
// import 'package:as_metal_cast/screens/login_page.dart';
// import 'package:as_metal_cast/screens/page_builder.dart';
// import 'package:as_metal_cast/screens/receipt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../screen/dashboard.dart';
import '../screen/page_builder.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Splash:
      return _getPageRoute(SplashScreen(), settings);

    case PageBuilderRoute:
      return _getPageRoute(PageBuilder(), settings);

    case DashboardRoute:
      return _getPageRoute(Dashboard(), settings);

    case PurchaseRoute:
      return _getPageRoute(PurchasePage(), settings);

    case SellRoute:
      return _getPageRoute(SellPage(), settings);

    case StockRoute:
      return _getPageRoute(StockPage(), settings);

    case AddItemPageRoute:
      return _getPageRoute(UploadItemPage(), settings);

    case AddPurchaseRoute:
      return _getPageRoute(AddPurchases(), settings);

    case AddSellRoute:
      return _getPageRoute(AddSells(), settings);
    case AddStockPage:
      return _getPageRoute(AddStock(), settings);

    case AddMolassesPage:
      return _getPageRoute(AddMolasses(), settings);

    default:
      return _getPageRoute(Dashboard(), settings);
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, routeName: settings.name!);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget? child;
  final String? routeName;
  _FadeRoute({this.child, this.routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child!,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
