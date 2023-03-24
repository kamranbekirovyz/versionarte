import 'dart:developer';

import 'package:flutter/foundation.dart';

void logVersionarte(String message) {
  if (!kReleaseMode) {
    log(
      message,
      name: 'versionarte',
      time: DateTime.now(),
    );
  }
}
