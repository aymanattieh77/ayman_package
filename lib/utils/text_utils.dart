import 'package:flutter/material.dart';

class TextUtils extends StatelessWidget {
  const TextUtils(
      {super.key,
      required this.text,
      this.fontSize = 16.0,
      this.color,
      this.fontWeight = FontWeight.normal,
      this.textAlign = TextAlign.start,
      this.maxlines,
      this.softWrap,
      this.decoration,
      this.tr = true});
  final String text;
  final double fontSize;
  final Color? color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final int? maxlines;
  final bool? softWrap;
  final bool tr;
  final TextDecoration? decoration;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      // textDirection: context.isRTL ? TextDirection.rtl : TextDirection.ltr,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        decoration: decoration,
        // fontFamily: _getFontFamily(context)
      ),
      textAlign: textAlign,
      maxLines: maxlines ?? 3,
      overflow: TextOverflow.ellipsis,
      softWrap: softWrap ?? true,
    );
  }

  // String _getFontFamily(BuildContext context) {
  //   return context.locale == arabicLocale
  //       ? AppConstants.fontFamilyAr
  //       : AppConstants.fontFamilyEn;
  // }
}
