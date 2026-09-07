part of 'category_cubit.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryGetLoading extends CategoryState {}

final class CategoryGetSuccess extends CategoryState {
  final List<CategoryEntity> categories;

  CategoryGetSuccess({required this.categories});
}

final class CategoryGetError extends CategoryState {
  final String message;

  CategoryGetError({required this.message});
}

final class CategoryAddLoading extends CategoryState {}

final class CategoryAddSuccess extends CategoryState {}

final class CategoryAddError extends CategoryState {
  final String message;

  CategoryAddError({required this.message});
}

final class CategoryUpdateLoading extends CategoryState {}

final class CategoryUpdateSuccess extends CategoryState {}

final class CategoryUpdateError extends CategoryState {
  final String message;

  CategoryUpdateError({required this.message});
}

final class CategoryDeleteLoading extends CategoryState {}

final class CategoryDeleteSuccess extends CategoryState {}

final class CategoryDeleteError extends CategoryState {
  final String message;

  CategoryDeleteError({required this.message});
}

final class CategoryDeleteAllLoading extends CategoryState {}

final class CategoryDeleteAllSuccess extends CategoryState {}

final class CategoryDeleteAllError extends CategoryState {
  final String message;

  CategoryDeleteAllError({required this.message});
}

final class CategoryOrderUpdateError extends CategoryState {
  final String message;

  CategoryOrderUpdateError({required this.message});
}
