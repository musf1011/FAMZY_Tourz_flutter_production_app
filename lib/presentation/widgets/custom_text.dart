import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final double? height;
  final TextAlign? align;
  final int? maxlines;
  final bool underline;
  const CustomText({
    super.key,
    required this.text,
    this.maxlines,
    this.fontFamily = 'Poppins',
    this.height,
    this.fontWeight = FontWeight.w400,
    this.fontSize,
    this.color = Colors.white,
    this.align = .start,
    this.underline = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        // fontSize: SizeUtils.fontSize(fontSize ?? 16),
        color: color,
        height: height,
        decoration: underline ? TextDecoration.underline : null,
        // decorationColor: greyText,
        decorationThickness: 2.0,
        decorationStyle: TextDecorationStyle.solid,
      ),
      textAlign: align,
      maxLines: maxlines,
      overflow: maxlines != null ? TextOverflow.ellipsis : null,
    );
  }
}
