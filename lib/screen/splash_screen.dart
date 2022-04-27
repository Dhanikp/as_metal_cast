import 'dart:async';

import 'package:as_metal_cast/config/color_file.dart';
import 'package:as_metal_cast/config/route_names.dart';
import 'package:as_metal_cast/methods/snackbar.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../config/size_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, PageBuilderRoute);
      print('Already Logged In...');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: AnimatedOpacity(
              opacity: 1.0,
              duration: Duration(seconds: 1),
              child: Container(
                alignment: Alignment.center,
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 9.58 * SizeConfig.heightMultiplier),
                  child: const Image(
                    image: AssetImage('assets/images/logo.png'),
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            width: 50,
            height: 50,
            color: white,
            child: Lottie.asset(
              'assets/images/loader.json',
              width: 100,
              height: 100,
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            height: 9.58 * SizeConfig.heightMultiplier,
            color: Colors.white,
            child: Column(
              children: [
                Text(
                  'Version 1.0.0',
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: greyTextColor),
                ),
                SizedBox(
                  height: 0.27 * SizeConfig.heightMultiplier,
                ),
                Text(
                  'A.S Metal Cast',
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: blackVariable),
                ),
                // Text(
                //   'Powered By DRPY DEV',
                //   style: GoogleFonts.poppins(
                //       fontSize: 12,
                //       fontWeight: FontWeight.w600,
                //       color: primaryColor),
                // ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
