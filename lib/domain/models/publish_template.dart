import 'package:freezed_annotation/freezed_annotation.dart';

part 'publish_template.freezed.dart';
part 'publish_template.g.dart';

@freezed
class PublishTemplate with _$PublishTemplate {
  const factory PublishTemplate({
    required String id,
    required String name,
    required String topic,
    required String payload,
    @Default(0) int qos,
    @Default(false) bool retain,
    String? description,
    Map<String, String>? userProperties, // MQTT 5.0
    DateTime? createdAt,
    DateTime? lastUsed,
  }) = _PublishTemplate;

  factory PublishTemplate.fromJson(Map<String, dynamic> json) =>
      _$PublishTemplateFromJson(json);
}