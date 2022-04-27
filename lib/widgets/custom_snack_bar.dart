import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/color_file.dart';
import '../config/size_config.dart';


// ignore: must_be_immutable
class CustomSnackBar extends StatelessWidget {
  String title;
  IconData icon;
  bool isVisible = true;

  CustomSnackBar(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: white,
          ),
          SizedBox(
            width: 4.8 * SizeConfig.widthMultiplier,
          ),
          Flexible(
              child: Text(title,
                  style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.white),
                  textAlign: TextAlign.left)),
        ],
      ),
    );
  }
}
