import 'package:versionarte/src/helpers/logger.dart';
import 'package:versionarte/src/models/serverside_versioning.dart';
import 'package:versionarte/src/models/versionarte_decision.dart';

class VersionarteResult {
  /// Enum representing decision for app and its update availability.
  ///
  /// Values: shouldUpdate, mustUpdate, upToDate, inactive, failedToCheck.
  final VersionarteDecision decision;

  /// [ServersideVersioning] for the app.
  ///
  /// Useful if you want to use those values, especially for getting
  /// [inactiveDescription] text.
  final ServersideVersioning? serversideVersioning;

  /// Possible error message.
  final String? message;

  VersionarteResult(
    this.decision, {
    this.serversideVersioning,
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
        VersionarteDecision.couldUpdate,
        VersionarteDecision.upToDate,
      ].contains(decision);

  /// Overriding for a readable String representation of its instance.
  @override
  String toString() {
    return 'Result: \n- Decision: $decision, \n- message: $message';
  }
}
