import 'package:flutter/material.dart';

class CircluarLoading extends StatelessWidget {
  const CircluarLoading(
      {super.key, this.color = Colors.blueAccent, this.strokeWidth = 4.0});
  final Color color;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: strokeWidth,
        // backgroundColor: Colors.grey,
      ),
    );
  }
}
