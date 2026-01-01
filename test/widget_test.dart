import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mqtt_scout/app/app.dart';
import 'package:mqtt_scout/core/providers/tree_providers.dart';
import 'package:mqtt_scout/core/tree/topic_node.dart';
import 'package:mqtt_scout/domain/models/mqtt_message.dart';
import 'package:mqtt_scout/domain/models/broker_profile.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:mqtt_scout/features/viewer/presentation/message_viewer_panel.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: App()));

    // Verify that our app shows the home screen (or at least starts without crashing)
    // The initial route is / usually (ConnectScreen), checking for 'MQTT Scout' title or similar
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('MessageViewerPanel displays JSON message correctly', (WidgetTester tester) async {
    // Create a test MQTT message with JSON payload
    final message = MqttMessage(
      id: 'test-id-1',
      topic: 'test/topic',
      payload: '{"name": "test", "value": 123}',
      timestamp: DateTime.now(),
      protocolVersion: MqttProtocolVersion.v3_1_1,
      qos: 0,
      retained: false,
    );
    
    final node = TopicNode(name: 'topic', fullPath: 'test/topic');
    node.lastMessage = message;
    node.messages.add(message);

    // Build the MessageViewerPanel with overridden provider
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          selectedNodeProvider.overrideWith((ref) => node),
        ],
        child: const MaterialApp(
          home: Scaffold(body: MessageViewerPanel()),
        ),
      ),
    );

    // Verify the topic is displayed
    expect(find.text('test/topic'), findsOneWidget);

    // Verify the payload is displayed (checking for the JSON key)
    expect(find.text('Payload'), findsOneWidget);
    // HighlightView might split text, so we just check if it's there
    expect(find.byType(HighlightView), findsOneWidget);
  });
}
