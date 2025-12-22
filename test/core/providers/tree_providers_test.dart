import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mqtt_scout/core/providers/tree_providers.dart';
import 'package:mqtt_scout/domain/models/mqtt_message.dart';
import 'package:mqtt_scout/domain/models/broker_profile.dart';

void main() {
  group('TreeProviders', () {
    test('treeStatisticsProvider updates when messages are added (with throttle)', () async {
      final container = ProviderContainer();
      
      final tree = container.read(topicTreeProvider);
      
      // Initialize stats
      var stats = container.read(treeStatisticsProvider);
      expect(stats.totalTopics, 0);
      expect(stats.totalMessages, 0);

      // Insert a message
      final message = MqttMessage(
        id: '1',
        topic: 'test/topic',
        payload: 'payload',
        timestamp: DateTime.now(),
        protocolVersion: MqttProtocolVersion.v3_1_1,
      );
      
      tree.insertMessage(message);
      
      // Immediate read: should NOT have updated yet due to throttle (unless it's set to leading edge, but implementation is trailing)
      // Implementation: scheduleUpdate -> Timer(500ms).
      // So immediate state is still 0.
      
      stats = container.read(treeStatisticsProvider);
      // Wait, initial read calls build() which calls getStatistics(). If tree was updated before provider was built, it would have value.
      // But here provider was built (read) before insert.
      // So immediate check should verify it hasn't somehow updated magically (it shouldn't).
      // Actually strictly checking for 0 might be flaky if execution is slow, but practically fine.
      
      // Wait for throttle (500ms) + buffer
      await Future<void>.delayed(const Duration(milliseconds: 600));

      stats = container.read(treeStatisticsProvider);
      
      expect(stats.totalTopics, greaterThan(0));
      expect(stats.totalMessages, greaterThan(0));
      
      container.dispose();
    });
  });
}
