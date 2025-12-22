import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mqtt_scout/features/connection/presentation/connect_screen.dart';
import 'package:mqtt_scout/core/providers/mqtt_providers.dart';
import 'package:mqtt_scout/core/mqtt/mqtt_service.dart';
import 'package:mqtt_scout/core/mqtt/mqtt_subscription_manager.dart';
import 'package:mqtt_scout/domain/models/subscription.dart';
import 'package:mqtt_scout/domain/models/mqtt_message.dart';
import 'package:mqtt_scout/domain/models/broker_profile.dart';

// Fake subscription manager to capture subscribe calls
class FakeSubscriptionManager extends MqttSubscriptionManager {
  final List<Subscription> subs = [];
  FakeSubscriptionManager() : super(FakeClient());

  @override
  Future<void> subscribe(Subscription subscription) async {
    subs.add(subscription);
  }

  @override
  Future<void> restoreSubscriptions() async {
    // noop
  }
}

// Minimal fake IMqttClient used to satisfy constructor
class FakeClient implements IMqttClient {
  @override
  Stream<MqttConnectionState> get connectionStateStream => const Stream<MqttConnectionState>.empty();
  @override
  Stream<String> get errorStream => const Stream<String>.empty();
  @override
  Stream<MqttMessage> get messageStream => const Stream<MqttMessage>.empty();
  @override
  Future<void> clearRetainedMessage(String topic) async {}
  @override
  Future<void> connect(profile) async {}
  @override
  Future<void> disconnect() async {}
  @override
  Future<void> publish(String topic, String payload, {int qos = 0, bool retain = false, String? contentType, String? responseTopic, int? messageExpiryInterval, Map<String, String>? userProperties}) async {}
  @override
  Future<void> subscribe(String topic, {int qos = 0}) async {}
  @override
  Future<void> unsubscribe(String topic) async {}
  @override
  MqttConnectionState get currentState => MqttConnectionState.disconnected;
  @override
  bool get isConnected => false;
  @override
  MqttProtocolVersion get negotiatedVersion => MqttProtocolVersion.v3_1_1;
}

void main() {
  testWidgets('auto-subscribe on connect triggers subscribe to #', (tester) async {
    final fakeSubManager = FakeSubscriptionManager();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          subscriptionManagerProvider.overrideWithValue(fakeSubManager),
          mqttServiceProvider.overrideWithValue(FakeClient()),
        ],
        child: MaterialApp(home: const ConnectScreen()),
      ),
    );

    // Enable the switch
    final switchFinder = find.byType(SwitchListTile);
    expect(switchFinder, findsWidgets);

    // The Connect button should be present; tap it after enabling the switch
    final connectFinder = find.text('Connect');
    expect(connectFinder, findsOneWidget);

    // Toggle the 'Subscribe to all topics (#) on connect' switch
    // Find by text label and toggle it via tap on the widget
    final subscribeLabel = find.textContaining('Subscribe to all topics (#)');
    expect(subscribeLabel, findsOneWidget);
    await tester.tap(subscribeLabel);
    await tester.pumpAndSettle();

    // Press Connect
    await tester.tap(connectFinder);
    await tester.pumpAndSettle();

    // The fake subscription manager should have recorded a subscribe to '#'
    expect(fakeSubManager.subs.isNotEmpty, isTrue);
    expect(fakeSubManager.subs.first.topic, equals('#'));
  });
}
