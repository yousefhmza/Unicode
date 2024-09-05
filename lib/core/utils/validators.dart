import 'package:unicode/config/navigation/navigation.dart';

import '../../config/localization/l10n/l10n.dart';
import '../extensions/non_null_extensions.dart';

class Validators {
  static String? emailValidator(String? input) {
    return !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(input.orEmpty)
        ? L10n.tr(NavigationService.navigationKey.currentContext!).emailValidator
        : null;
  }

  static String? passwordValidator(String? input) {
    return !RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$").hasMatch(input.orEmpty)
        ? L10n.tr(NavigationService.navigationKey.currentContext!).passwordValidator
        : null;
  }

  static String? notEmptyValidator(String? input) {
    return input.orEmpty.isEmpty ? L10n.tr(NavigationService.navigationKey.currentContext!).requiredValidator : null;
  }
}
