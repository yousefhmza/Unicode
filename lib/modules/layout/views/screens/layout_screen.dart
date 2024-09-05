import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicode/core/resources/resources.dart';
import 'package:unicode/core/view/views.dart';
import 'package:unicode/modules/layout/views/components/bnb.dart';
import '../../../categories/cubits/categories_cubit.dart';
import '../../cubits/layout_cubit.dart';

class LayoutScreen extends StatefulWidget {
  final bool requireSyncData;

  const LayoutScreen({required this.requireSyncData, super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  late final LayoutCubit layoutCubit;
  late final CategoriesCubit categoriesCubit;

  @override
  void initState() {
    super.initState();
    layoutCubit = BlocProvider.of<LayoutCubit>(context);
    categoriesCubit = BlocProvider.of<CategoriesCubit>(context);
    categoriesCubit.reset();
    layoutCubit.reset();
    widget.requireSyncData
        ? Future.delayed(Time.t200ms, () => categoriesCubit.syncRemoteData())
        : categoriesCubit.getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return StatusBar(
      child: Scaffold(
        body: BlocBuilder<LayoutCubit, LayoutStates>(
          buildWhen: (prevState, state) => state is LayoutSetIndexState,
          builder: (context, state) => layoutCubit.screens[layoutCubit.currentIndex],
        ),
        bottomNavigationBar: const BNB(),
      ),
    );
  }
}
