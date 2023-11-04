import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

// package : percent_indicator

class PercentLoading extends StatefulWidget {
  const PercentLoading(
      {super.key, this.onEnd, this.type = PrecentIndicatorType.circular});
  final void Function()? onEnd;
  final PrecentIndicatorType type;
  @override
  State<PercentLoading> createState() => _PercentLoadingState();
}

class _PercentLoadingState extends State<PercentLoading>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  void startAnimation() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();
  }

  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        if (_animation.value == 1.0) {
          widget.onEnd?.call();
        }

        switch (widget.type) {
          case PrecentIndicatorType.circular:
            return CircularPercentIndicator(
              percent: _animation.value,
              radius: 25,
              backgroundColor: Colors.blue,
              linearGradient: const LinearGradient(
                colors: [Colors.blue, Colors.blueGrey],
              ),

              center: Text(
                (_animation.value * 100).toStringAsFixed(1),
                style: const TextStyle(
                    fontWeight: FontWeight.w400, fontSize: 14.0),
              ),
              footer: const Text(
                "Sales this week",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15.0),
              ),
              circularStrokeCap: CircularStrokeCap.square,

              //progressColor: Colors.purple,
            );
          case PrecentIndicatorType.linear:
            return LinearPercentIndicator(
              percent: _animation.value,
              backgroundColor: Colors.grey,
              // linearGradient: const LinearGradient(
              //   colors: [Colors.blue, Colors.blueGrey],
              // ),

              center: Text(
                "${(_animation.value * 100).toStringAsFixed(1)}%",
                style: const TextStyle(
                    fontWeight: FontWeight.w400, fontSize: 14.0),
              ),
              lineHeight: 20.0,

              barRadius: const Radius.circular(15),

              progressColor: Colors.green,
            );
        }
      },
    );
  }
}

enum PrecentIndicatorType { linear, circular }
