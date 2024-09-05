import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unicode/core/services/error/failure.dart';
import 'package:unicode/core/services/local/cache_client.dart';
import 'package:unicode/core/services/local/local_database.dart';
import 'package:unicode/core/services/local/storage_keys.dart';
import 'package:unicode/core/services/network/network_info.dart';
import 'package:unicode/modules/todos/models/todo_model.dart';
import 'package:unicode/modules/todos/repositories/todos_repository.dart';

// Mock classes
class MockCacheClient extends Mock implements CacheClient {}

class MockLocalDatabase extends Mock implements LocalDatabase {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late TodosRepository todosRepository;
  late MockCacheClient mockCacheClient;
  late MockLocalDatabase mockLocalDatabase;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockCacheClient = MockCacheClient();
    mockLocalDatabase = MockLocalDatabase();
    mockNetworkInfo = MockNetworkInfo();
    todosRepository = TodosRepository(mockCacheClient, mockLocalDatabase, mockNetworkInfo);
  });

  const testCategoryId = 'category123';
  const testUserId = 'user123';
  const testTodoId = 'todo123';

  final Todo testTodo = Todo(
    id: testTodoId,
    categoryId: testCategoryId,
    title: 'Test Todo',
    description: 'Test Todo Description',
  );

  group('TodosRepository', () {
    // Test for getTodos
    test('should return a list of todos from the local database', () async {
      // Arrange
      when(mockLocalDatabase.getTodos(categoryId: testCategoryId)).thenAnswer((_) async => [testTodo]);

      // Act
      final result = await todosRepository.getTodos(categoryId: testCategoryId);

      // Assert
      expect(result, Right([testTodo]));
      verify(mockLocalDatabase.getTodos(categoryId: testCategoryId)).called(1);
    });

    test('should return a Failure when fetching todos fails', () async {
      // Arrange
      when(mockLocalDatabase.getTodos(categoryId: testCategoryId)).thenThrow(Exception());

      // Act
      final result = await todosRepository.getTodos(categoryId: testCategoryId);

      // Assert
      expect(result, Left(isA<Failure>()));
    });

    // Test for addTodo
    test('should add a todo and return the created todo', () async {
      // Arrange
      when(mockCacheClient.get(StorageKeys.userId)).thenAnswer((_) async => testUserId);

      // Act
      final result = await todosRepository.addTodo(testCategoryId, 'New Todo', 'New Description');

      // Assert
      expect(result.isRight(), true);
      verify(mockCacheClient.get(StorageKeys.userId)).called(1);
    });

    test('should return a Failure when adding a todo fails', () async {
      // Arrange
      when(mockCacheClient.get(StorageKeys.userId)).thenAnswer((_) async => testUserId);

      // Act
      final result = await todosRepository.addTodo(testCategoryId, 'New Todo', 'New Description');

      // Assert
      expect(result, Left(isA<Failure>()));
    });

    // Test for deleteTodo
    test('should delete a todo successfully', () async {
      // Arrange
      when(mockLocalDatabase.deleteTodo(todoId: testTodoId)).thenAnswer((_) async => {});

      // Act
      final result = await todosRepository.deleteTodo(testTodoId);

      // Assert
      expect(result.isRight(), true);
      verify(mockLocalDatabase.deleteTodo(todoId: testTodoId)).called(1);
    });

    test('should return a Failure when deleting a todo fails', () async {
      // Arrange
      when(mockLocalDatabase.deleteTodo(todoId: testTodoId)).thenThrow(Exception());

      // Act
      final result = await todosRepository.deleteTodo(testTodoId);

      // Assert
      expect(result, Left(isA<Failure>()));
    });

    // Test for synchronizeTodos
    test('should synchronize todos successfully with Firebase', () async {
      // Arrange
      when(mockCacheClient.get(StorageKeys.userId)).thenAnswer((_) async => testUserId);
      when(mockLocalDatabase.getAllTodos()).thenAnswer((_) async => [testTodo]);

      // Act
      final result = await todosRepository.synchronizeTodos();

      // Assert
      expect(result.isRight(), true);
      verify(mockCacheClient.get(StorageKeys.userId)).called(1);
      verify(mockLocalDatabase.getAllTodos()).called(1);
      verify(mockLocalDatabase.getAllCategories()).called(1);
    });

    test('should return a Failure when synchronizing todos fails', () async {
      // Arrange
      when(mockCacheClient.get(StorageKeys.userId)).thenAnswer((_) async => testUserId);
      when(mockLocalDatabase.getAllTodos()).thenThrow(Exception());

      // Act
      final result = await todosRepository.synchronizeTodos();

      // Assert
      expect(result, Left(isA<Failure>()));
    });
  });
}
