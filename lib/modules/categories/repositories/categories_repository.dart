import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:unicode/core/base/repositories/base_repository.dart';
import 'package:unicode/core/services/error/error_handler.dart';
import 'package:unicode/core/services/local/cache_client.dart';
import 'package:unicode/core/services/local/local_database.dart';
import 'package:unicode/core/services/local/storage_keys.dart';
import 'package:unicode/core/utils/constants.dart';
import 'package:unicode/modules/categories/models/category_model.dart';

import '../../../core/services/error/failure.dart';
import '../../todos/models/todo_model.dart';

class CategoriesRepository extends BaseRepository {
  final CacheClient _cacheClient;
  final LocalDatabase _localDatabase;

  CategoriesRepository(this._cacheClient, this._localDatabase, super.networkInfo);

  // Fetch remote categories and todos and save them to local database, This method is performed only after login
  Future<Either<Failure, String>> syncRemoteData() async {
    return super.call<String>(
      firebaseRequest: () async {
        final String userId = await _cacheClient.get(StorageKeys.userId);
        final docSnapshot = await FirebaseFirestore.instance
            .collection(FirebaseConstants.usersCollection)
            .doc(userId)
            .collection(FirebaseConstants.categoriesCollection)
            .get();
        final List<CategoryModel> categories =
            List.from(docSnapshot.docs.map((doc) => CategoryModel.fromJson(doc.data())));
        for (var category in categories) {
          await _localDatabase.insertCategory(category);
          final todosSnapshot = await FirebaseFirestore.instance
              .collection(FirebaseConstants.usersCollection)
              .doc(userId)
              .collection(FirebaseConstants.categoriesCollection)
              .doc(category.id)
              .collection(FirebaseConstants.todosCollection)
              .get();
          final List<Todo> todos = List.from(todosSnapshot.docs.map((doc) => Todo.fromJson(doc.data())));
          for (var todo in todos) {
            await _localDatabase.insertTodo(todo);
          }
        }
        return "";
      },
    );
  }

  // Get all categories from local database
  Future<Either<Failure, List<CategoryModel>>> getAllCategories() async {
    try {
      final categories = await _localDatabase.getAllCategories();
      return Right(categories);
    } on Exception catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  // Add category to local database and its id from firebase firestore
  Future<Either<Failure, CategoryModel>> addCategory(String name, String color) async {
    try {
      final String userId = await _cacheClient.get(StorageKeys.userId);
      CollectionReference categoriesCollection = FirebaseFirestore.instance
          .collection(FirebaseConstants.usersCollection)
          .doc(userId)
          .collection(FirebaseConstants.categoriesCollection);
      DocumentReference docRef = categoriesCollection.doc();
      final CategoryModel category = CategoryModel(id: docRef.id, name: name, color: color);
      await _localDatabase.insertCategory(category);
      return Right(category);
    } on Exception catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  // Delete category from local database
  Future<Either<Failure, String>> deleteCategory(String categoryId) async {
    try {
      await _localDatabase.deleteCategory(categoryId: categoryId);
      return const Right("");
    } on Exception catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  // Sync categories from local data base to remote firebase firestore database
  Future<Either<Failure, String>> synchronizeCategories() async {
    try {
      final String userId = await _cacheClient.get(StorageKeys.userId);
      final categories = await _localDatabase.getAllCategories();

      CollectionReference collectionRef = FirebaseFirestore.instance
          .collection(FirebaseConstants.usersCollection)
          .doc(userId)
          .collection(FirebaseConstants.categoriesCollection);

      // Delete all the existing categories at firebase
      while (true) {
        QuerySnapshot querySnapshot = await collectionRef.limit(500).get();
        if (querySnapshot.docs.isEmpty) break;
        WriteBatch batch = FirebaseFirestore.instance.batch();
        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          batch.delete(doc.reference);
        }
        await batch.commit();
      }

      // Replace existing categories in firebase with the categories stored locally
      for (var category in categories) {
        await collectionRef.doc(category.id).set(category.toJson());
      }

      return const Right("");
    } on Exception catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
