import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resources/resources.dart';
import '../view/views.dart';

class AppSheets {
  static Future<T?> showBottomSheet<T>(
    BuildContext context, {
    bool showCupertino = false,
    bool isDismissible = true,
    required Widget child,
  }) {
    return showCupertino
        ? showCupertinoModalPopup<T>(context: context, builder: (context) => child)
        : showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            isDismissible: isDismissible,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.s16))),
            constraints:
                BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8, minWidth: double.maxFinite),
            builder: (context) => AppBottomSheet(child: child),
          );
  }
}
