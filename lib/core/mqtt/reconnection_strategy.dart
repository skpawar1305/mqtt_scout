import 'dart:math';

class ReconnectionStrategy {
  final int maxAttempts;
  final Duration initialDelay;
  final Duration maxDelay;

  const ReconnectionStrategy({
    this.maxAttempts = 10,
    this.initialDelay = const Duration(seconds: 1),
    this.maxDelay = const Duration(seconds: 30),
  });

  Duration getDelay(int attempt) {
    if (attempt >= maxAttempts) {
      return Duration.zero; // Stop retrying
    }

    final exponential = initialDelay * pow(2, attempt);
    final capped = exponential < maxDelay ? exponential : maxDelay;
    final jitter = Random().nextDouble() * 0.3; // 30% jitter
    return capped * (1 + jitter);
  }

  bool shouldRetry(int attempt) {
    return attempt < maxAttempts;
  }
}