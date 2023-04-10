import 'dart:developer';

import 'package:flutter/foundation.dart';

void logVersionarte(
  String message, {
  Object? error,
  StackTrace? stackTrace,
}) {
  if (!kReleaseMode) {
    log(
      message,
      name: 'versionarte',
      time: DateTime.now(),
      error: error,
      stackTrace: stackTrace,
    );
  }
}
