import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  const AppText({
    super.key,
    required this.data,
    this.fontSize = 16,
    this.textScaleFactor = 0.9,
    this.color,
    this.fontWeight,
    this.maxLines = 1, // ✅ default 1
    this.overflow = TextOverflow.ellipsis, // ✅ default ellipsis
    this.textAlign,
    this.height,
    this.softWrap,
    this.letterSpacing,
    this.style,
  });

  final String data;
  final double? fontSize;
  final double textScaleFactor;
  final Color? color;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final double? height;
  final double? letterSpacing;
  final bool? softWrap;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      softWrap: softWrap,
      style:
          style ??
          GoogleFonts.jost(
            // ✅ Default Google Poppins font
            height: height,
            fontSize: fontSize,
            color: color ?? Theme.of(context).textTheme.displaySmall?.color,
            letterSpacing: letterSpacing,
            fontWeight: fontWeight, // যদি তোমার custom fontFamily লাগে
          ),
      textScaler: TextScaler.linear(textScaleFactor),
    );
  }
}
