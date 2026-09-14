part of 'daily_reports_cubit.dart';

@immutable
sealed class DailyReportsState {}

final class DailyReportsInitial extends DailyReportsState {}

final class DailyReportsLoading extends DailyReportsState {}

final class DailyReportsSuccess extends DailyReportsState {
  final List<DailyReportEntity> reports;

  DailyReportsSuccess(this.reports);
}

final class DailyReportsTodaySuccess extends DailyReportsState {
  final DailyReportEntity report;

  DailyReportsTodaySuccess(this.report);
}

final class DailyReportsError extends DailyReportsState {
  final String message;

  DailyReportsError(this.message);
}

final class DailyReportsClosing extends DailyReportsState {}

final class DailyReportsClosed extends DailyReportsState {}

final class DailyReportsCloseError extends DailyReportsState {
  final String message;

  DailyReportsCloseError(this.message);
}