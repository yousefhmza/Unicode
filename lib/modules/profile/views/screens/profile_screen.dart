import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicode/config/navigation/navigation.dart';
import 'package:unicode/core/resources/resources.dart';
import 'package:unicode/core/utils/alerts.dart';
import 'package:unicode/core/utils/dialogs.dart';
import 'package:unicode/core/utils/globals.dart';
import 'package:unicode/core/view/views.dart';
import 'package:unicode/modules/profile/cubits/profile_cubit.dart';
import '../../../../config/localization/l10n/l10n.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileCubit profileCubit;

  @override
  void initState() {
    super.initState();
    profileCubit = BlocProvider.of<ProfileCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppColors.grey200,
          width: double.infinity,
          padding: AppEdgeInsets.all(AppPadding.p12),
          child: SafeArea(
            child: Row(
              children: [
                const CustomIcon(Icons.person_pin, size: AppSize.s32),
                const HorizontalSpace(AppSize.s4),
                Expanded(
                  child: Padding(
                    padding: AppEdgeInsets.only(bottom: AppPadding.p4),
                    child: CustomText(Global.instance.currentUser!.email, fontSize: FontSize.s16),
                  ),
                ),
              ],
            ),
          ),
        ),
        BlocConsumer<ProfileCubit, ProfileStates>(
          listener: (context, state) {
            if (state is SyncCategoriesSuccessState) profileCubit.syncTodos(logoutAfterDone: state.logoutAfterDone);
            if (state is SyncCategoriesFailureState) Alerts.showSnackBar(context, message: state.failure.message);

            if (state is SyncTodosSuccessState) {
              Alerts.showToast(L10n.tr(context).syncSuccess);
              if (state.logoutAfterDone) profileCubit.logout();
            }
            if (state is SyncTodosFailureState) Alerts.showSnackBar(context, message: state.failure.message);

            if (state is LogoutSuccessState) NavigationService.pushReplacementAll(Routes.authScreen);
            if (state is LogoutFailureState) Alerts.showSnackBar(context, message: state.failure.message);
          },
          builder: (context, state) {
            return ListTile(
              onTap: () {
                if (state is SyncCategoriesLoadingState || state is SyncTodosLoadingState) return;
                profileCubit.syncCategories(logoutAfterDone: false);
              },
              leading: CustomIcon(Icons.sync),
              title: Row(
                children: [
                  Expanded(child: CustomText(L10n.tr(context).syncData)),
                  HorizontalSpace(AppSize.s8),
                  state is SyncCategoriesLoadingState || state is SyncTodosLoadingState
                      ? const LoadingSpinner(hasSmallRadius: true)
                      : const SizedBox.shrink()
                ],
              ),
            );
          },
        ),
        ListTile(
          onTap: () => AppDialogs.showAnimatedDialog(
            context,
            ConfirmationDialog(
                title: L10n.tr(context).logoutWarning,
                onConfirm: () => profileCubit.syncCategories(logoutAfterDone: true)),
          ),
          leading: CustomIcon(Icons.logout),
          title: CustomText(L10n.tr(context).logout),
        )
      ],
    );
  }
}
