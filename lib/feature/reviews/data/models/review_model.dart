
import 'package:am_adel_dashboard/feature/reviews/domain/entities/review_entity.dart';

class ReviewModel extends ReviewEntity {
  ReviewModel({
    required super.name,
    required super.reviewDescription,
    required super.rating,
    required super.date,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      name: json['name'],
      reviewDescription: json['reviewDescription'],
      rating: json['rating'],
      date: json['date'],
    );
  }

  factory ReviewModel.fromEntity(ReviewEntity entity) {
    return ReviewModel(
      name: entity.name,
      reviewDescription: entity.reviewDescription,
      rating: entity.rating,
      date: entity.date,
    );
  }

  ReviewEntity toEntity() {
    return ReviewEntity(
      name: name,
      reviewDescription: reviewDescription,
      rating: rating,
      date: date,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'reviewDescription': reviewDescription,
      'rating': rating,
      'date': date,
    };
  }
}
