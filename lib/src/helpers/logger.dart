import 'dart:developer' show log;

import 'package:flutter/foundation.dart';

/// A simple logging utility function.
void logV(String? s) {
  if (kReleaseMode) {
    log('[VERSIONARTE] $s');
  }
}
