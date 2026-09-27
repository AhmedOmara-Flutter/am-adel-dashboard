import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../core/services/database_services.dart';
import '../../../../../core/services/notification_service.dart';
import '../../../../../core/services/services_locator.dart';
import '../../../data/repos/coupon_repo.dart';
import '../../../domain/entities/coupon_entity.dart';

part 'add_coupon_state.dart';

class AddCouponCubit extends Cubit<AddCouponState> {
  final CouponRepo couponRepo;

  AddCouponCubit(this.couponRepo) : super(AddCouponInitial());

  Future<void> addCoupon({
    required String userId,
    required CouponEntity coupon,
  }) async {
    emit(AddCouponLoading());

    final result = await couponRepo.addCoupon(
      userId,
      coupon,
    );

    await result.fold(
          (failure) async {
        emit(
          AddCouponFailure(failure.errMessage),
        );
      },
          (_) async {
        await _sendCouponNotification(
          userId: userId,
          coupon: coupon,
        );

        emit(AddCouponSuccess());
      },
    );
  }

  Future<void> _sendCouponNotification({
    required String userId,
    required CouponEntity coupon,
  }) async {
    try {
      final userData = await instance<DatabaseServices>().getData(
        path: 'users',
        uId: userId,
      );

      final fcmToken = userData['fcmToken']?.toString();

      if (fcmToken == null || fcmToken.isEmpty) {
        return;
      }

      final discountText = coupon.discountType == 'percentage'
          ? '${coupon.discountValue.toStringAsFixed(0)}%'
          : '${coupon.discountValue.toStringAsFixed(0)} جنيه';

      await NotificationService.sendNotification(
        title: '🎁 كوبون خصم جديد ليك',
        body:
        'خصم $discountText بكود ${coupon.code} 🎉 '
            'على طلب بحد أدنى ${coupon.minimumOrder.toStringAsFixed(0)} جنيه.',
        fcmToken: fcmToken,
      );
    } catch (e) {
      print('❌ Coupon notification error: $e');
    }
  }
}