import 'package:flutter_test/flutter_test.dart';
import 'package:mqtt_scout/core/mqtt/topic_tree.dart';
import 'package:mqtt_scout/domain/models/broker_profile.dart';
import 'package:mqtt_scout/domain/models/mqtt_message.dart';

void main() {
  group('TopicTree', () {
    late TopicTree tree;

    setUp(() {
      tree = TopicTree();
    });

    test('insertMessage creates correct structure', () {
      final message = MqttMessage(
        id: '1',
        topic: 'a/b/c',
        payload: 'test',
        timestamp: DateTime.now(),
        protocolVersion: MqttProtocolVersion.v3_1_1,
      );

      tree.insertMessage(message);

      expect(tree.root.children.containsKey('a'), isTrue);
      expect(tree.root.children['a']!.children.containsKey('b'), isTrue);
      expect(tree.root.children['a']!.children['b']!.children.containsKey('c'), isTrue);
      
      final leaf = tree.root.children['a']!.children['b']!.children['c']!;
      expect(leaf.lastMessage, equals(message));
      expect(leaf.messageCount, equals(1));
    });

    test('insertMessage updates existing nodes', () {
      final msg1 = MqttMessage(
        id: '1',
        topic: 'a/b',
        payload: '1',
        timestamp: DateTime.now(),
        protocolVersion: MqttProtocolVersion.v3_1_1,
      );
      final msg2 = MqttMessage(
        id: '2',
        topic: 'a/b',
        payload: '2',
        timestamp: DateTime.now(),
        protocolVersion: MqttProtocolVersion.v3_1_1,
      );

      tree.insertMessage(msg1);
      tree.insertMessage(msg2);

      final leaf = tree.root.children['a']!.children['b']!;
      expect(leaf.messageCount, equals(2));
      expect(leaf.lastMessage, equals(msg2));
    });

    test('getNode returns correct node', () {
      final message = MqttMessage(
        id: '1',
        topic: 'x/y',
        payload: 'test',
        timestamp: DateTime.now(),
        protocolVersion: MqttProtocolVersion.v3_1_1,
      );

      tree.insertMessage(message);

      final nodeX = tree.getNode('x');
      final nodeY = tree.getNode('x/y');

      expect(nodeX, isNotNull);
      expect(nodeX!.name, equals('x'));
      
      expect(nodeY, isNotNull);
      expect(nodeY!.name, equals('y'));
    });
  });
}
