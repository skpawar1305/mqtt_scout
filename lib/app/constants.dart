class AppConstants {
  // MQTT Defaults
  static const int defaultPort = 1883;
  static const int defaultKeepAlive = 60;
  static const String defaultClientIdPrefix = 'mqtt_scout_';

  // UI Constants
  static const double borderRadius = 8.0;
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;

  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration reconnectionDelay = Duration(seconds: 5);

  // Limits
  static const int maxTopicHistory = 1000;
  static const int maxMessageHistory = 5000;
  static const int maxPayloadPreviewLength = 1000;

  // Storage Keys
  static const String brokerProfilesKey = 'broker_profiles';
  static const String settingsKey = 'app_settings';
  static const String recentTopicsKey = 'recent_topics';
}