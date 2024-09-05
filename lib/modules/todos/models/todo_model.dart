import '../../../core/services/local/storage_keys.dart';

class Todo {
  final String id;
  final String categoryId;
  final String title;
  final String description;

  Todo({required this.id, required this.categoryId, required this.title, required this.description});

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json[StorageKeys.todoId] ?? "",
        categoryId: json[StorageKeys.categoryId] ?? "",
        title: json[StorageKeys.todoTitle] ?? "",
        description: json[StorageKeys.todoDescription] ?? "",
      );

  Map<String, dynamic> toJson() {
    return {
      StorageKeys.todoId: id,
      StorageKeys.categoryId: categoryId,
      StorageKeys.todoTitle: title,
      StorageKeys.todoDescription: description,
    };
  }
}
