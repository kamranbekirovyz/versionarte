import 'package:flutter/foundation.dart';

/// Common logging function: prints if !kReleaseMode
void logV(String? s) {
  if (!kReleaseMode) {
    debugPrint('[VERSIONARTE] $s');
  }
}
