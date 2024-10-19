import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String? title;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final double? height;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  const CustomText({
    super.key,
    this.title,
    this.size,
    this.color,
    this.weight,
    this.height,
    this.textAlign,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(title!,
        textAlign: textAlign ?? TextAlign.left,
        style: GoogleFonts.roboto(
            textStyle: TextStyle(
          color: color ?? Colors.black,
          fontSize: size,
          fontWeight: weight ?? FontWeight.normal,
          overflow: overflow,
        )));
  }
}
