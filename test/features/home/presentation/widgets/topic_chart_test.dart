import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mqtt_scout/features/home/presentation/widgets/topic_chart.dart';
import 'package:mqtt_scout/core/tree/topic_node.dart';
import 'package:mqtt_scout/domain/models/mqtt_message.dart';
import 'package:mqtt_scout/domain/models/broker_profile.dart'; // Needed for MqttProtocolVersion

void main() {
  testWidgets('TopicChart renders empty when no numeric data', (WidgetTester tester) async {
    final node = TopicNode(name: 'test', fullPath: 'test');
    node.messages.add(MqttMessage(
      id: '1',
      topic: 'test',
      payload: 'not a number',
      timestamp: DateTime.now(),
      qos: 0,
      retained: false,
      protocolVersion: MqttProtocolVersion.v3_1_1,
    ));

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: TopicChart(topicNode: node, isDark: false),
      ),
    ));

    expect(find.byType(LineChart), findsNothing);
  });

  testWidgets('TopicChart renders line chart with numeric data', (WidgetTester tester) async {
    final node = TopicNode(name: 'test', fullPath: 'test');
    final now = DateTime.now();
    node.messages.add(MqttMessage(
      id: '1',
      topic: 'test',
      payload: '25.5',
      timestamp: now.subtract(const Duration(minutes: 5)),
      qos: 0,
      retained: false,
      protocolVersion: MqttProtocolVersion.v3_1_1,
    ));
    node.messages.add(MqttMessage(
      id: '2',
      topic: 'test',
      payload: '26.0',
      timestamp: now,
      qos: 0,
      retained: false,
      protocolVersion: MqttProtocolVersion.v3_1_1,
    ));

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: TopicChart(topicNode: node, isDark: false),
      ),
    ));

    expect(find.byType(LineChart), findsOneWidget);
  });
}
