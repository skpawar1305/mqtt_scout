class Validators {
  static String? validateHost(String? value) {
    if (value == null || value.isEmpty) {
      return 'Host is required';
    }

    // Basic IP address or hostname validation
    final hostRegex = RegExp(r'^[a-zA-Z0-9.-]+$');
    if (!hostRegex.hasMatch(value)) {
      return 'Invalid host format';
    }

    return null;
  }

  static String? validatePort(String? value) {
    if (value == null || value.isEmpty) {
      return 'Port is required';
    }

    final port = int.tryParse(value);
    if (port == null || port < 1 || port > 65535) {
      return 'Port must be between 1 and 65535';
    }

    return null;
  }

  static String? validateTopic(String? value) {
    if (value == null || value.isEmpty) {
      return 'Topic is required';
    }

    // MQTT topic validation - basic check for invalid characters
    if (value.contains('#') && !value.endsWith('#')) {
      return 'Multi-level wildcard (#) must be at the end';
    }

    if (value.contains('+') && (value.startsWith('+') || value.endsWith('+') || value.contains('/+/'))) {
      // + is allowed in the middle, just not as first/last or adjacent to /
      // This is a simplified check
    }

    return null;
  }

  static String? validateClientId(String? value) {
    if (value == null || value.isEmpty) {
      return 'Client ID is required';
    }

    if (value.length > 23) {
      return 'Client ID must be 23 characters or less';
    }

    // MQTT client ID should not contain control characters
    if (value.contains(RegExp(r'[\x00-\x1F\x7F-\x9F]'))) {
      return 'Client ID contains invalid characters';
    }

    return null;
  }

  static String? validateQos(int? value) {
    if (value == null || value < 0 || value > 2) {
      return 'QoS must be 0, 1, or 2';
    }
    return null;
  }
}