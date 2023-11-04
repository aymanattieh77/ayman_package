import 'package:flutter/material.dart';

extension MediaQueryExtension on BuildContext {
  double get fullWidth => MediaQuery.sizeOf(this).width;

  double get fullHeight => MediaQuery.sizeOf(this).height;

  double setWidth(double value) {
    /// value must between 0.0 -1.0
    return MediaQuery.sizeOf(this).width * value;
  }

  double setHeight(double value) {
    /// value must between 0.0 -1.0
    return MediaQuery.sizeOf(this).height * value;
  }

  Orientation get orientation => MediaQuery.orientationOf(this);

  double get paddingHorizontal => MediaQuery.of(this).viewInsets.horizontal;

  double get paddingVertical => MediaQuery.of(this).viewInsets.vertical;
}
