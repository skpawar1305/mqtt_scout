import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mqtt_scout/core/mqtt/i_mqtt_client.dart';
import 'package:mqtt_scout/core/mqtt/models/mqtt_connection_state.dart';
import 'package:mqtt_scout/core/mqtt/subscription_manager.dart';
import 'package:mqtt_scout/domain/models/subscription.dart';

@GenerateMocks([IMqttClient])
import 'subscription_manager_test.mocks.dart';

void main() {
  group('SubscriptionManager', () {
    late MockIMqttClient mockClient;
    late SubscriptionManager manager;
    late StreamController<MqttConnectionState> connectionStateController;

    setUp(() {
      mockClient = MockIMqttClient();
      connectionStateController = StreamController<MqttConnectionState>.broadcast();
      
      when(mockClient.connectionStateStream)
          .thenAnswer((_) => connectionStateController.stream);
      
      manager = SubscriptionManager(mockClient);
    });

    tearDown(() {
      manager.dispose();
      connectionStateController.close();
    });

    test('subscribe adds to active subscriptions', () async {
      final sub = Subscription(id: '1', topic: 'test/topic');
      when(mockClient.isConnected).thenReturn(true);
      when(mockClient.subscribe(any)).thenAnswer((_) async {});

      await manager.subscribe(sub);

      expect(manager.activeSubscriptions, contains(sub));
      verify(mockClient.subscribe(sub)).called(1);
    });

    test('unsubscribe removes from active subscriptions', () async {
      final sub = Subscription(id: '1', topic: 'test/topic');
      when(mockClient.isConnected).thenReturn(true);
      when(mockClient.subscribe(any)).thenAnswer((_) async {});
      when(mockClient.unsubscribe(any)).thenAnswer((_) async {});

      await manager.subscribe(sub);
      await manager.unsubscribe('test/topic');

      expect(manager.activeSubscriptions, isNot(contains(sub)));
      verify(mockClient.unsubscribe('test/topic')).called(1);
    });

    test('restores subscriptions on reconnect', () async {
      final sub = Subscription(id: '1', topic: 'test/topic');
      when(mockClient.isConnected).thenReturn(false); // Initially disconnected
      
      await manager.subscribe(sub);
      verifyNever(mockClient.subscribe(any)); // Should not subscribe yet

      // Simulate connection
      when(mockClient.isConnected).thenReturn(true);
      when(mockClient.subscribe(any)).thenAnswer((_) async {});
      connectionStateController.add(MqttConnectionState.connected);

      // Wait for microtasks
      await Future.delayed(Duration.zero);

      verify(mockClient.subscribe(sub)).called(1);
    });

    test('enableDiscoveryMode subscribes to #', () async {
      when(mockClient.isConnected).thenReturn(true);
      when(mockClient.subscribe(any)).thenAnswer((_) async {});

      await manager.enableDiscoveryMode();

      final active = manager.activeSubscriptions;
      expect(active.any((s) => s.topic == '#'), isTrue);
      verify(mockClient.subscribe(argThat(
        predicate<Subscription>((s) => s.topic == '#')
      ))).called(1);
    });
  });
}
