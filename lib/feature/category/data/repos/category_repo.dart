import '../../domain/entities/category_entity.dart';

abstract class CategoryRepo {
  Stream<List<CategoryEntity>> getCategoriesStream();

  Future<String> addCategory(CategoryEntity category);

  Future<void> updateCategory(CategoryEntity category);

  Future<void> deleteCategory(String id);

  Future<bool> checkCategoryExists(String id);

  Future<int> getNextSortOrder();

  Future<void> updateCategoriesOrder(
      List<CategoryEntity> categories,
      );

  Future<void> deleteCollection(String collectionName);
}