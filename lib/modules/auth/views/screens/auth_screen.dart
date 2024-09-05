import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicode/config/navigation/navigation.dart';
import 'package:unicode/core/extensions/num_extensions.dart';
import 'package:unicode/core/resources/resources.dart';
import 'package:unicode/core/utils/alerts.dart';
import 'package:unicode/core/utils/validators.dart';
import 'package:unicode/modules/auth/cubits/auth_cubit.dart';
import 'package:unicode/modules/auth/models/requests/auth_body.dart';
import '../../../../config/localization/l10n/l10n.dart';
import '../../../../core/view/views.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late final AuthCubit authCubit;
  late final TabController tabController;
  late final GlobalKey<FormState> formKey;
  late final AuthBody authBody;

  @override
  void initState() {
    super.initState();
    authCubit = BlocProvider.of<AuthCubit>(context);
    tabController = TabController(length: 2, vsync: this, initialIndex: 1);
    formKey = GlobalKey<FormState>();
    authBody = AuthBody();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StatusBar(
      child: Scaffold(
        body: Form(
          key: formKey,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: AppEdgeInsets.all(AppPadding.p16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpace(AppSize.s72),
                  CustomText(L10n.tr(context).signIn, fontSize: FontSize.s20, fontWeight: FontWeightManager.bold),
                  const VerticalSpace(AppSize.s8),
                  CustomText(L10n.tr(context).signInDesc, fontSize: FontSize.s16, color: AppColors.grey600),
                  const VerticalSpace(AppSize.s32),
                  SizedBox(
                    height: AppSize.s36.h,
                    child: TabBar(
                      controller: tabController,
                      tabs: [Tab(text: L10n.tr(context).login), Tab(text: L10n.tr(context).signup)],
                    ),
                  ),
                  const VerticalSpace(AppSize.s16),
                  FadeSlideAnimatedWidget(
                    beginOffset: Offset(1, 0),
                    animationDuration: Time.t1_5s,
                    delay: Time.t300ms,
                    animationCurve: const ElasticOutCurve(0.8),
                    child: CustomTextField(
                      label: L10n.tr(context).email,
                      keyBoardType: TextInputType.emailAddress,
                      validator: Validators.emailValidator,
                      onChanged: (value) => authBody.copyWith(email: value),
                    ),
                  ),
                  const VerticalSpace(AppSize.s8),
                  FadeSlideAnimatedWidget(
                    beginOffset: Offset(-1, 0),
                    animationDuration: Time.t1_5s,
                    delay: Time.t300ms,
                    animationCurve: const ElasticOutCurve(0.8),
                    child: CustomTextField(
                      label: L10n.tr(context).password,
                      keyBoardType: TextInputType.visiblePassword,
                      validator: Validators.passwordValidator,
                      onChanged: (value) => authBody.copyWith(password: value),
                    ),
                  ),
                  const VerticalSpace(AppSize.s48),
                  FadeSlideAnimatedWidget(
                    animationDuration: Time.t1s,
                    child: BlocConsumer<AuthCubit, AuthStates>(
                      listener: (context, state) {
                        if (state is AuthFailureState) Alerts.showSnackBar(context, message: state.failure.message);
                        if (state is AuthSuccessState) {
                          NavigationService.pushReplacementAll(
                            Routes.layoutScreen,
                            arguments: {"requireSyncData": tabController.index == 0},
                          );
                        }
                      },
                      builder: (context, state) => Center(
                        child: CustomButton(
                          isLoading: state is AuthLoadingState,
                          width: double.infinity,
                          text: L10n.tr(context).goOn,
                          onPressed: () {
                            if (!formKey.currentState!.validate()) return;
                            tabController.index == 0 ? authCubit.login(authBody) : authCubit.signup(authBody);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
