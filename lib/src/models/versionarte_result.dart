import 'package:versionarte/src/helpers/logger.dart';
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
    logV(toString());
  }

  /// Returns true if current decision result is valid.
  ///
  /// Before using decision property, it is better to check if (result.success)
  /// so that errorous decisions does not impact your conditions.
  bool get success => [
        VersionarteDecision.inactive,
        VersionarteDecision.mustUpdate,
        VersionarteDecision.shouldUpdate,
        VersionarteDecision.upToDate,
      ].contains(decision);

  /// Overriding for a readable String representation of its instance.
  @override
  String toString() {
    return 'Result: \n- Decision: $decision, \n- message: $message';
  }
}
