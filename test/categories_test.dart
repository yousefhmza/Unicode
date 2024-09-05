import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:unicode/modules/categories/cubits/categories_cubit.dart';
import 'package:unicode/modules/categories/models/category_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicode/modules/categories/views/screens/categories_screen.dart';

import 'mocks.mocks.dart'; // Import generated mocks

void main() {
  late MockCategoriesRepository mockCategoriesRepository;

  setUp(() {
    mockCategoriesRepository = MockCategoriesRepository();
  });

  testWidgets('Fetch and display categories', (WidgetTester tester) async {
    // Mocking data response from repository
    when(mockCategoriesRepository.getAllCategories()).thenAnswer(
      (_) async => Right([
        CategoryModel(id: '1', name: 'Work', color: 'blue'),
        CategoryModel(id: '2', name: 'Personal', color: 'green'),
      ]),
    );

    // Initialize CategoriesCubit with the mocked repository
    final categoriesCubit = CategoriesCubit(mockCategoriesRepository);

    // Build the app widget tree
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) => categoriesCubit,
          child: const CategoriesScreen(),
        ),
      ),
    );

    // Trigger data fetching
    await categoriesCubit.getAllCategories();

    // Rebuild the widget after the state change
    await tester.pumpAndSettle();

    // Verify if the categories are displayed correctly in the UI
    expect(find.text('Work'), findsOneWidget);
    expect(find.text('Personal'), findsOneWidget);
  });
}
