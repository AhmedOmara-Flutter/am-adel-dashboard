import 'package:dartz/dartz.dart';
import 'package:am_adel_dashboard/core/errors/failure.dart';
import 'package:am_adel_dashboard/core/entities/user_entity.dart';

abstract class ClientsRepo {
  Stream<Either<Failure,List<UserEntity>>>getClients();
}