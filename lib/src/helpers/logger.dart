import 'package:flutter/foundation.dart';

/// A simple logging utility function.
void logV(String? s) {
  if (kReleaseMode) {
    debugPrint('[VERSIONARTE] $s');
  }
}
