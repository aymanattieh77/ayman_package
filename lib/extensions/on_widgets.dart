import 'package:flutter/material.dart';

extension SizedBoxExtension on num {
  SizedBox get sizedHeight => SizedBox(height: toDouble());

  SizedBox get sizedWidth => SizedBox(width: toDouble());
}

extension PaddingList on List<Widget> {
  List<Widget> paddingDirectional({
    double? top,
    double? bottom,
    double? start,
    double? end,
  }) {
    return map(
      (e) => Padding(
        padding: EdgeInsetsDirectional.only(
          top: top ?? 0,
          bottom: bottom ?? 0,
          start: start ?? 0,
          end: end ?? 0,
        ),
        child: e,
      ),
    ).toList();
  }

  List<Widget> paddingSymmetric({
    double? vertical,
    double? horizontal,
  }) {
    return map(
      (e) => Padding(
        padding: EdgeInsets.symmetric(
          vertical: vertical ?? 0,
          horizontal: horizontal ?? 0,
        ),
        child: e,
      ),
    ).toList();
  }

  List<Widget> paddingAll(double? padding) {
    return map(
      (e) => Padding(
        padding: EdgeInsets.all(padding ?? 0),
        child: e,
      ),
    ).toList();
  }
}
