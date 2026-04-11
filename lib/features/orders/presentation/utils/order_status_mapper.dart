import 'package:flutter/material.dart';
import 'package:pharmacist/core/app_color.dart';

/// Mirrors backend `OrderStatus` enum order (values 0–9).
abstract final class OrderStatusMapper {
  static const int pending = 0;
  static const int processing = 1;
  static const int shipped = 2;
  static const int completed = 3;
  static const int cancelled = 4;
  static const int confirmed = 5;
  static const int returned = 6;
  static const int paymentFailed = 7;
  static const int expired = 8;
  static const int refunded = 9;

  /// Dropdown / PATCH: same order as backend enum (0 → 9).
  static const List<(int code, String label)> selectablePairs = [
    (pending, 'Pending'),
    (processing, 'Processing'),
    (shipped, 'Shipped'),
    (completed, 'Completed'),
    (cancelled, 'Cancelled'),
    (confirmed, 'Confirmed'),
    (returned, 'Returned'),
    (paymentFailed, 'Payment failed'),
    (expired, 'Expired'),
    (refunded, 'Refunded'),
  ];

  static String normalizeKey(String raw) {
    return raw.toLowerCase().trim().replaceAll(RegExp(r'\s+'), ' ');
  }

  /// Parses API value: integer string `0`–`9` or enum name / common labels.
  static int codeFromApiStatus(String raw) {
    final trimmed = raw.trim();
    final asInt = int.tryParse(trimmed);
    if (asInt != null && asInt >= pending && asInt <= refunded) {
      return asInt;
    }

    final n = normalizeKey(trimmed);
    final compact = n.replaceAll(' ', '');

    if (n == 'pending' || n == 'new') return pending;
    if (n == 'processing' || n.contains('process')) return processing;
    if (n == 'shipped' || n.contains('ship')) return shipped;
    if (n == 'completed' || n.contains('complete')) return completed;
    if (n == 'cancelled' || n == 'canceled' || n.contains('cancel')) {
      return cancelled;
    }
    if (n == 'confirmed' || n.contains('confirm')) return confirmed;
    if (n == 'returned' || n.contains('return')) return returned;
    if (compact == 'paymentfailed' ||
        n.contains('payment failed') ||
        n.contains('paymentfail')) {
      return paymentFailed;
    }
    if (n == 'expired' || n.contains('expir')) return expired;
    if (n == 'refunded' || n.contains('refund')) return refunded;

    return pending;
  }

  /// Fulfillment stepper: Pending → Confirmed → Processing → Shipped → Completed.
  /// Returns `0`–`4` for those steps, or negative codes for terminal/problem states
  /// (see [terminalBannerForStepperCode]).
  static int stepperVisualIndexFromStatusCode(int code) {
    switch (code) {
      case pending:
        return 0;
      case confirmed:
        return 1;
      case processing:
        return 2;
      case shipped:
        return 3;
      case completed:
        return 4;
      case cancelled:
        return -1;
      case returned:
        return -2;
      case paymentFailed:
        return -3;
      case expired:
        return -4;
      case refunded:
        return -5;
      default:
        return 0;
    }
  }

  static int stepperIndexFromApiStatus(String raw) {
    return stepperVisualIndexFromStatusCode(codeFromApiStatus(raw));
  }

  static String? terminalBannerForStepperCode(int negativeCode) {
    switch (negativeCode) {
      case -1:
        return 'This order is cancelled';
      case -2:
        return 'This order was returned';
      case -3:
        return 'Payment failed for this order';
      case -4:
        return 'This order has expired';
      case -5:
        return 'This order was refunded';
      default:
        return null;
    }
  }

  static String labelForCode(int code) {
    for (final pair in selectablePairs) {
      if (pair.$1 == code) return pair.$2;
    }
    return 'Pending';
  }

  static Color accentColorForStatus(String raw) {
    return accentColorForStatusCode(codeFromApiStatus(raw));
  }

  static Color accentColorForStatusCode(int code) {
    switch (code) {
      case completed:
        return Colors.green;
      case cancelled:
      case paymentFailed:
        return Colors.red;
      case pending:
        return Colors.orange;
      case confirmed:
        return AppColors.primaryLightColor;
      case processing:
      case shipped:
        return AppColors.primaryblue;
      case returned:
        return Colors.amber.shade800;
      case expired:
        return Colors.blueGrey;
      case refunded:
        return Colors.deepPurple;
      default:
        return AppColors.primaryblue;
    }
  }
}
