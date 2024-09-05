import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:unicode/modules/categories/models/category_model.dart';
import 'package:unicode/modules/todos/models/todo_model.dart';

import 'storage_keys.dart';

class LocalDatabase {
  Future<Database> get database async => await initDatabase();

  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "${StorageKeys.local}.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    // Create a table for categories
    await db.execute('''
    CREATE TABLE ${StorageKeys.categoriesTable} (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    ${StorageKeys.categoryId} TEXT,
    ${StorageKeys.categoryName} TEXT,
    ${StorageKeys.categoryColor} TEXT
    )   
    ''');

    // Create a table for todos
    await db.execute('''
    CREATE TABLE ${StorageKeys.todosTable} (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    ${StorageKeys.todoId} TEXT,
    ${StorageKeys.categoryId} TEXT,
    ${StorageKeys.todoTitle} TEXT,
    ${StorageKeys.todoDescription} TEXT
    )   
    ''');
  }

  Future<int> insertCategory(CategoryModel category) async {
    Database db = await database;
    return await db.insert(
      StorageKeys.categoriesTable,
      category.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> insertTodo(Todo todo) async {
    Database db = await database;
    return await db.insert(
      StorageKeys.todosTable,
      todo.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<CategoryModel>> getAllCategories() async {
    Database db = await database;
    List<Map<String, dynamic>> items = await db.query(StorageKeys.categoriesTable);
    List<CategoryModel> categories = List<CategoryModel>.from(items.map((item) => CategoryModel.fromJson(item)));
    return categories;
  }

  Future<List<Todo>> getAllTodos() async {
    Database db = await database;
    List<Map<String, dynamic>> items = await db.query(StorageKeys.todosTable);
    List<Todo> todos = List<Todo>.from(items.map((item) => Todo.fromJson(item)));
    return todos;
  }

  Future<List<Todo>> getTodos({required String categoryId}) async {
    Database db = await database;
    List<Map<String, dynamic>> items = await db.query(
      StorageKeys.todosTable,
      where: '${StorageKeys.categoryId} = ?',
      whereArgs: [categoryId],
    );
    List<Todo> todos = List<Todo>.from(items.map((item) => Todo.fromJson(item)));
    return todos;
  }

  Future<void> deleteCategory({required String categoryId}) async {
    Database db = await database;
    await db.delete(
      StorageKeys.categoriesTable,
      where: '${StorageKeys.categoryId} = ?',
      whereArgs: [categoryId],
    );
    await db.delete(
      StorageKeys.todosTable,
      where: '${StorageKeys.categoryId} = ?',
      whereArgs: [categoryId],
    );
  }

  Future<void> deleteTodo({required String todoId}) async {
    Database db = await database;
    await db.delete(
      StorageKeys.todosTable,
      where: '${StorageKeys.todoId} = ?',
      whereArgs: [todoId],
    );
  }

  Future<void> clearDatabase() async {
    Database db = await database;
    await db.delete(StorageKeys.categoriesTable);
    await db.delete(StorageKeys.todosTable);
  }
}
