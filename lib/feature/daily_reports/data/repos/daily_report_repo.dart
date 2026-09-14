import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/daily_reports_entity.dart';

abstract class DailyReportRepo {
  Future<Either<Failure, String>> addDailyReport(
      DailyReportEntity report,
      );

  Stream<Either<Failure, List<DailyReportEntity>>> getDailyReports();

  Future<Either<Failure, void>> deleteDailyOrders();
  Future<Either<Failure, void>> deleteDailyReport(String reportId);
}