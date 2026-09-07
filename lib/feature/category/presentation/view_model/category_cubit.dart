import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/repos/category_repo.dart';
import '../../domain/entities/category_entity.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepo _categoryRepo;

  StreamSubscription<List<CategoryEntity>>? _categoriesSubscription;

  CategoryCubit(this._categoryRepo) : super(CategoryInitial());

  List<CategoryEntity> categories = [];

  // ============================================================
  // GET CATEGORIES
  // ============================================================

  void getCategories() {
    // لو الـ Cubit اتقفل، متعملش أي حاجة
    if (isClosed) return;

    emit(CategoryGetLoading());

    // إلغاء الـ subscription القديمة
    _categoriesSubscription?.cancel();

    _categoriesSubscription =
        _categoryRepo.getCategoriesStream().listen(
              (categories) {
            // مهم جدًا:
            // ممكن الـ stream يرجع data بعد ما Cubit يتقفل
            if (isClosed) return;

            this.categories = categories;

            emit(
              CategoryGetSuccess(
                categories: categories,
              ),
            );
          },
          onError: (error) {
            // ممكن يحصل error بعد إغلاق Cubit
            if (isClosed) return;

            emit(
              CategoryGetError(
                message: error.toString(),
              ),
            );
          },
        );
  }

  // ============================================================
  // ADD CATEGORY
  // ============================================================

  Future<void> addCategory(
      CategoryEntity category,
      ) async {
    if (isClosed) return;

    emit(CategoryAddLoading());

    try {
      await _categoryRepo.addCategory(category);

      // مهم جدًا بعد await
      if (isClosed) return;

      emit(CategoryAddSuccess());
    } catch (e) {
      // لو Cubit اتقفل أثناء العملية
      if (isClosed) return;

      emit(
        CategoryAddError(
          message: e.toString(),
        ),
      );
    }
  }

  // ============================================================
  // UPDATE CATEGORY
  // ============================================================

  Future<void> updateCategory(
      CategoryEntity category,
      ) async {
    if (isClosed) return;

    emit(CategoryUpdateLoading());

    try {
      await _categoryRepo.updateCategory(category);

      // مهم جدًا بعد await
      if (isClosed) return;

      emit(CategoryUpdateSuccess());
    } catch (e) {
      if (isClosed) return;

      emit(
        CategoryUpdateError(
          message: e.toString(),
        ),
      );
    }
  }

  // ============================================================
  // DELETE CATEGORY
  // ============================================================

  Future<void> deleteCategory(
      String id,
      ) async {
    if (isClosed) return;

    emit(CategoryDeleteLoading());

    try {
      await _categoryRepo.deleteCategory(id);

      // مهم جدًا بعد await
      if (isClosed) return;

      emit(CategoryDeleteSuccess());
    } catch (e) {
      if (isClosed) return;

      emit(
        CategoryDeleteError(
          message: e.toString(),
        ),
      );
    }
  }

  // ============================================================
  // DELETE ALL CATEGORIES
  // ============================================================

  Future<void> deleteAllCategories() async {
    if (isClosed) return;

    emit(CategoryDeleteAllLoading());

    try {
      await _categoryRepo.deleteCollection(
        'categories',
      );

      // مهم جدًا بعد await
      if (isClosed) return;

      emit(CategoryDeleteAllSuccess());
    } catch (e) {
      if (isClosed) return;

      emit(
        CategoryDeleteAllError(
          message: e.toString(),
        ),
      );
    }
  }

  // ============================================================
  // UPDATE CATEGORIES ORDER
  // ============================================================

  Future<void> updateCategoriesOrder(
      List<CategoryEntity> categories,
      ) async {
    if (isClosed) return;

    try {
      await _categoryRepo.updateCategoriesOrder(
        categories,
      );

      // ممكن Cubit يتقفل أثناء await
      if (isClosed) return;

      this.categories = categories;
    } catch (e) {
      if (isClosed) return;

      emit(
        CategoryOrderUpdateError(
          message: e.toString(),
        ),
      );
    }
  }

  // ============================================================
  // CHECK CATEGORY EXISTS
  // ============================================================

  Future<bool> checkCategoryExists(
      String id,
      ) async {
    if (isClosed) return false;

    try {
      return await _categoryRepo.checkCategoryExists(id);
    } catch (e) {
      return false;
    }
  }

  // ============================================================
  // CLOSE
  // ============================================================

  @override
  Future<void> close() async {
    // أوقف الـ stream أولًا
    await _categoriesSubscription?.cancel();

    _categoriesSubscription = null;

    // بعد كده اقفل Cubit
    return super.close();
  }
}