import 'package:flutter/material.dart';

class FadingCirclesLoader extends StatefulWidget {
  const FadingCirclesLoader({super.key});

  @override
  State<FadingCirclesLoader> createState() => _FadingCirclesLoaderState();
}

class _FadingCirclesLoaderState extends State<FadingCirclesLoader>
    with TickerProviderStateMixin {
  late final AnimationController animationController;
  late Animation<double> animation;

  initalizeAnimation() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = Tween<double>(begin: 1, end: 0.0).animate(animationController);

    animationController.repeat(reverse: true);
  }

  @override
  void initState() {
    super.initState();
    initalizeAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 10,
        child: Container(
          width: MediaQuery.sizeOf(context).width * 0.32,
          height: MediaQuery.sizeOf(context).width * 0.32,
          decoration: BoxDecoration(
              color: Colors.black87, borderRadius: BorderRadius.circular(14)),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3.0),
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: Colors.white10,
                      shape: BoxShape.circle,
                    ),
                    child: FadeTransition(
                      opacity: animation,
                      child: Container(
                        width: 23,
                        height: 23,
                        decoration: const BoxDecoration(
                          color: Colors.white70,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
