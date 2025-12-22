import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';

void main() {
  // Catch uncaught asynchronous errors to avoid app crash and provide friendly messages
  FlutterError.onError = (FlutterErrorDetails details) {
    // ignore: avoid_print
    print('FlutterError: ${details.exception}');
  };

  runZonedGuarded(() {
    runApp(const ProviderScope(child: App()));
  }, (error, stack) {
    // ignore: avoid_print
    print('Uncaught error: $error');
  });
}
