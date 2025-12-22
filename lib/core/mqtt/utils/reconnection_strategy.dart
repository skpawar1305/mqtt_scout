import 'dart:math';

class ReconnectionStrategy {
  final int maxAttempts;
  final Duration initialDelay;
  final Duration maxDelay;
  final Random _random = Random();

  ReconnectionStrategy({
    this.maxAttempts = 5,
    this.initialDelay = const Duration(seconds: 1),
    this.maxDelay = const Duration(seconds: 30),
  });

  Duration getDelay(int attempt) {
    if (attempt < 0) return Duration.zero;
    
    // Calculate exponential backoff
    final exponential = initialDelay.inMilliseconds * pow(2, attempt);
    
    // Cap at maxDelay
    final capped = min(exponential, maxDelay.inMilliseconds);
    
    // Add 30% jitter
    final jitter = _random.nextDouble() * 0.3;
    final withJitter = capped * (1 + jitter);
    
    return Duration(milliseconds: withJitter.toInt());
  }
}
