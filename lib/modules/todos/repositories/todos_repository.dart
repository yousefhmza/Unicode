import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:unicode/core/base/repositories/base_repository.dart';
import 'package:unicode/core/services/error/error_handler.dart';
import 'package:unicode/core/services/local/cache_client.dart';
import 'package:unicode/core/services/local/local_database.dart';
import 'package:unicode/core/services/local/storage_keys.dart';
import 'package:unicode/core/utils/constants.dart';
import 'package:unicode/modules/todos/models/todo_model.dart';

import '../../../core/services/error/failure.dart';

class TodosRepository extends BaseRepository {
  final CacheClient _cacheClient;
  final LocalDatabase _localDatabase;

  TodosRepository(this._cacheClient, this._localDatabase, super.networkInfo);

  Future<Either<Failure, List<Todo>>> getTodos({required String categoryId}) async {
    try {
      final todos = await _localDatabase.getTodos(categoryId: categoryId);
      return Right(todos);
    } on Exception catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, Todo>> addTodo(String categoryId, String title, String desc) async {
    try {
      final String userId = await _cacheClient.get(StorageKeys.userId);
      CollectionReference todosCollection = FirebaseFirestore.instance
          .collection(FirebaseConstants.usersCollection)
          .doc(userId)
          .collection(FirebaseConstants.categoriesCollection)
          .doc(categoryId)
          .collection(FirebaseConstants.todosCollection);
      DocumentReference docRef = todosCollection.doc();
      final Todo todo = Todo(id: docRef.id, categoryId: categoryId, title: title, description: desc);
      await _localDatabase.insertTodo(todo);
      return Right(todo);
    } on Exception catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, String>> deleteTodo(String todoId) async {
    try {
      await _localDatabase.deleteTodo(todoId: todoId);
      return const Right("");
    } on Exception catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, String>> synchronizeTodos() async {
    try {
      final String userId = await _cacheClient.get(StorageKeys.userId);
      final todos = await _localDatabase.getAllTodos();
      final categories = await _localDatabase.getAllCategories();

      CollectionReference categoriesCollection = FirebaseFirestore.instance
          .collection(FirebaseConstants.usersCollection)
          .doc(userId)
          .collection(FirebaseConstants.categoriesCollection);

      // Delete all the existing todos in all categories
      for (var category in categories) {
        final categoryCollectionRef =
            categoriesCollection.doc(category.id).collection(FirebaseConstants.todosCollection);
        while (true) {
          QuerySnapshot querySnapshot = await categoryCollectionRef.limit(500).get();
          if (querySnapshot.docs.isEmpty) break;
          WriteBatch batch = FirebaseFirestore.instance.batch();
          for (QueryDocumentSnapshot doc in querySnapshot.docs) {
            batch.delete(doc.reference);
          }
          await batch.commit();
        }
      }

      // Replace existing todos with the new ones
      for (var todo in todos) {
        await categoriesCollection
            .doc(todo.categoryId)
            .collection(FirebaseConstants.todosCollection)
            .doc(todo.id)
            .set(todo.toJson());
      }

      return const Right("");
    } on Exception catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
