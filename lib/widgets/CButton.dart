import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CButton extends StatelessWidget {
  String text;
  Function? onTap;
  Color? color;

  CButton(this.text, {this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap!(),
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(
          vertical: 10,
        ),
        decoration: BoxDecoration(
            color: color ?? Colors.indigoAccent,
            border: Border.all(style: BorderStyle.none),
            borderRadius: BorderRadius.circular(25)),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(fontSize: 14, color: Colors.white),
        ),
      ),
    );
  }
}
