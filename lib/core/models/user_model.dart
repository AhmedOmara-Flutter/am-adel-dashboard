import 'package:am_adel_dashboard/core/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.userName,
    required super.email,
    required super.uId,
    required super.phone,
    required super.password,
    required super.createdAt
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      uId: json['uId'] ?? '',
      phone: json['phone'] ?? '',
      password: json['password'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      userName: user.userName,
      email: user.email,
      uId: user.uId,
      phone: user.phone,
      password: user.password,
      createdAt: user.createdAt,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      userName: userName,
      email: email,
      uId: uId,
      phone: phone,
      password: password,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'email': email,
      'uId': uId,
      'phone': phone,
      'password': password,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
