import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String title;
  final TextDecoration textDecoration;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow overflow;
  final double? letterSpacing;
  final double? wordSpacing;
  final double? lineHeight;
  final String? fontFamily;
  final List<Shadow>? shadows;
  final VoidCallback? fun;
  final Gradient? gradient;

  const CustomText( {
    super.key,
    required this.title,
    this.textDecoration = TextDecoration.none,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.normal,
    this.color = AppColors.black,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.clip,
    this.letterSpacing,
    this.wordSpacing,
    this.lineHeight,
    this.fontFamily,
    this.shadows,
    this.fun,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
   return Text(
      title,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : overflow,
      style: TextStyle(
        decoration: textDecoration,
        decorationColor: color, 
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: gradient == null ? color : null,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        height: lineHeight,
        fontFamily: fontFamily,
        shadows: shadows?.isNotEmpty == true ? shadows : null,
      ),
    );

   
  }
}
