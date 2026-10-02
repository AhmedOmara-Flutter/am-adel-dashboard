import '../../../../core/services/database_services.dart';
import '../../data/repos/cart_status_repo.dart';

class CartStatusRepoImpl implements CartStatusRepo {
  final DatabaseServices _databaseServices;

  CartStatusRepoImpl(this._databaseServices);

  @override
  Future<bool> areAllCartsEmpty() async {
    try {
      return await _databaseServices.areAllCartsEmpty();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}