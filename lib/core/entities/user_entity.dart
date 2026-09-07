class UserEntity {
  final String userName;
  final String email;
  final String uId;
  final String phone;
  final String password;
  final DateTime createdAt;

  UserEntity({
    required this.userName,
    required this.email,
    required this.uId,
    required this.phone,
    required this.password,
    required this.createdAt,
  });
}
