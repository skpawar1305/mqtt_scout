class MqttException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  MqttException(this.message, {this.code, this.originalError});

  @override
  String toString() => 'MqttException: $message${code != null ? ' ($code)' : ''}';
}

class MqttConnectionException extends MqttException {
  MqttConnectionException(String message, {String? code, dynamic originalError})
      : super(message, code: code, originalError: originalError);
}

class MqttPublishException extends MqttException {
  MqttPublishException(String message, {String? code, dynamic originalError})
      : super(message, code: code, originalError: originalError);
}

class MqttSubscribeException extends MqttException {
  MqttSubscribeException(String message, {String? code, dynamic originalError})
      : super(message, code: code, originalError: originalError);
}