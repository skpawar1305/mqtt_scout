import 'package:logging/logging.dart';

class AppLogger {
  static final Logger _logger = Logger('MQTTScout');

  static void init() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      print('${record.level.name}: ${record.time}: ${record.message}');
      if (record.error != null) {
        print('Error: ${record.error}');
      }
      if (record.stackTrace != null) {
        print('StackTrace: ${record.stackTrace}');
      }
    });
  }

  static Logger get logger => _logger;
}