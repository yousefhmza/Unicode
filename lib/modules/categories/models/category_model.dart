import '../../../core/services/local/storage_keys.dart';

class CategoryModel {
  final String id;
  final String name;
  final String color;

  CategoryModel({required this.id, required this.name, required this.color});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json[StorageKeys.categoryId] ?? "",
        name: json[StorageKeys.categoryName] ?? "",
        color: json[StorageKeys.categoryColor] ?? "",
      );

  Map<String, dynamic> toJson() {
    return {
      StorageKeys.categoryId: id,
      StorageKeys.categoryName: name,
      StorageKeys.categoryColor: color,
    };
  }
}
