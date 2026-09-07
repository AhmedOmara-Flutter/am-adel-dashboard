import '../../../../../core/services/database_services.dart';
import '../../data/models/category_model.dart';
import '../../data/repos/category_repo.dart';
import '../entities/category_entity.dart';

class CategoryRepoImpl implements CategoryRepo {
  final DatabaseServices _databaseServices;

  CategoryRepoImpl(this._databaseServices);

  static const String _collection = 'categories';

  @override
  Stream<List<CategoryEntity>> getCategoriesStream() {
    return _databaseServices
        .getStreamData(
      path: _collection,
      query: {
        'orderBy': 'sortOrder',
        'descending': false,
      },
    )
        .map((data) {
      final List categories = data as List;

      return categories
          .map(
            (json) => CategoryModel.fromJson(
          Map<String, dynamic>.from(json),
        ).toEntity(),
      )
          .toList();
    });
  }

  @override
  Future<int> getNextSortOrder() async {
    final data = await _databaseServices.getData(
      path: _collection,
      query: {
        'orderBy': 'sortOrder',
        'descending': true,
        'limit': 1,
      },
    );

    final List categories = data as List;

    if (categories.isEmpty) {
      return 0;
    }

    final lastCategory = Map<String, dynamic>.from(
      categories.first,
    );

    return ((lastCategory['sortOrder'] as num?)?.toInt() ?? -1) + 1;
  }

  @override
  Future<String> addCategory(
      CategoryEntity category,
      ) async {
    final sortOrder = await getNextSortOrder();

    final updatedCategory = CategoryEntity(
      id: category.id,
      name: category.name,
      sizes: category.sizes,
      createdAt: category.createdAt,
      sortOrder: sortOrder,
    );

    final model = CategoryModel.fromEntity(
      updatedCategory,
    );

    return await _databaseServices.addData(
      path: _collection,
      data: model.toJson(),
    );
  }

  @override
  Future<void> updateCategory(
      CategoryEntity category,
      ) async {
    final model = CategoryModel.fromEntity(
      category,
    );

    await _databaseServices.updateData(
      path: _collection,
      docId: category.id,
      data: model.toJson(),
    );
  }

  @override
  Future<void> updateCategoriesOrder(
      List<CategoryEntity> categories,
      ) async {
    for (int index = 0; index < categories.length; index++) {
      final category = categories[index];

      final updatedCategory = CategoryEntity(
        id: category.id,
        name: category.name,
        sizes: category.sizes,
        createdAt: category.createdAt,
        sortOrder: index,
      );

      final model = CategoryModel.fromEntity(
        updatedCategory,
      );

      await _databaseServices.updateData(
        path: _collection,
        docId: category.id,
        data: model.toJson(),
      );
    }
  }

  @override
  Future<void> deleteCategory(
      String id,
      ) async {
    await _databaseServices.deleteData(
      path: _collection,
      uId: id,
    );
  }

  @override
  Future<bool> checkCategoryExists(
      String id,
      ) async {
    return await _databaseServices.checkExists(
      path: _collection,
      uId: id,
    );
  }

  @override
  Future<void> deleteCollection(
      String collectionName,
      ) async {
    await _databaseServices.deleteCollection(
      collectionName,
    );
  }
}