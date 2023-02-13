import 'package:versionarte/src/helpers/logger.dart';
import 'package:versionarte/src/models/serverside_versioning.dart';
import 'package:versionarte/versionarte.dart';

class VersionarteResult {
  /// [Enum] representing status of the app.
  ///
  /// Values: `shouldUpdate`, `mustUpdate`, `upToDate`, `inactive`, `failedToCheck`
  final VersionarteStatus status;

  /// [ServersideVersioning] for the app.
  ///
  /// Useful if you want to use those values, especially for getting
  /// [inactiveDescription] text.
  final PlatformVersionarte? details;

  /// Possible error message.
  final String? message;

  VersionarteResult(
    this.status, {
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
        VersionarteStatus.unavailable,
        VersionarteStatus.mustUpdate,
        VersionarteStatus.couldUpdate,
        VersionarteStatus.upToDate,
      ].contains(status);

  /// Overriding for a readable String representation of its instance.
  @override
  String toString() {
    return 'Result: \n- Status: $status, \n- message: $message';
  }
}
