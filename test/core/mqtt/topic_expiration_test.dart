import 'package:flutter_test/flutter_test.dart';
import 'package:mqtt_scout/core/mqtt/topic_expiration.dart';
import 'package:mqtt_scout/core/mqtt/topic_tree.dart';
import 'package:mqtt_scout/domain/models/broker_profile.dart';
import 'package:mqtt_scout/domain/models/mqtt_message.dart';

void main() {
  group('TopicExpiration', () {
    late TopicTree tree;
    late TopicExpiration expiration;

    setUp(() {
      tree = TopicTree();
      expiration = TopicExpiration(
        inactivityThreshold: const Duration(milliseconds: 100),
        checkInterval: const Duration(milliseconds: 50),
      );
    });

    tearDown(() {
      expiration.stopCleanup();
    });

    test('removes inactive nodes', () async {
      final message = MqttMessage(
        id: '1',
        topic: 'old/topic',
        payload: 'test',
        timestamp: DateTime.now().subtract(const Duration(seconds: 1)), // Old
        protocolVersion: MqttProtocolVersion.v3_1_1,
      );

      tree.insertMessage(message);
      
      // Manually trigger cleanup logic since we can't easily wait for Timer in tests without async complexity
      // We'll expose the private method via a test helper or just copy logic?
      // Better: Use a short threshold and wait.
      
      // Wait for threshold to pass
      await Future.delayed(const Duration(milliseconds: 200));
      
      expiration.startCleanup(tree);
      
      // Wait for cleanup cycle
      await Future.delayed(const Duration(milliseconds: 100));

      expect(tree.root.children.containsKey('old'), isFalse);
    });

    test('keeps active nodes', () async {
      final message = MqttMessage(
        id: '1',
        topic: 'active/topic',
        payload: 'test',
        timestamp: DateTime.now(), // New
        protocolVersion: MqttProtocolVersion.v3_1_1,
      );

      tree.insertMessage(message);
      
      expiration.startCleanup(tree);
      await Future.delayed(const Duration(milliseconds: 100));

      expect(tree.root.children.containsKey('active'), isTrue);
    });
  });
}
