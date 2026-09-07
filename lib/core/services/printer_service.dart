// import 'dart:convert';
// import 'dart:io';
//
// import '../entities/order_entity.dart';
//
// class PrintService {
//   static Future<void> printOrder(OrderEntity order) async {
//     final subTotal = order.cartEntity.getTotalPrice();
//     final shipping = order.selectedLocationEntity?.cost ?? 0.0;
//     final total = subTotal + shipping;
//     final json = {
//       "OrderNumber": order.id ?? "",
//       "CustomerName": order.userEntity?.userName ?? "",
//       "Phone": order.userEntity?.phone ?? "",
//       "Address": order.addressEntity?.address ?? "",
//       "DeliveryArea": order.selectedLocationEntity?.title ?? "",
//       "SubTotal": subTotal,
//       "Shipping": shipping,
//       "Total": total,
//       "OrderNote": order.orderNote ?? "",
//       "PaymentMethod": (order.isCashOnDelivery ?? true) ? "Cash" : "Online",
//       "OrderDate": DateTime.now().toIso8601String(),
//       "Items": order.cartEntity.cartItems
//           .map(
//             (e) => {
//               "Name": e.product.name,
//               "Quantity": e.quantity,
//               "Category": e.product.category,
//               "Size": e.product.size ?? "",
//               "Price": e.unitPrice,
//             },
//           )
//           .toList(),
//     };
//
//     final jsonFile = File(
//       "order_${order.id}_${DateTime.now().microsecondsSinceEpoch}.json",
//     );
//
//     await jsonFile.writeAsString(jsonEncode(json), encoding: utf8);
//
//     final exe = File("printer/PrintService.exe");
//
//     if (!exe.existsSync()) {
//       throw Exception("PrintService.exe not found: ${exe.absolute.path}");
//     }
//
//     final result = await Process.run(exe.absolute.path, [
//       jsonFile.absolute.path,
//     ]);
//
//     if (result.exitCode != 0) {
//       throw Exception(result.stderr.toString());
//     }
//
//     if (await jsonFile.exists()) {
//       await jsonFile.delete();
//     }
//   }
// }


import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import '../entities/order_entity.dart';

class PrinterService {
  static const String _printCopiesKey = 'print_copies';

  static Future<int> getPrintCopies() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_printCopiesKey) ?? 1;
  }

  static Future<void> setPrintCopies(int copies) async {
    if (copies != 1 && copies != 2) {
      throw ArgumentError('Print copies must be 1 or 2');
    }

    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(
      _printCopiesKey,
      copies,
    );
  }

  static Future<void> printOrder(
      OrderEntity order,
      ) async {
    final subTotal =
    order.cartEntity.getTotalPrice();

    final shipping =
        order.selectedLocationEntity?.cost ?? 0.0;

    final total =
        subTotal + shipping;

    final json = {
      "OrderNumber": order.id ?? "",
      "CustomerName":
      order.userEntity?.userName ?? "",
      "Phone":
      order.userEntity?.phone ?? "",
      "Address":
      order.addressEntity?.address ?? "",
      "DeliveryArea":
      order.selectedLocationEntity?.title ?? "",
      "SubTotal": subTotal,
      "Shipping": shipping,
      "Total": total,
      "OrderNote":
      order.orderNote ?? "",
      "PaymentMethod":
      (order.isCashOnDelivery ?? true)
          ? "Cash"
          : "Online",
      "OrderDate":
      DateTime.now().toIso8601String(),
      "Items": order.cartEntity.cartItems
          .map(
            (e) => {
          "Name": e.product.name,
          "Quantity": e.quantity,
          "Category": e.product.category,
          "Size": e.product.size ?? "",
          "Price": e.unitPrice,
        },
      )
          .toList(),
    };

    final jsonFile = File(
      "order_${order.id}_${DateTime.now().microsecondsSinceEpoch}.json",
    );

    await jsonFile.writeAsString(
      jsonEncode(json),
      encoding: utf8,
    );

    try {
      final copies = await getPrintCopies();

      final exeName =
      copies == 2
          ? "PrintService2.exe"
          : "PrintService.exe";

      final exe = File(
        "printer/$exeName",
      );

      if (!exe.existsSync()) {
        throw Exception(
          "$exeName not found: ${exe.absolute.path}",
        );
      }

      final result = await Process.run(
        exe.absolute.path,
        [
          jsonFile.absolute.path,
        ],
      );

      if (result.exitCode != 0) {
        throw Exception(
          result.stderr.toString(),
        );
      }
    } finally {
      if (await jsonFile.exists()) {
        await jsonFile.delete();
      }
    }
  }
}