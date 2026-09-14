// import 'dart:async';
// impackage:bloc/bloc.dart';
// import 'package:meta/meta.dart';
// import '../../../../../core/cubit/orders_cubit/orders_cubit.dart';
// import '../../../../../core/enums/order_enum.dart';
// import '../../data/repos/daily_report_repo.dart';
// import '../../domain/entities/daily_reports_entity.dart';
//
// part 'daily_reports_state.dart';
//
// class DailyReportsCubit extends Cubit<DailyReportsState> {
//   DailyReportsCubit(this._dailyReportRepo,
//       this._ordersCubit,) : super(DailyReportsInitial());
//
//   final DailyReportRepo _dailyReportRepo;
//   final OrdersCubit _ordersCubit;
//
//   List<DailyReportEntity> reports = [];
//   StreamSubscription? _subscription;
//
//   bool isClosing = false;
//
//   OrdersCubit get ordersCubit => _ordersCubit;
//
//   DailyReportEntity? report;
//
//   void getDailyReports() {
//     if (isClosing) return;
//
//     emit(DailyReportsLoading());
//
//     _subscription?.cancel();
//
//     _subscription = _dailyReportRepo.getDailyReports().listen(
//           (result) {
//         if (isClosing) return;
//
//         result.fold(
//               (failure) {
//             emit(
//               DailyReportsError(
//                 failure.errMessage,
//               ),
//             );
//           },
//               (reports) {
//             if (isClosing) return;
//
//             final sortedReports = [...reports]
//               ..sort(
//                     (a, b) => b.createdAt.compareTo(a.createdAt),
//               );
//
//             this.reports = sortedReports;
//
//             emit(
//               DailyReportsSuccess(
//                 sortedReports,
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   void calculateTodayReport() {
//     emit(DailyReportsLoading());
//
//     try {
//       final paidOrders = _ordersCubit.allOrders
//           .where(
//             (order) => order.status == OrderStatus.paid,
//       )
//           .toList();
//
//       final subtotal = paidOrders.fold<double>(
//         0.0,
//             (sum, order) => sum + order.cartEntity.getTotalPrice(),
//       );
//
//       final deliveryCost = paidOrders.fold<double>(
//         0.0,
//             (sum, order) =>
//         sum + (order.selectedLocationEntity?.cost ?? 0),
//       );
//
//       final cashTotal = paidOrders
//           .where(
//             (order) => order.isCashOnDelivery == true,
//       )
//           .fold<double>(
//         0.0,
//             (sum, order) =>
//         sum +
//             order.cartEntity.getTotalPrice() +
//             (order.selectedLocationEntity?.cost ?? 0),
//       );
//
//       final onlineTotal = paidOrders
//           .where(
//             (order) => order.isCashOnDelivery != true,
//       )
//           .fold<double>(
//         0.0,
//             (sum, order) =>
//         sum +
//             order.cartEntity.getTotalPrice() +
//             (order.selectedLocationEntity?.cost ?? 0),
//       );
//
//       report = DailyReportEntity(
//         date: DateTime.now(),
//         ordersCount: paidOrders.length,
//         subtotal: subtotal,
//         deliveryCost: deliveryCost,
//         total: subtotal + deliveryCost,
//         cashTotal: cashTotal,
//         onlineTotal: onlineTotal,
//         createdAt: DateTime.now(),
//       );
//
//       emit(
//         DailyReportsTodaySuccess(
//           report!,
//         ),
//       );
//     } catch (e) {
//       emit(
//         DailyReportsError(
//           e.toString(),
//         ),
//       );
//     }
//   }
//
//   Future<void> closeToday() async {
//     if (isClosing) return;
//
//     isClosing = true;
//
//     emit(DailyReportsClosing());
//
//     try {
//       final paidOrders = _ordersCubit.allOrders
//           .where(
//             (order) => order.status == OrderStatus.paid,
//       )
//           .toList();
//
//       final subtotal = paidOrders.fold<double>(
//         0.0,
//             (sum, order) => sum + order.cartEntity.getTotalPrice(),
//       );
//
//       final deliveryCost = paidOrders.fold<double>(
//         0.0,
//             (sum, order) =>
//         sum + (order.selectedLocationEntity?.cost ?? 0),
//       );
//
//       final cashTotal = paidOrders
//           .where(
//             (order) => order.isCashOnDelivery == true,
//       )
//           .fold<double>(
//         0.0,
//             (sum, order) =>
//         sum +
//             order.cartEntity.getTotalPrice() +
//             (order.selectedLocationEntity?.cost ?? 0),
//       );
//
//       final onlineTotal = paidOrders
//           .where(
//             (order) => order.isCashOnDelivery != true,
//       )
//           .fold<double>(
//         0.0,
//             (sum, order) =>
//         sum +
//             order.cartEntity.getTotalPrice() +
//             (order.selectedLocationEntity?.cost ?? 0),
//       );
//
//       final dailyReport = DailyReportEntity(
//         date: DateTime.now(),
//         ordersCount: paidOrders.length,
//         subtotal: subtotal,
//         deliveryCost: deliveryCost,
//         total: subtotal + deliveryCost,
//         cashTotal: cashTotal,
//         onlineTotal: onlineTotal,
//         createdAt: DateTime.now(),
//       );
//
//       final result = await _dailyReportRepo.addDailyReport(
//         dailyReport,
//       );
//
//       final reportId = result.fold(
//             (failure) => throw Exception(failure.errMessage),
//             (id) => id,
//       );
//
//       if (reportId.isEmpty) {
//         throw Exception('فشل حفظ جرد اليوم');
// }
//
//       final deleteResult =
//       await _dailyReportRepo.deleteDailyOrders();
//
//       deleteResult.fold(
//             (failure) => throw Exception(failure.errMessage),
//             (_) {},
//       );
//
//       report = dailyReport;
//
//       reports = [
//         dailyReport,
//         ...reports,
//       ];
//
//       isClosing = false;
//
//       emit(
//         DailyReportsClosed(),
//       );
//     } catch (e) {
//       isClosing = false;
//
//       emit(
//         DailyReportsCloseError(
//           e.toString(),
//         ),
//       );
//     }
//   }
//
//
//   Future<void> deleteDailyReport(String reportId) async {
//     final result = await _dailyReportRepo.deleteDailyReport(reportId);
//
//     result.fold(
//           (failure) {
//         emit(DailyReportsError(failure.errMessage));
//       },
//           (_) {
//         reports.removeWhere((report) => report.id == reportId);
//
//         emit(DailyReportsSuccess([...reports]));
//       },
//     );
//   }
//
//   @override
//   Future<void> close() {
//     _subscription?.cancel();
//     return super.close();
//   }
// }


import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/cubit/orders_cubit/orders_cubit.dart';
import '../../../../../core/enums/order_enum.dart';
import '../../data/repos/daily_report_repo.dart';
import '../../domain/entities/daily_reports_entity.dart';

part 'daily_reports_state.dart';

class DailyReportsCubit extends Cubit<DailyReportsState> {
  DailyReportsCubit(this._dailyReportRepo,
      this._ordersCubit,) : super(DailyReportsInitial());

  final DailyReportRepo _dailyReportRepo;
  final OrdersCubit _ordersCubit;

  List<DailyReportEntity> reports = [];
  StreamSubscription? _subscription;

  bool isClosing = false;

  OrdersCubit get ordersCubit => _ordersCubit;

  DailyReportEntity? report;

  void getDailyReports() {
    if (isClosing) return;

    emit(DailyReportsLoading());

    _subscription?.cancel();

    _subscription = _dailyReportRepo.getDailyReports().listen(
          (result) {
        if (isClosing) return;

        result.fold(
              (failure) {
            emit(
              DailyReportsError(
                failure.errMessage,
              ),
            );
          },
              (reports) {
            if (isClosing) return;

            final sortedReports = [...reports]
              ..sort(
                    (a, b) => b.createdAt.compareTo(a.createdAt),
              );

            this.reports = sortedReports;

            emit(
              DailyReportsSuccess(
                sortedReports,
              ),
            );
          },
        );
      },
    );
  }

  void calculateTodayReport() {
    emit(DailyReportsLoading());

    try {
      final paidOrders = _ordersCubit.allOrders
          .where(
            (order) => order.status == OrderStatus.paid,
      )
          .toList();

      final subtotal = paidOrders.fold<double>(
        0.0,
            (sum, order) => sum + order.cartEntity.getTotalPrice(),
      );

      final deliveryCost = paidOrders.fold<double>(
        0.0,
            (sum, order) =>
        sum + (order.selectedLocationEntity?.cost ?? 0),
      );

      final cashTotal = paidOrders
          .where(
            (order) => order.isCashOnDelivery == true,
      )
          .fold<double>(
        0.0,
            (sum, order) =>
        sum +
            order.cartEntity.getTotalPrice() +
            (order.selectedLocationEntity?.cost ?? 0),
      );

      final onlineTotal = paidOrders
          .where(
            (order) => order.isCashOnDelivery != true,
      )
          .fold<double>(
        0.0,
            (sum, order) =>
        sum +
            order.cartEntity.getTotalPrice() +
            (order.selectedLocationEntity?.cost ?? 0),
      );

      report = DailyReportEntity(
        date: DateTime.now(),
        ordersCount: paidOrders.length,
        subtotal: subtotal,
        deliveryCost: deliveryCost,
        total: subtotal + deliveryCost,
        cashTotal: cashTotal,
        onlineTotal: onlineTotal,
        createdAt: DateTime.now(),
      );

      emit(
        DailyReportsTodaySuccess(
          report!,
        ),
      );
    } catch (e) {
      emit(
        DailyReportsError(
          e.toString(),
        ),
      );
    }
  }

  Future<void> closeToday() async {
    if (isClosing) return;

    isClosing = true;

    emit(DailyReportsClosing());

    try {
      final paidOrders = _ordersCubit.allOrders
          .where(
            (order) => order.status == OrderStatus.paid,
      )
          .toList();

      final subtotal = paidOrders.fold<double>(
        0.0,
            (sum, order) => sum + order.cartEntity.getTotalPrice(),
      );

      final deliveryCost = paidOrders.fold<double>(
        0.0,
            (sum, order) =>
        sum + (order.selectedLocationEntity?.cost ?? 0),
      );

      final cashTotal = paidOrders
          .where(
            (order) => order.isCashOnDelivery == true,
      )
          .fold<double>(
        0.0,
            (sum, order) =>
        sum +
            order.cartEntity.getTotalPrice() +
            (order.selectedLocationEntity?.cost ?? 0),
      );

      final onlineTotal = paidOrders
          .where(
            (order) => order.isCashOnDelivery != true,
      )
          .fold<double>(
        0.0,
            (sum, order) =>
        sum +
            order.cartEntity.getTotalPrice() +
            (order.selectedLocationEntity?.cost ?? 0),
      );

      final dailyReport = DailyReportEntity(
        date: DateTime.now(),
        ordersCount: paidOrders.length,
        subtotal: subtotal,
        deliveryCost: deliveryCost,
        total: subtotal + deliveryCost,
        cashTotal: cashTotal,
        onlineTotal: onlineTotal,
        createdAt: DateTime.now(),
      );

      final result = await _dailyReportRepo.addDailyReport(
        dailyReport,
      );

      final reportId = result.fold(
            (failure) => throw Exception(failure.errMessage),
            (id) => id,
      );

      if (reportId.isEmpty) {
        throw Exception('فشل حفظ جرد اليوم');
      }

      dailyReport.id = reportId;

      final deleteResult =
      await _dailyReportRepo.deleteDailyOrders();

      deleteResult.fold(
            (failure) => throw Exception(failure.errMessage),
            (_) {},
      );

      report = dailyReport;

      reports = [
        dailyReport,
        ...reports,
      ];

      isClosing = false;

      emit(
        DailyReportsClosed(),
      );
    } catch (e) {
      isClosing = false;

      emit(
        DailyReportsCloseError(
          e.toString(),
        ),
      );
    }
  }

  Future<void> deleteDailyReport(String reportId) async {
    final result =
    await _dailyReportRepo.deleteDailyReport(reportId);

    result.fold(
          (failure) {
        emit(
          DailyReportsError(
            failure.errMessage,
          ),
        );
      },
          (_) {
        reports.removeWhere(
              (report) => report.id == reportId,
        );

        emit(
          DailyReportsSuccess(
            [...reports],
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
}
}
