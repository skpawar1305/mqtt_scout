import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mqtt_scout/features/connection/presentation/connect_screen.dart';
import 'package:mqtt_scout/core/providers/mqtt_providers.dart';
import 'package:mqtt_scout/core/mqtt/mqtt_service.dart';
import 'package:mqtt_scout/domain/models/broker_profile.dart';
import 'package:mqtt_scout/domain/models/mqtt_message.dart';

class FakeMqttClient implements IMqttClient {
  @override
  final Stream<MqttMessage> messageStream;
  @override
  final Stream<MqttConnectionState> connectionStateStream;
  @override
  final Stream<String> errorStream;
  @override
  final MqttConnectionState currentState;
  @override
  final MqttProtocolVersion negotiatedVersion;

  FakeMqttClient({
    required this.currentState,
    required this.connectionStateStream,
    Stream<MqttMessage>? messageStream,
    Stream<String>? errorStream,
    this.negotiatedVersion = MqttProtocolVersion.v3_1_1,
  })  : messageStream = messageStream ?? const Stream.empty(),
        errorStream = errorStream ?? const Stream.empty();

  @override
  Future<void> connect(BrokerProfile profile) async {}

  @override
  Future<void> disconnect() async {}

  @override
  Future<void> publish(String topic, String payload,
      {int qos = 0,
      bool retain = false,
      String? contentType,
      String? responseTopic,
      int? messageExpiryInterval,
      Map<String, String>? userProperties}) async {}

  @override
  Future<void> clearRetainedMessage(String topic) async {}

  @override
  Future<void> subscribe(String topic, {int qos = 0}) async {}

  @override
  Future<void> unsubscribe(String topic) async {}

  @override
  bool get isConnected => currentState == MqttConnectionState.connected;
}

void main() {
  Widget makeTestable({required Widget child, required List<Override> overrides}) {
    return ProviderScope(
      overrides: overrides,
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('disconnected shows enabled Connect button', (tester) async {
    final fake = FakeMqttClient(
      currentState: MqttConnectionState.disconnected,
      connectionStateStream: Stream.value(MqttConnectionState.disconnected),
    );

    await tester.pumpWidget(
      makeTestable(
        child: const ConnectScreen(),
        overrides: [
          mqttServiceProvider.overrideWithValue(fake),
        ],
      ),
    );

    await tester.pumpAndSettle();

    final connectFinder = find.text('Connect');
    expect(connectFinder, findsOneWidget);

    final elevated = tester.widget<ElevatedButton>(find.byType(ElevatedButton).first);
    expect(elevated.onPressed, isNotNull);
  });

  testWidgets('connected shows enabled Disconnect button', (tester) async {
    final fake = FakeMqttClient(
      currentState: MqttConnectionState.connected,
      connectionStateStream: Stream.value(MqttConnectionState.connected),
    );

    await tester.pumpWidget(
      makeTestable(
        child: const ConnectScreen(),
        overrides: [
          mqttServiceProvider.overrideWithValue(fake),
        ],
      ),
    );

    await tester.pumpAndSettle();

    final disconnectFinder = find.text('Disconnect');
    expect(disconnectFinder, findsOneWidget);

    final elevated = tester.widget<ElevatedButton>(find.byType(ElevatedButton).first);
    expect(elevated.onPressed, isNotNull);

    // When connected, the 'View Topic Tree' button should be visible and enabled
    final viewFinder = find.text('View Topic Tree');
    expect(viewFinder, findsOneWidget);

    final viewElevated = tester.widget<ElevatedButton>(find.widgetWithText(ElevatedButton, 'View Topic Tree'));
    expect(viewElevated.onPressed, isNotNull);
  });

  testWidgets('state connecting (data) keeps Connect button enabled (allows cancel)', (tester) async {
    final fake = FakeMqttClient(
      currentState: MqttConnectionState.connecting,
      connectionStateStream: Stream.value(MqttConnectionState.connecting),
    );

    await tester.pumpWidget(
      makeTestable(
        child: const ConnectScreen(),
        overrides: [
          mqttServiceProvider.overrideWithValue(fake),
        ],
      ),
    );

    await tester.pumpAndSettle();

    final connectFinder = find.text('Connect');
    expect(connectFinder, findsOneWidget);

    final elevated = tester.widget<ElevatedButton>(find.byType(ElevatedButton).first);
    expect(elevated.onPressed, isNotNull);
  });

  testWidgets('loading shows enabled Connect button', (tester) async {
    // Use a stream that never emits to simulate the provider being in a loading state.
    final controller = StreamController<MqttConnectionState>();
    final fake = FakeMqttClient(
      currentState: MqttConnectionState.disconnected,
      connectionStateStream: controller.stream,
    );

    await tester.pumpWidget(
      makeTestable(
        child: const ConnectScreen(),
        overrides: [
          mqttServiceProvider.overrideWithValue(fake),
        ],
      ),
    );

    await tester.pump(); // allow provider to enter loading

    final connectFinder = find.text('Connect');
    expect(connectFinder, findsOneWidget);

    final elevated = tester.widget<ElevatedButton>(find.byType(ElevatedButton).first);
    expect(elevated.onPressed, isNotNull);

    await controller.close();
  });
}
