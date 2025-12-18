import '../../domain/models/mqtt_message.dart';

class PayloadParser {
  static PayloadType detectType(String payload) {
    if (payload.trim().isEmpty) return PayloadType.empty;

    // Try to parse as JSON
    try {
      final decoded = _parseJson(payload);
      if (decoded != null) return PayloadType.json;
    } catch (_) {}

    // Try to parse as XML
    if (_isXml(payload)) return PayloadType.xml;

    // Try to parse as number
    if (_isNumber(payload)) return PayloadType.number;

    // Try to parse as boolean
    if (_isBoolean(payload)) return PayloadType.boolean;

    // Check if it's binary (contains non-printable characters)
    if (_isBinary(payload)) return PayloadType.binary;

    return PayloadType.text;
  }

  static dynamic parsePayload(String payload, PayloadType type) {
    switch (type) {
      case PayloadType.json:
        return _parseJson(payload);
      case PayloadType.xml:
        return payload; // Keep as string for now
      case PayloadType.number:
        return num.tryParse(payload);
      case PayloadType.boolean:
        return payload.toLowerCase() == 'true';
      case PayloadType.binary:
        return payload.codeUnits; // Return as bytes
      case PayloadType.text:
      case PayloadType.empty:
      default:
        return payload;
    }
  }

  static dynamic _parseJson(String payload) {
    // Simple JSON detection - could be enhanced
    final trimmed = payload.trim();
    if ((trimmed.startsWith('{') && trimmed.endsWith('}')) ||
        (trimmed.startsWith('[') && trimmed.endsWith(']'))) {
      // For now, just return the string - proper parsing would require json.decode
      return payload;
    }
    return null;
  }

  static bool _isXml(String payload) {
    final trimmed = payload.trim();
    return trimmed.startsWith('<') && trimmed.endsWith('>');
  }

  static bool _isNumber(String payload) {
    return num.tryParse(payload.trim()) != null;
  }

  static bool _isBoolean(String payload) {
    final lower = payload.trim().toLowerCase();
    return lower == 'true' || lower == 'false';
  }

  static bool _isBinary(String payload) {
    return payload.codeUnits.any((byte) => byte < 32 && byte != 9 && byte != 10 && byte != 13);
  }
}