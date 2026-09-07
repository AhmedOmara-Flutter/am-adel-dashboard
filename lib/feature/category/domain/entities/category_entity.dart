class CategoryEntity {
  final String id;
  final String name;
  final List<String> sizes;
  final DateTime createdAt;
  final int sortOrder;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.sizes,
    required this.createdAt,
    required this.sortOrder,
  });
}