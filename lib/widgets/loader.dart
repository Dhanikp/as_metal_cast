import 'package:as_metal_cast/methods/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../config/color_file.dart';

class Loader extends StatefulWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white.withOpacity(0.1),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.only(bottom: 10),
                width: 80,
                height: 80,
                child: Lottie.asset('assets/images/loader.json'),
              ),
            ]));
  }
}
