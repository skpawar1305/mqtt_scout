import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mqtt_scout/app/app.dart';
import 'package:mqtt_scout/domain/models/mqtt_message.dart';
import 'package:mqtt_scout/domain/models/broker_profile.dart';
import 'package:mqtt_scout/features/message_viewer/message_viewer_screen.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: App()));

    // Verify that our app shows the home screen
    expect(find.text('Welcome to MQTT Scout'), findsOneWidget);
  });

  testWidgets('MessageViewer displays JSON message correctly', (WidgetTester tester) async {
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

    // Build the MessageViewerScreen
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: MessageViewerScreen(message: message),
        ),
      ),
    );

    // Verify the topic is displayed
    expect(find.text('test/topic'), findsOneWidget);

    // Verify the payload type icon is shown (JSON icon)
    expect(find.byIcon(Icons.data_object), findsOneWidget);

    // Verify tabs are present (Raw, Formatted, Tree)
    expect(find.text('Raw'), findsOneWidget);
    expect(find.text('Formatted'), findsOneWidget);
    expect(find.text('Tree'), findsOneWidget);
  });

  testWidgets('MessageViewer displays binary message correctly', (WidgetTester tester) async {
    // Create a test MQTT message with binary payload
    final message = MqttMessage(
      id: 'test-id-2',
      topic: 'binary/topic',
      payload: String.fromCharCodes([0x00, 0x01, 0x02, 0x03]),
      timestamp: DateTime.now(),
      protocolVersion: MqttProtocolVersion.v3_1_1,
      qos: 1,
      retained: true,
    );

    // Build the MessageViewerScreen
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: MessageViewerScreen(message: message),
        ),
      ),
    );

    // Verify the topic is displayed
    expect(find.text('binary/topic'), findsOneWidget);

    // Verify the payload type icon is shown (binary icon)
    expect(find.byIcon(Icons.memory), findsOneWidget);

    // Verify QoS is displayed
    expect(find.text('QoS 1'), findsOneWidget);

    // Verify retained indicator is shown
    expect(find.byIcon(Icons.bookmark), findsOneWidget);

    // Verify tabs are present (Raw, Hex)
    expect(find.text('Raw'), findsOneWidget);
    expect(find.text('Hex'), findsOneWidget);
  });
}
