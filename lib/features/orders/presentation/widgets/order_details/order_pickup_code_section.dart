// import 'package:flutter/material.dart';
// import 'package:pharmacist/core/app_color.dart';

// class OrderPickupCodeSection extends StatelessWidget {
//   const OrderPickupCodeSection({super.key, required this.code});

//   final String code;

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return Padding(
//       padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
//       child: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(18),
//           gradient: LinearGradient(
//             colors: [
//               AppColors.primaryLightColor.withValues(alpha: 0.2),
//               AppColors.accentGreen.withValues(alpha: 0.5),
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           border: Border.all(
//             color: AppColors.primaryblue.withValues(alpha: 0.25),
//           ),
//         ),
//         child: Row(
//           children: [
//             Icon(
//               Icons.qr_code_2_rounded,
//               size: 40,
//               color: isDark ? AppColors.darkOnSurface : AppColors.primaryblue,
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Pickup code',
//                     style: Theme.of(context).textTheme.labelSmall?.copyWith(
//                           fontWeight: FontWeight.w600,
//                           color: isDark
//                               ? AppColors.darkMediumGrey
//                               : AppColors.mediumGrey,
//                         ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     code,
//                     style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                           letterSpacing: 4,
//                           fontWeight: FontWeight.w800,
//                           color: AppColors.primaryLightColor,
//                         ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
