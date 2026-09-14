// import 'dart:ui';
//
// import 'package:flutter/material.dart';
//
// import '../utils/app_color.dart';
// import '../utils/style_manager.dart';
//
//
// class LoadingOverlay extends StatelessWidget {
//   final bool isLoading;
//   final String title;
//   final String? subtitle;
//
//   const LoadingOverlay({
//     super.key,
//     required this.isLoading,
//     this.title = 'جاري التحميل...',
//     this.subtitle,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     if (!isLoading) return const SizedBox.shrink();
//
//     return Positioned.fill(
//       child: AbsorbPointer(
//         absorbing: true,
//         child: BackdropFilter(
//           filter: ImageFilter.blur(
//             sigmaX: 6,
//             sigmaY: 6,
//           ),
//           child: Container(
//             color: Colors.black.withOpacity(.25),
//             child: Center(
//               child: Container(
//                 width: 190,
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 24,
//                   vertical: 28,
//                 ),
//                 decoration: BoxDecoration(
//                   color: AppColor.card,
//                   borderRadius: BorderRadius.circular(24),
//                   border: Border.all(
//                     color: AppColor.mainColor.withOpacity(.25),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(.25),
//                       blurRadius: 25,
//                       offset: const Offset(0, 10),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const SizedBox(
//                       width: 42,
//                       height: 42,
//                       child: CircularProgressIndicator(
//                         strokeWidth: 3,
//                         color: AppColor.mainColor,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Text(
//                       title,
//                       textAlign: TextAlign.center,
//                       style: StyleManager.font13Weight400(context).copyWith(
//                         color: AppColor.mainColor,
//
//                       ),
//                     ),
//                     if (subtitle != null) ...[
//                       const SizedBox(height: 8),
//                       Text(
//                         subtitle!,
//                         textAlign: TextAlign.center,
//                         style: StyleManager.font12Weight500(context).copyWith(
//                         ),
//                       ),
//                     ],
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }