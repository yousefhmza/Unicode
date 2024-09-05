import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicode/core/extensions/num_extensions.dart';
import 'package:unicode/core/view/views.dart';

import '../../core/resources/resources.dart';
import '../localization/cubit/l10n_cubit.dart';

ThemeData lightTheme(BuildContext context) {
  final L10nCubit l10nCubit = BlocProvider.of<L10nCubit>(context);
  final isAr = l10nCubit.appLocale == null
      ? Platform.localeName.substring(0, 2) == "ar"
      : l10nCubit.appLocale!.languageCode == "ar";

  return ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppColors.white,
    splashColor: AppColors.transparent,

    colorScheme: const ColorScheme.light().copyWith(primary: AppColors.primary, surfaceTint: AppColors.white),

    /// Bottom sheet
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: AppColors.white),

    /// Appbar theme
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      elevation: AppSize.s0,
      scrolledUnderElevation: AppSize.s0,
      iconTheme: IconThemeData(color: AppColors.black),
    ),

    /// Bnb theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.black,
      unselectedItemColor: AppColors.grey500,
      unselectedIconTheme:  IconThemeData(size: AppSize.s24.sp),
      selectedIconTheme:  IconThemeData(size: AppSize.s24.sp),
      selectedLabelStyle: TextStyle(
        fontSize: FontSize.s12.sp,
        fontFamily: isAr ? FontConstants.arabicFontFamily : FontConstants.englishFontFamily,
        fontWeight: FontWeightManager.semiBold,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: FontSize.s12.sp,
        fontFamily: isAr ? FontConstants.arabicFontFamily : FontConstants.englishFontFamily,
        fontWeight: FontWeightManager.regular,
      ),
    ),

    /// Tabbar theme
    tabBarTheme: TabBarTheme(
      dividerColor: AppColors.transparent,
      labelColor: AppColors.white,
      labelStyle: TextStyle(
        fontSize: FontSize.s14.sp,
        fontFamily: isAr ? FontConstants.arabicFontFamily : FontConstants.englishFontFamily,
        fontWeight: FontWeightManager.bold,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: FontSize.s14.sp,
        fontFamily: isAr ? FontConstants.arabicFontFamily : FontConstants.englishFontFamily,
        fontWeight: FontWeightManager.bold,
      ),
      indicator: BoxDecoration(
        borderRadius: AppBorderRadius.all(AppSize.s8),
        color: AppColors.primary,
      ),
      indicatorSize: TabBarIndicatorSize.tab
    ),

    /// Divider theme
    dividerColor: AppColors.grey200,
    dividerTheme: const DividerThemeData(color: AppColors.grey200),

    /// Progress indicator theme
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: AppColors.primary),

    /// Icon theme
    iconTheme: const IconThemeData(color: AppColors.black),

    /// Text fields
    inputDecorationTheme: InputDecorationTheme(
      iconColor: AppColors.black,
      hintStyle: TextStyle(
        color: AppColors.grey500,
        fontSize: FontSize.s14.sp,
        height: 1,
        fontWeight: FontWeightManager.regular,
        fontFamily: isAr ? FontConstants.arabicFontFamily : FontConstants.englishFontFamily,
      ),
      contentPadding: const EdgeInsets.all(AppPadding.p16),
      errorStyle: TextStyle(
        fontSize: FontSize.s10.sp,
        color: AppColors.warning,
        fontFamily: isAr ? FontConstants.arabicFontFamily : FontConstants.englishFontFamily,
      ),
      errorMaxLines: 5,
      filled: true,
      fillColor: AppColors.grey300.withOpacity(0.45),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: AppBorderRadius.all(AppSize.s12),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: AppBorderRadius.all(AppSize.s12),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: AppBorderRadius.all(AppSize.s12),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: AppBorderRadius.all(AppSize.s12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: AppBorderRadius.all(AppSize.s12),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: AppBorderRadius.all(AppSize.s12),
      ),
    ),
  );
}
