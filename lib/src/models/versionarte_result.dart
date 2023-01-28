import 'dart:developer';

import 'package:versionarte/src/models/serverside_versioning_details.dart';
import 'package:versionarte/src/models/versionarte_decision.dart';

class VersionarteResult {
  final VersionarteDecision decision;
  final ServersideVersioningDetails? details;
  final String? message;

  VersionarteResult(
    this.decision, {
    this.details,
    this.message,
  }) {
    _log(toString());
  }

  @override
  String toString() {
    return 'Result: \n- Decision: $decision, \n- message: $message';
  }
}

/// A simple logging utility function.
void _log(String? s) {
  // TODO: replace with logar..
  log('[VERSIONARTE] $s');
}
