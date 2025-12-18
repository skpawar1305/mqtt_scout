import '../models/mqtt_message.dart';

abstract class MessageRepository {
  Future<List<MqttMessage>> getMessagesForTopic(String topic, {int limit = 100});
  Future<void> saveMessage(MqttMessage message);
  Future<void> deleteOldMessages(Duration olderThan);
  Future<int> getMessageCount();
  Future<List<String>> getRecentTopics({int limit = 50});
  Future<void> clearAllMessages();
}