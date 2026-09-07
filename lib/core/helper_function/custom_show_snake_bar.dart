
import 'package:flutter/material.dart';

void customShowSnakeBar(
  BuildContext context, {
  required Color color,
  required String label,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      behavior:SnackBarBehavior.floating,
      content: Text(label),
    ),
  );
}
