import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicode/core/resources/resources.dart';
import 'package:unicode/modules/profile/cubits/profile_cubit.dart';

import '../../../../config/navigation/navigation.dart';
import '../../../../core/services/error/error_handler.dart';
import '../../../../core/utils/alerts.dart';
import '../../../../core/view/views.dart';
import '../../../auth/cubits/auth_cubit.dart';
import '../../../../config/localization/l10n/l10n.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AuthCubit authCubit;
  late final ProfileCubit profileCubit;
  StreamSubscription<List<ConnectivityResult>>? connectivityResult;

  @override
  void initState() {
    authCubit = BlocProvider.of<AuthCubit>(context);
    profileCubit = BlocProvider.of<ProfileCubit>(context);
    Future.delayed(
      Time.t1_5s,
      () async {
        final result = await Connectivity().checkConnectivity();
        if (result.contains(ConnectivityResult.mobile) || result.contains(ConnectivityResult.wifi)) {
          fetchAndRedirect();
        } else {
          Alerts.showToast(ErrorType.noInternetConnection.getFailure().message);
          connectivityResult = Connectivity().onConnectivityChanged.listen((result) {
            bool isConnected = result.contains(ConnectivityResult.mobile) || result.contains(ConnectivityResult.wifi);
            if (isConnected) {
              Alerts.showToast(L10n.tr(context).connected);
              fetchAndRedirect();
            } else {
              Alerts.showToast(ErrorType.noInternetConnection.getFailure().message);
            }
          });
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    connectivityResult?.cancel();
  }

  Future<void> fetchAndRedirect() async {
    if (authCubit.isAuthed) {
      profileCubit.getCurrentUser();
    } else {
      NavigationService.pushReplacementAll(Routes.authScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatusBar(
      child: Scaffold(
        body: Stack(
          children: [
            const FadeSlideAnimatedWidget(
              child: Center(
                child: CustomImage(
                  image: AppImages.logo,
                  width: AppSize.s150,
                  borderRadius: AppSize.s16,
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: SafeArea(
                child: Padding(
                  padding: AppEdgeInsets.only(bottom: AppPadding.p8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BlocConsumer<ProfileCubit, ProfileStates>(
                        listener: (context, state) {
                          if (state is GetCurrentUserFailureState) {
                            Alerts.showSnackBar(
                              context,
                              message: state.failure.message,
                              onActionPressed: profileCubit.getCurrentUser,
                            );
                          }
                          if (state is GetCurrentUserSuccessState) {
                            NavigationService.pushReplacementAll(Routes.layoutScreen,
                                arguments: {"requireSyncData": false});
                          }
                        },
                        builder: (context, state) =>
                            state is GetCurrentUserLoadingState ? const LoadingSpinner() : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
