import 'package:flutter_test/flutter_test.dart';
import 'package:mqtt_scout/core/mqtt/utils/reconnection_strategy.dart';

void main() {
  group('ReconnectionStrategy', () {
    test('returns increasing delays', () {
      final strategy = ReconnectionStrategy(
        initialDelay: const Duration(seconds: 1),
        maxDelay: const Duration(seconds: 30),
      );

      final delay0 = strategy.getDelay(0);
      final delay1 = strategy.getDelay(1);
      final delay2 = strategy.getDelay(2);

      // Note: Jitter makes exact comparison impossible, but trend should hold
      // We expect delay to be roughly 1s, 2s, 4s
      
      expect(delay0.inMilliseconds, greaterThanOrEqualTo(1000));
      expect(delay1.inMilliseconds, greaterThanOrEqualTo(2000));
      expect(delay2.inMilliseconds, greaterThanOrEqualTo(4000));
    });

    test('caps delay at maxDelay', () {
      final strategy = ReconnectionStrategy(
        initialDelay: const Duration(seconds: 1),
        maxDelay: const Duration(seconds: 5),
      );

      final delay10 = strategy.getDelay(10); // Should be way over 5s without cap
      
      // With 30% jitter, max could be 5000 * 1.3 = 6500
      expect(delay10.inMilliseconds, lessThanOrEqualTo(6500));
    });
  });
}
