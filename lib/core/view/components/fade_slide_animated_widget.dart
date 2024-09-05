import 'package:flutter/material.dart';

import '../../resources/resources.dart';

class FadeSlideAnimatedWidget extends StatefulWidget {
  final Offset beginOffset;
  final Offset endOffset;
  final Curve animationCurve;
  final Duration delay;
  final Duration animationDuration;
  final Widget child;

  const FadeSlideAnimatedWidget({
    required this.child,
    this.beginOffset = const Offset(0.0, 0.03),
    this.endOffset = const Offset(0.0, 0.0),
    this.animationCurve = Curves.easeInOut,
    this.animationDuration = Time.t700ms,
    this.delay = Time.t0,
    super.key,
  });

  @override
  State<FadeSlideAnimatedWidget> createState() => _FadeSlideAnimatedWidgetState();
}

class _FadeSlideAnimatedWidgetState extends State<FadeSlideAnimatedWidget> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<Offset> offsetAnimation;
  late final Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: widget.animationDuration);
    offsetAnimation = Tween<Offset>(begin: widget.beginOffset, end: widget.endOffset).animate(
      CurvedAnimation(parent: animationController, curve: widget.animationCurve),
    );
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: widget.animationCurve),
    );
    Future.delayed(widget.delay, () {
      animationController.forward();
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: offsetAnimation,
      child: FadeTransition(
        opacity: fadeAnimation,
        child: widget.child,
      ),
    );
  }
}
