import 'dart:convert';
import 'dart:typed_data';
import '../../domain/models/mqtt_message.dart';

/// Intelligent payload parser that auto-detects content type and provides formatting
class PayloadParser {
  /// Detect the type of payload content
  static PayloadType detectType(String payload) {
    if (payload.trim().isEmpty) return PayloadType.empty;

    // Try JSON first (most common)
    try {
      jsonDecode(payload);
      return PayloadType.json;
    } catch (_) {}

    // Try number
    if (_isNumeric(payload.trim())) {
      return PayloadType.number;
    }

    // Try boolean
    if (_isBoolean(payload.trim())) {
      return PayloadType.boolean;
    }

    // Try XML
    if (_isXml(payload)) {
      return PayloadType.xml;
    }

    // Check for binary content (non-printable characters)
    if (_hasBinaryContent(payload)) {
      return PayloadType.binary;
    }

    // Default to text
    return PayloadType.text;
  }

  /// Parse payload based on detected type
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

  /// Format payload for display based on its type
  static String format(String payload, PayloadType type) {
    switch (type) {
      case PayloadType.json:
        return _formatJson(payload);
      case PayloadType.xml:
        return _formatXml(payload);
      case PayloadType.empty:
        return '(empty)';
      default:
        return payload;
    }
  }

  /// Get a human-readable description of the payload type
  static String getTypeDescription(PayloadType type) {
    switch (type) {
      case PayloadType.empty:
        return 'Empty';
      case PayloadType.json:
        return 'JSON';
      case PayloadType.xml:
        return 'XML';
      case PayloadType.text:
        return 'Text';
      case PayloadType.number:
        return 'Number';
      case PayloadType.boolean:
        return 'Boolean';
      case PayloadType.binary:
        return 'Binary';
    }
  }

  /// Check if a payload type should be displayed as formatted text
  static bool shouldFormat(PayloadType type) {
    return type == PayloadType.json || type == PayloadType.xml;
  }

  /// Convert payload to bytes for binary viewing
  static Uint8List toBytes(String payload) {
    return Uint8List.fromList(payload.codeUnits);
  }

  static dynamic _parseJson(String payload) {
    try {
      return jsonDecode(payload);
    } catch (_) {
      return payload; // Fallback to string if parsing fails
    }
  }

  /// Format JSON with proper indentation
  static String _formatJson(String payload) {
    try {
      final json = jsonDecode(payload);
      return JsonEncoder.withIndent('  ').convert(json);
    } catch (_) {
      return payload; // Return original if formatting fails
    }
  }

  /// Format XML with basic indentation
  static String _formatXml(String payload) {
    // Basic XML formatting - could be enhanced with proper XML parsing
    return payload.replaceAll('><', '>\n<').replaceAll('>', '>\n').trim();
  }

  /// Check if payload is numeric
  static bool _isNumeric(String str) {
    return double.tryParse(str) != null;
  }

  /// Check if payload is boolean
  static bool _isBoolean(String str) {
    final lower = str.toLowerCase();
    return lower == 'true' || lower == 'false';
  }

  /// Check if payload looks like XML
  static bool _isXml(String str) {
    final trimmed = str.trim();
    return trimmed.startsWith('<') && trimmed.endsWith('>');
  }

  /// Check if payload contains binary/non-printable characters
  static bool _hasBinaryContent(String str) {
    for (final codeUnit in str.codeUnits) {
      // Check for non-printable ASCII characters (except common whitespace)
      if (codeUnit < 32 && codeUnit != 9 && codeUnit != 10 && codeUnit != 13) {
        return true;
      }
      // Check for non-ASCII characters that might indicate binary
      if (codeUnit > 126 && codeUnit < 160) {
        return true;
      }
    }
    return false;
  }
}