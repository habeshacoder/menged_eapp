import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class PrimaryText extends StatelessWidget {
  final double size;
  final FontWeight? fontWeight;
  final Color color;
  final String text;
  final double height;

  const PrimaryText({
    required this.text,
    this.fontWeight,
    this.color = AppColors.secondary,
    this.size = 20,
    this.height = 1.3,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        height: height,
        fontFamily: 'Poppins',
        fontSize: size,
        fontWeight: fontWeight,
      ),
    );
  }
}

class SecondaryText extends StatelessWidget {
  final double size;
  final FontWeight? fontWeight;
  final Color color;
  final String text;
  final double height;

  const SecondaryText({
    required this.text,
    this.fontWeight,
    this.color = AppColors.white,
    this.size = 20,
    this.height = 1.3,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        height: height,
        fontFamily: 'Poppins',
        fontSize: size,
        fontWeight: fontWeight,
      ),
    );
  }
}

class TitleFont extends StatelessWidget {
  final double? size;
  final List<Shadow>? shadows;
  final FontWeight? fontWeight;
  final Color? color;
  final String text;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? align;
  // final double height;

  const TitleFont({
    required this.text,
    this.maxLines,
    this.overflow,
    this.fontWeight,
    this.color,
    this.size,
    this.shadows,
    this.align,
    // this.height = 1.3,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      style: GoogleFonts.ubuntu(fontSize: size, color: color, shadows: shadows),
    );
  }
}

class Poppins extends StatelessWidget {
  final double? size;
  final List<Shadow>? shadows;
  final FontWeight? fontWeight;
  final Color? color;
  final String text;
  final int? maxLines;
  final TextOverflow? overflow;
  // final double height;

  const Poppins({
    required this.text,
    this.maxLines,
    this.overflow,
    this.fontWeight,
    this.color,
    this.size,
    this.shadows,
    // this.height = 1.3,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      style:
          GoogleFonts.poppins(fontSize: size, color: color, shadows: shadows),
    );
  }
}

class DescriptionFont extends StatelessWidget {
  final double? size;
  final List<Shadow>? shadows;
  final FontWeight? fontWeight;
  final Color? color;
  final String text;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? align;
  // final double height;

  const DescriptionFont({
    required this.text,
    this.maxLines,
    this.overflow,
    this.fontWeight,
    this.color,
    this.size,
    this.shadows,
    this.align,
    // this.height = 1.3,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: maxLines,
        overflow: overflow,
        style: GoogleFonts.aBeeZee(
            fontSize: size, color: color, shadows: shadows));
  }
}

class InfoFont extends StatelessWidget {
  final double? size;
  final List<Shadow>? shadows;
  final FontWeight? fontWeight;
  final Color? color;
  final String text;
  final int? maxLines;
  final TextOverflow? overflow;
  // final double height;

  const InfoFont({
    required this.text,
    this.maxLines,
    this.overflow,
    this.fontWeight,
    this.color,
    this.size,
    this.shadows,
    // this.height = 1.3,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      style: GoogleFonts.ebGaramond(
          fontSize: size, color: color, shadows: shadows),
    );
  }
}

class Info2Font extends StatelessWidget {
  final double? size;
  final List<Shadow>? shadows;
  final FontWeight? fontWeight;
  final Color? color;
  final String text;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontStyle? fontStyle;
  // final double height;

  const Info2Font({
    required this.text,
    this.maxLines,
    this.overflow,
    this.fontWeight,
    this.color,
    this.size,
    this.shadows,
    this.fontStyle,
    // this.height = 1.3,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: maxLines,
        overflow: overflow,
        style: GoogleFonts.alegreya(
            fontSize: size,
            color: color,
            shadows: shadows,
            fontStyle: fontStyle));
  }
}

class Info3Font extends StatelessWidget {
  final double? size;
  final List<Shadow>? shadows;
  final FontWeight? fontWeight;
  final Color? color;
  final String text;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontStyle? fontStyle;
  // final double height;

  const Info3Font({
    required this.text,
    this.maxLines,
    this.overflow,
    this.fontWeight,
    this.color,
    this.size,
    this.shadows,
    this.fontStyle,
    // this.height = 1.3,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: maxLines,
        overflow: overflow,
        style: GoogleFonts.merienda(
            fontSize: size,
            color: color,
            shadows: shadows,
            fontStyle: fontStyle));
  }
}

class Info4Font extends StatelessWidget {
  final double? size;
  final List<Shadow>? shadows;
  final FontWeight? fontWeight;
  final Color? color;
  final String text;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontStyle? fontStyle;
  // final double height;

  const Info4Font({
    required this.text,
    this.maxLines,
    this.overflow,
    this.fontWeight,
    this.color,
    this.size,
    this.shadows,
    this.fontStyle,
    // this.height = 1.3,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: maxLines,
        overflow: overflow,
        style: GoogleFonts.lusitana(
            fontSize: size,
            color: color,
            shadows: shadows,
            fontStyle: fontStyle));
  }
}

class QuickSand extends StatelessWidget {
  final double? size;
  final List<Shadow>? shadows;
  final FontWeight? fontWeight;
  final Color? color;
  final String text;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontStyle? fontStyle;
  // final double height;

  const QuickSand({
    required this.text,
    this.maxLines,
    this.overflow,
    this.fontWeight,
    this.color,
    this.size,
    this.shadows,
    this.fontStyle,
    // this.height = 1.3,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: maxLines,
        overflow: overflow,
        style: GoogleFonts.quicksand(
            fontSize: size,
            color: color,
            shadows: shadows,
            fontStyle: fontStyle));
  }
}
