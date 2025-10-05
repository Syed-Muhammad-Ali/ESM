import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  final Widget? child;
  final double? cir;
  final bool? borders;
  final Color? borderCol;
  final BoxShape? shape;
  final VoidCallback? fun;
  final bool? shadow;
  final DecorationImage? imageDecoration;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const CustomContainer({
    super.key,
    this.height,
    this.width,
    this.child,
    this.color,
    this.borders = false,
    this.cir = 1,
    this.borderCol = Colors.grey,
    this.fun,
    this.shadow,
    this.imageDecoration,
    this.margin,
    this.padding,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    final boxShape = shape ?? BoxShape.rectangle;

    return GestureDetector(
      onTap: fun,
      child: Container(
        height: height,
        width: width,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: color,
          shape: boxShape,
          border: borders == true ? Border.all(color: borderCol!) : null,
          borderRadius:
              boxShape == BoxShape.rectangle
                  ? BorderRadius.circular(cir!)
                  : null, 
          image: imageDecoration,
        ),
        child: Center(child: child),
      ),
    );
  }
}
