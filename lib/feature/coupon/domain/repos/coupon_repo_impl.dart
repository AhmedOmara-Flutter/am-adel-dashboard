import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/entities/user_entity.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/database_services.dart';
import '../../data/models/coupon_model.dart';
import '../../data/repos/coupon_repo.dart';
import '../../domain/entities/coupon_entity.dart';
import '../../domain/entities/user_coupon_entity.dart';

class CouponRepoImpl implements CouponRepo {
  final DatabaseServices _databaseServices;

  CouponRepoImpl(this._databaseServices);

  static const String _collection = 'users';

  @override
  Future<Either<Failure, void>> addCoupon(
      String userId,
      CouponEntity coupon,
      ) async {
    try {
      final data = await _databaseServices.getData(
        path: _collection,
        uId: userId,
      );

      final userData = Map<String, dynamic>.from(data);

      final List coupons = userData['coupons'] as List? ?? [];

      final couponModel = CouponModel.fromEntity(coupon);

      coupons.add(couponModel.toJson());

      await _databaseServices.updateData(
        path: _collection,
        docId: userId,
        data: {
          'coupons': coupons,
        },
      );

      return const Right(null);
    } catch (e) {
      return Left(
        ServerFailure(
          errMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Stream<Either<Failure, List<UserCouponEntity>>> getCoupons() async* {
    try {
      await for (final data in _databaseServices.getStreamData(
        path: _collection,
      )) {
        final List users = data as List;

        final List<UserCouponEntity> userCoupons = [];

        for (final user in users) {
          final userData = Map<String, dynamic>.from(user);

          final List coupons = userData['coupons'] as List? ?? [];

          if (coupons.isEmpty) {
            continue;
          }

          final userEntity = UserEntity(
            userName: userData['userName'] ?? '',
            email: userData['email'] ?? '',
            uId: userData['uId'] ?? '',
            phone: userData['phone'] ?? '',
            password: userData['password'] ?? '',
            createdAt: userData['createdAt'] is Timestamp
                ? (userData['createdAt'] as Timestamp).toDate()
                : DateTime.fromMillisecondsSinceEpoch(0),
            coupons: coupons
                .map(
                  (json) => CouponModel.fromJson(
                Map<String, dynamic>.from(json),
              ).toEntity(),
            )
                .toList(),
          );

          for (final coupon in userEntity.coupons) {
            userCoupons.add(
              UserCouponEntity(
                user: userEntity,
                coupon: coupon,
              ),
            );
          }
        }

        yield Right(userCoupons);
      }
    } catch (e) {
      yield Left(
        ServerFailure(
          errMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteCoupon(
      String userId,
      String couponCode,
      ) async {
    try {
      final data = await _databaseServices.getData(
        path: _collection,
        uId: userId,
      );

      final userData = Map<String, dynamic>.from(data);

      final List coupons = userData['coupons'] as List? ?? [];

      coupons.removeWhere(
            (coupon) => coupon['code'] == couponCode,
      );

      await _databaseServices.updateData(
        path: _collection,
        docId: userId,
        data: {
          'coupons': coupons,
        },
      );

      return const Right(null);
    } catch (e) {
      return Left(
        ServerFailure(
          errMessage: e.toString(),
        ),
      );
    }
  }
}