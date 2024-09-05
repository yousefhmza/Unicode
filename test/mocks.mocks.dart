// Mocks generated by Mockito 5.4.4 from annotations
// in unicode/test/mocks.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:unicode/core/services/error/failure.dart' as _i6;
import 'package:unicode/core/services/network/network_info.dart' as _i2;
import 'package:unicode/modules/categories/models/category_model.dart' as _i7;
import 'package:unicode/modules/categories/repositories/categories_repository.dart'
    as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeNetworkInfo_0 extends _i1.SmartFake implements _i2.NetworkInfo {
  _FakeNetworkInfo_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [CategoriesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockCategoriesRepository extends _i1.Mock
    implements _i4.CategoriesRepository {
  MockCategoriesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.NetworkInfo get networkInfo => (super.noSuchMethod(
        Invocation.getter(#networkInfo),
        returnValue: _FakeNetworkInfo_0(
          this,
          Invocation.getter(#networkInfo),
        ),
      ) as _i2.NetworkInfo);

  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> syncRemoteData() =>
      (super.noSuchMethod(
        Invocation.method(
          #syncRemoteData,
          [],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, String>>.value(
            _FakeEither_1<_i6.Failure, String>(
          this,
          Invocation.method(
            #syncRemoteData,
            [],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, String>>);

  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.CategoryModel>>>
      getAllCategories() => (super.noSuchMethod(
            Invocation.method(
              #getAllCategories,
              [],
            ),
            returnValue: _i5
                .Future<_i3.Either<_i6.Failure, List<_i7.CategoryModel>>>.value(
                _FakeEither_1<_i6.Failure, List<_i7.CategoryModel>>(
              this,
              Invocation.method(
                #getAllCategories,
                [],
              ),
            )),
          ) as _i5.Future<_i3.Either<_i6.Failure, List<_i7.CategoryModel>>>);

  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.CategoryModel>> addCategory(
    String? name,
    String? color,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #addCategory,
          [
            name,
            color,
          ],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i6.Failure, _i7.CategoryModel>>.value(
                _FakeEither_1<_i6.Failure, _i7.CategoryModel>(
          this,
          Invocation.method(
            #addCategory,
            [
              name,
              color,
            ],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i7.CategoryModel>>);

  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> deleteCategory(
          String? categoryId) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteCategory,
          [categoryId],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, String>>.value(
            _FakeEither_1<_i6.Failure, String>(
          this,
          Invocation.method(
            #deleteCategory,
            [categoryId],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, String>>);

  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> synchronizeCategories() =>
      (super.noSuchMethod(
        Invocation.method(
          #synchronizeCategories,
          [],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, String>>.value(
            _FakeEither_1<_i6.Failure, String>(
          this,
          Invocation.method(
            #synchronizeCategories,
            [],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, String>>);

  @override
  _i5.Future<_i3.Either<_i6.Failure, R>> call<R>({
    bool? returnDataOnly = true,
    required _i5.Future<R> Function()? firebaseRequest,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
          {
            #returnDataOnly: returnDataOnly,
            #firebaseRequest: firebaseRequest,
          },
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, R>>.value(
            _FakeEither_1<_i6.Failure, R>(
          this,
          Invocation.method(
            #call,
            [],
            {
              #returnDataOnly: returnDataOnly,
              #firebaseRequest: firebaseRequest,
            },
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, R>>);
}
