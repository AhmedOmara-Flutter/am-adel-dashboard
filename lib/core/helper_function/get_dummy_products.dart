import '../entities/product_entity.dart';

ProductEntity getDummyProduct = ProductEntity(
  name: 'Organic Apple',
  code: '',
  price: 0,
  description: '',
  imageFile: null,
  isFeatured: true,
  image:'https://wplubouwksawibitfhlj.supabase.co/storage/v1/object/public/images/1776777319219_1000288651.jpg',
  expirationMonth: 1,
  unitAmount: 1,
  numberOfCalories: 95,
  isOrganic: true,
  sellingCount: 300,
  id: '',
  subImages: [],
  averageRating: 4.5,
  reviewsCount: 100,
  ratingSum: 450.0, category: '', createdAt: '',

);

List<ProductEntity>get getDummyProducts {
  return [
    getDummyProduct,
    getDummyProduct,
    getDummyProduct,
    getDummyProduct,
    getDummyProduct,
    getDummyProduct,
    getDummyProduct,
    getDummyProduct,
  ];
}
