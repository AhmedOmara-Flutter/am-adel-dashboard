import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/repos/cart_status_repo.dart';

part 'cart_status_state.dart';

class CartStatusCubit extends Cubit<CartStatusState> {
  final CartStatusRepo _cartStatusRepo;

  CartStatusCubit(this._cartStatusRepo,) : super(CartStatusInitial());

  Future<void> checkCartsStatus() async {
    emit(CartStatusLoading());

    try {
      final areAllCartsEmpty =
      await _cartStatusRepo.areAllCartsEmpty();

      emit(
        CartStatusLoaded(
          areAllCartsEmpty: areAllCartsEmpty,
        ),
      );
    } catch (e) {
      emit(
        CartStatusError(
          message: e.toString(),
        ),
      );
    }
  }
}