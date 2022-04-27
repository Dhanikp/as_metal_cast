import 'package:as_metal_cast/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'DataHandler/appData.dart';
import 'config/router.dart' as router;
import 'config/size_config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<AppData>(create: (context) {
                  return AppData();
                }),
              ],
              child: const MaterialApp(
                debugShowCheckedModeBanner: false,
                // theme: Theme
                home: SplashScreen(),
                localizationsDelegates: [
                  GlobalWidgetsLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  MonthYearPickerLocalizations.delegate,
                ],
                // home: ProffesionalDetails(),
                onGenerateRoute: router.generateRoute,
              ),
            );
          },
        );
      },
    );
  }
  // }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("Firebase Connected");
    });
  }
}

  //  MyApp({Key? key}) : super(key: key);

  



