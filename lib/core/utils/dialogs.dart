import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resources/resources.dart';
import '../view/views.dart';
import 'constants.dart';

class AppDialogs {
  static Future<T?> showAppDialog<T>(BuildContext context, {bool barrierDismissible = true, required Widget dialog}) {
    return Platform.isIOS
        ? showCupertinoDialog(context: context, barrierDismissible: barrierDismissible, builder: (context) => dialog)
        : showDialog(context: context, barrierDismissible: barrierDismissible, builder: (context) => dialog);
  }

  static void showAnimatedDialog(BuildContext context, Widget dialog, {bool dismissible = true}) {
    showGeneralDialog(
      context: context,
      barrierLabel: Constants.empty,
      barrierDismissible: dismissible,
      pageBuilder: (context, animation1, animation2) => dialog,
      transitionDuration: Time.t500ms,
      transitionBuilder: (context, a1, a2, widget) {
        final Animation<double> turns = Tween<double>(begin: math.pi, end: 2.0 * math.pi)
            .animate(CurvedAnimation(parent: a1, curve: const Interval(0.0, 1.0, curve: Curves.linear)));
        final Animation<double> fadeAnimation = Tween<double>(begin: 0.0, end: 1.0)
            .animate(CurvedAnimation(parent: a1, curve: const Interval(0.5, 1.0, curve: Curves.elasticOut)));
        final Animation<Offset> slideAnimation = Tween<Offset>(begin: const Offset(0, 0.05), end: const Offset(0, 0))
            .animate(CurvedAnimation(parent: a1, curve: const Interval(0.5, 1.0, curve: Curves.easeInOut)));
        return Transform(
          alignment: const FractionalOffset(0.5, 0.5),
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0006)
            ..rotateY(turns.value),
          child: FadeTransition(
            opacity: fadeAnimation,
            child: SlideTransition(position: slideAnimation, child: widget),
          ),
        );
      },
    );
  }

  static Future showLoadingDialog(BuildContext context, {bool barrierDismissible = false}) {
    return Platform.isIOS
        ? showCupertinoDialog(
            context: context,
            barrierDismissible: barrierDismissible,
            builder: (context) => const LoadingDialog(),
          )
        : showDialog(
            context: context,
            barrierDismissible: barrierDismissible,
            builder: (context) => const LoadingDialog(),
          );
  }
}
