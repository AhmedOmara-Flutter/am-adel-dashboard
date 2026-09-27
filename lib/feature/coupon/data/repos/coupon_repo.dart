import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/coupon_entity.dart';
import '../../domain/entities/user_coupon_entity.dart';

abstract class CouponRepo {
  Future<Either<Failure, void>> addCoupon(
      String userId,
      CouponEntity coupon,
      );

  Stream<Either<Failure, List<UserCouponEntity>>> getCoupons();

  Future<Either<Failure, void>> deleteCoupon(
      String userId,
      String couponCode,
      );
}