import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/services/database_services.dart';
import '../../data/models/daily_reports_model.dart';
import '../../data/repos/daily_report_repo.dart';
import '../entities/daily_reports_entity.dart';

class DailyReportRepoImpl implements DailyReportRepo {
  final DatabaseServices _databaseServices;

  DailyReportRepoImpl(this._databaseServices);

  @override
  Future<Either<Failure, String>> addDailyReport(
      DailyReportEntity report,
      ) async {
    try {
      final docRef = await _databaseServices.addData(
        path: 'daily_reports',
        data: DailyReportModel.fromEntity(report).toJson(),
      );

      return Right(docRef);
    } on Exception catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<DailyReportEntity>>> getDailyReports() async* {
    try {
      await for (var (data as List<Map<String, dynamic>>)
      in _databaseServices.getStreamData(
        path: 'daily_reports',
        query: {
          'orderBy': 'date',
          'descending': true,
        },
      )) {
        final List<DailyReportEntity> reports = data
            .map(
              (e) => DailyReportModel.fromJson(e).toEntity(),
        )
            .toList();

        yield Right(reports);
      }
    } on Exception catch (e) {
      yield Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteDailyOrders() async {
    try {
      final res = await _databaseServices.deleteCollection('orders');

      return Right(res);
    } on Exception catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteDailyReport(
      String reportId,
      ) async {
    try {
      await _databaseServices.deleteData(
        path: 'daily_reports',
        uId: reportId,
      );


      return const Right(null);
    } on Exception catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
}