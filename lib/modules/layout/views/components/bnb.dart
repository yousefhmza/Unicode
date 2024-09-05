import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/resources.dart';
import '../../cubits/layout_cubit.dart';
import '../../../../config/localization/l10n/l10n.dart';

class BNB extends StatefulWidget {
  const BNB({super.key});

  @override
  State<BNB> createState() => _BNBState();
}

class _BNBState extends State<BNB> {
  late final LayoutCubit layoutCubit;

  @override
  void initState() {
    super.initState();
    layoutCubit = BlocProvider.of<LayoutCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    final double indicatorWidth = MediaQuery.of(context).size.width / 3;
    return BlocBuilder<LayoutCubit, LayoutStates>(
      buildWhen: (prevState, state) => state is LayoutSetIndexState,
      builder: (context, state) => Stack(
        children: [
          BottomNavigationBar(
            currentIndex: layoutCubit.currentIndex,
            onTap: layoutCubit.setCurrentIndex,
            items: [
              BottomNavigationBarItem(icon: const Icon(Icons.category), label: L10n.tr(context).categories),
              BottomNavigationBarItem(icon: const Icon(Icons.language), label: L10n.tr(context).language),
              BottomNavigationBarItem(icon: const Icon(Icons.person), label: L10n.tr(context).profile),
            ],
          ),
          AnimatedPositionedDirectional(
            duration: Time.t200ms,
            curve: Curves.easeInOut,
            start: layoutCubit.currentIndex * indicatorWidth,
            top: AppSize.s0,
            child: Container(
              width: indicatorWidth,
              height: AppSize.s2,
              color: AppColors.transparent,
              child: Center(
                child: Container(
                  width: indicatorWidth / 1.6,
                  height: AppSize.s2,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
