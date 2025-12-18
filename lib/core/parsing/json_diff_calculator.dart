import 'dart:convert';

class JsonDiffCalculator {
  static Map<String, dynamic>? calculateDiff(String oldJson, String newJson) {
    try {
      final oldMap = json.decode(oldJson) as Map<String, dynamic>;
      final newMap = json.decode(newJson) as Map<String, dynamic>;

      return _calculateMapDiff(oldMap, newMap);
    } catch (_) {
      return null; // Not valid JSON
    }
  }

  static Map<String, dynamic> _calculateMapDiff(
      Map<String, dynamic> oldMap, Map<String, dynamic> newMap) {
    final diff = <String, dynamic>{};

    // Find added/modified keys
    for (final entry in newMap.entries) {
      final key = entry.key;
      final newValue = entry.value;
      final oldValue = oldMap[key];

      if (!oldMap.containsKey(key)) {
        // Added
        diff[key] = {'type': 'added', 'value': newValue};
      } else if (!_areEqual(oldValue, newValue)) {
        // Modified
        if (oldValue is Map<String, dynamic> && newValue is Map<String, dynamic>) {
          final nestedDiff = _calculateMapDiff(oldValue, newValue);
          if (nestedDiff.isNotEmpty) {
            diff[key] = {'type': 'modified', 'diff': nestedDiff};
          }
        } else if (oldValue is List && newValue is List) {
          final listDiff = _calculateListDiff(oldValue, newValue);
          if (listDiff.isNotEmpty) {
            diff[key] = {'type': 'modified', 'diff': listDiff};
          }
        } else {
          diff[key] = {'type': 'modified', 'old': oldValue, 'new': newValue};
        }
      }
    }

    // Find removed keys
    for (final key in oldMap.keys) {
      if (!newMap.containsKey(key)) {
        diff[key] = {'type': 'removed', 'value': oldMap[key]};
      }
    }

    return diff;
  }

  static List<Map<String, dynamic>> _calculateListDiff(List oldList, List newList) {
    final diff = <Map<String, dynamic>>[];

    final maxLength = oldList.length > newList.length ? oldList.length : newList.length;

    for (int i = 0; i < maxLength; i++) {
      if (i >= oldList.length) {
        // Added
        diff.add({'index': i, 'type': 'added', 'value': newList[i]});
      } else if (i >= newList.length) {
        // Removed
        diff.add({'index': i, 'type': 'removed', 'value': oldList[i]});
      } else if (!_areEqual(oldList[i], newList[i])) {
        // Modified
        diff.add({'index': i, 'type': 'modified', 'old': oldList[i], 'new': newList[i]});
      }
    }

    return diff;
  }

  static bool _areEqual(dynamic a, dynamic b) {
    if (a == b) return true;
    if (a is Map && b is Map) {
      return _mapsEqual(a, b);
    }
    if (a is List && b is List) {
      return _listsEqual(a, b);
    }
    return false;
  }

  static bool _mapsEqual(Map a, Map b) {
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (!b.containsKey(key) || !_areEqual(a[key], b[key])) return false;
    }
    return true;
  }

  static bool _listsEqual(List a, List b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (!_areEqual(a[i], b[i])) return false;
    }
    return true;
  }
}