import 'dart:convert';
import '../../domain/models/mqtt_message.dart';

class PayloadFormatter {
  static String formatPayload(dynamic payload, PayloadType type, {bool pretty = false}) {
    switch (type) {
      case PayloadType.json:
        return _formatJson(payload, pretty);
      case PayloadType.xml:
        return _formatXml(payload, pretty);
      case PayloadType.binary:
        return _formatBinary(payload);
      default:
        return payload?.toString() ?? '';
    }
  }

  static String _formatJson(dynamic payload, bool pretty) {
    if (payload is String) {
      try {
        final decoded = json.decode(payload);
        return pretty
            ? JsonEncoder.withIndent('  ').convert(decoded)
            : json.encode(decoded);
      } catch (_) {
        return payload;
      }
    }
    return payload?.toString() ?? '';
  }

  static String _formatXml(dynamic payload, bool pretty) {
    if (payload is String) {
      // Basic XML formatting - could be enhanced with proper XML parser
      if (pretty) {
        return payload.replaceAll('><', '>\n<');
      }
      return payload;
    }
    return payload?.toString() ?? '';
  }

  static String _formatBinary(dynamic payload) {
    if (payload is List<int>) {
      return payload.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join(' ');
    }
    return payload?.toString() ?? '';
  }

  static String formatForDisplay(String payload, {int maxLength = 1000}) {
    final truncated = payload.length > maxLength
        ? '${payload.substring(0, maxLength)}...'
        : payload;

    // Replace non-printable characters
    return truncated.replaceAll(RegExp(r'[\x00-\x1F\x7F-\x9F]'), '�');
  }
}