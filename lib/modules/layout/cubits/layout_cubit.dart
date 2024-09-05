import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicode/modules/categories/views/screens/categories_screen.dart';
import 'package:unicode/modules/layout/views/screens/language_screen.dart';
import 'package:unicode/modules/profile/views/screens/profile_screen.dart';

part 'layout_states.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState());

  int currentIndex = 0;
  final List<Widget> screens = const [
    CategoriesScreen(),
    LanguageScreen(),
    ProfileScreen(),
  ];

  void setCurrentIndex(int index) {
    currentIndex = index;
    emit(LayoutSetIndexState());
  }

  void reset() {
    currentIndex = 0;
  }
}
