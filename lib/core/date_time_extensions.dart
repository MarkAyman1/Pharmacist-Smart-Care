DateTime parseUtcOrderDate(String timestamp) {
  final raw = timestamp.trim();
  final hasOffset = raw.endsWith('Z') || RegExp(r'[+-]\d{2}:\d{2}\$').hasMatch(raw);
  if (hasOffset) {
    return DateTime.parse(raw).toUtc();
  }

  final local = DateTime.parse(raw);
  return DateTime.utc(
    local.year,
    local.month,
    local.day,
    local.hour,
    local.minute,
    local.second,
    local.millisecond,
    local.microsecond,
  );
}

extension EgyptDateTimeExtension on DateTime {
  /// Converts a UTC order timestamp to Egypt local time (UTC+3).
  DateTime get egyptTime => toUtc().add(const Duration(hours: 3));
}
