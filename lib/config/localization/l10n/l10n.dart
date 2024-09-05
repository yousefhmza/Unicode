import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class L10n {
  static final List<Locale> supportedLocales = [
    const Locale("en", ""),
    const Locale("ar", ""),
  ];

  static const List<LocalizationsDelegate> localizationDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static AppLocalizations tr(BuildContext context) => AppLocalizations.of(context)!;

  static String langCode(BuildContext context) => Localizations.localeOf(context).languageCode == 'ar' ? "ar" : "en";

  static String currentLanguageCode(BuildContext context) => Localizations.localeOf(context).languageCode;

  static bool isAr(BuildContext context) => Localizations.localeOf(context).languageCode == 'ar';
}
