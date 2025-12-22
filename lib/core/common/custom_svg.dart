import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvgImage extends StatelessWidget {
  final String image;
  final Color? color;
  final double? height;
  final double? width;

  const CustomSvgImage({
    super.key,
    required this.image,
    this.color,
    this.height = 24,
    this.width = 24,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      image,
      color: color,
      height: height,
      width: width,
      fit: BoxFit.fill,
    );
  }
}
