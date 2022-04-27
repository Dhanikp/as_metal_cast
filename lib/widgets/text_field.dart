import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/color_file.dart';

// ignore: must_be_immutable
class EditText extends StatefulWidget {
  String hintName;
  TextInputType inputType;
  int minLine;
  int maxLine;
  TextEditingController textEditingController;
  double heightOfEditText;
  bool secureText = false;
  double radius = 5.0;
  EditText(
      this.hintName,
      this.inputType,
      this.secureText,
      this.heightOfEditText,
      this.minLine,
      this.maxLine,
      this.textEditingController,
      this.radius);

  @override
  _EditTextState createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        width: MediaQuery.of(context).size.width,
        height: widget.heightOfEditText,
        decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(widget.radius),
            border: Border.all(color: Color.fromARGB(255, 224, 224, 224))),
        child: Padding(
          padding: EdgeInsets.only(left: 10),
          child: TextField(
              controller: widget.textEditingController,
              minLines: widget.minLine,
              maxLines: widget.maxLine,
              obscureText: widget.secureText,
              keyboardType: widget.inputType,
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: editTextColor,
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: widget.hintName,
                // labelText: widget.labelName,
                // labelStyle: GoogleFonts.poppins(
                //     fontSize: 14,
                //     color: greyTextColor1,
                //     height: 1,
                //     fontWeight: FontWeight.w600),
                hintStyle: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w400),
              )),
        ));
  }
}
