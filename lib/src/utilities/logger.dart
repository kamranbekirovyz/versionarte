import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:versionarte/src/versionarte.dart';

void logVersionarte(
  String message, {
  Object? error,
  StackTrace? stackTrace,
}) {
  if (!kReleaseMode && Versionarte.enableLogging) {
    log(
      message,
      name: 'versionarte',
      time: DateTime.now(),
      error: error,
      stackTrace: stackTrace,
    );
  }
}
