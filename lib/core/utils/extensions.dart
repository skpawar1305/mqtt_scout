extension StringExtensions on String {
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String get truncate {
    if (length <= 100) return this;
    return '${substring(0, 97)}...';
  }

  bool get isValidMqttTopic {
    if (isEmpty) return false;
    // Basic MQTT topic validation
    return !contains('\u0000') && !contains('\u0001') && !contains('\u0002');
  }
}

extension DateTimeExtensions on DateTime {
  String get formattedTime {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}';
  }

  String get formattedDateTime {
    return '${year}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')} $formattedTime';
  }
}

extension IterableExtensions<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;

  T? get lastOrNull => isEmpty ? null : last;
}