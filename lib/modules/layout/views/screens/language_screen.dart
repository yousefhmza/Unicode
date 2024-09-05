import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicode/core/resources/resources.dart';
import 'package:unicode/core/view/views.dart';

import '../../../../config/localization/cubit/l10n_cubit.dart';
import '../../../../config/localization/l10n/l10n.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: AppEdgeInsets.all(AppPadding.p12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(L10n.tr(context).language, fontWeight: FontWeightManager.bold, fontSize: FontSize.s24),
            const VerticalSpace(AppSize.s12),
            RadioListTile<bool>.adaptive(
              value: false,
              title: CustomText("English", fontFamily: FontConstants.englishFontFamily),
              activeColor: AppColors.black,
              groupValue:
                  BlocProvider.of<L10nCubit>(context, listen: true).appLocale?.languageCode.contains("ar") ?? false,
              onChanged: (value) => BlocProvider.of<L10nCubit>(context).setAppLocale(false),
            ),
            RadioListTile<bool>.adaptive(
              value: true,
              title: CustomText("العربية", fontFamily: FontConstants.arabicFontFamily),
              activeColor: AppColors.black,
              groupValue:
                  BlocProvider.of<L10nCubit>(context, listen: true).appLocale?.languageCode.contains("ar") ?? false,
              onChanged: (value) => BlocProvider.of<L10nCubit>(context).setAppLocale(true),
            ),
          ],
        ),
      ),
    );
  }
}
