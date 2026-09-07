import '../../../../core/services/database_services.dart';
import '../../data/repos/cart_status_repo.dart';

class CartStatusRepoImpl implements CartStatusRepo {
  final DatabaseServices databaseServices;

  CartStatusRepoImpl({
    required this.databaseServices,
  });

  @override
  Future<bool> areAllCartsEmpty() async {
    try {
      return await databaseServices.areAllCartsEmpty();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}