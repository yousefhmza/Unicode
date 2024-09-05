import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicode/config/navigation/navigation.dart';
import 'package:unicode/core/resources/resources.dart';
import 'package:unicode/core/utils/alerts.dart';
import 'package:unicode/core/utils/dialogs.dart';
import 'package:unicode/core/view/views.dart';
import 'package:unicode/modules/categories/cubits/categories_cubit.dart';
import 'package:unicode/modules/categories/views/components/add_category_dialog.dart';
import 'package:unicode/modules/categories/views/widgets/category_item.dart';
import '../../../../config/localization/l10n/l10n.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late final CategoriesCubit categoriesCubit;

  @override
  void initState() {
    super.initState();
    categoriesCubit = BlocProvider.of<CategoriesCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          CustomSliverAppbar(
            title: L10n.tr(context).categories,
            centerTitle: false,
            actions: [
              GestureDetector(
                onTap: () => AppDialogs.showAnimatedDialog(context, const AddCategoryDialog()),
                child: CustomIcon(Icons.add_circle, size: AppSize.s32),
              ),
              HorizontalSpace(AppSize.s12),
            ],
          ),
        ],
        body: BlocListener<CategoriesCubit, CategoriesStates>(
          listener: (context, state) {
            if (state is DeleteCategorySuccessState) {
              Future.delayed(
                Time.t500ms,
                () {
                  categoriesCubit.listKey.currentState!.removeItem(
                    state.index,
                    (context, animation) => CategoryItem(animation: animation, category: state.category),
                    duration: Time.t700ms,
                  );
                },
              );
            }
            if (state is SyncRemoteDataLoadingState) AppDialogs.showLoadingDialog(context);
            if (state is SyncRemoteDataFailureState) {
              NavigationService.goBack();
              Alerts.showSnackBar(
                context,
                message: state.failure.message,
                onActionPressed: categoriesCubit.syncRemoteData,
              );
            }
            if (state is SyncRemoteDataSuccessState) {
              NavigationService.goBack();
              categoriesCubit.getAllCategories();
            }
          },
          child: AnimatedList(
            key: categoriesCubit.listKey,
            padding: AppEdgeInsets.all(AppPadding.p12),
            initialItemCount: categoriesCubit.categories.length,
            itemBuilder: (context, index, animation) => CategoryItem(
              animation: animation,
              category: categoriesCubit.categories[index],
            ),
          ),
        ),
      ),
    );
  }
}
