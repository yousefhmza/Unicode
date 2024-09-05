import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'l10n_states.dart';
import '../l10n/l10n.dart';
import '../../../core/services/local/cache_client.dart';
import '../../../core/services/local/storage_keys.dart';

class L10nCubit extends Cubit<L10nStates> {
  final CacheClient _cacheClient;

  L10nCubit(this._cacheClient) : super(L10nInitialState());

  Locale? appLocale;

  void initLocale() {
    dynamic storedLocale = _cacheClient.get(StorageKeys.appLocale);
    if (storedLocale != null) {
      appLocale = Locale(storedLocale.toString());
    } else {
      final List<String> supportedLangCodes = L10n.supportedLocales.map((e) => e.languageCode).toList();
      final String deviceLangCode = Platform.localeName.substring(0, 2);
      if (!supportedLangCodes.contains(deviceLangCode)) {
        // Device locale not supported, Then set default locale to english
        appLocale = L10n.supportedLocales[0];
      } else {
        appLocale = Locale(deviceLangCode);
      }
    }
  }

  Future<void> setAppLocale(bool isArabic) async {
    if (isArabic) {
      appLocale = L10n.supportedLocales[1];
      await _cacheClient.save(StorageKeys.appLocale, "ar");
    } else {
      appLocale = L10n.supportedLocales[0];
      await _cacheClient.save(StorageKeys.appLocale, "en");
    }
    emit(L10nSetLangState());
  }
}
