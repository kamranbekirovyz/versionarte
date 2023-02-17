import 'package:versionarte/src/helpers/logger.dart';
import 'package:versionarte/versionarte.dart';

class VersionarteResult {
  /// An [Enum] representing status of the app.
  ///
  /// Values: `shouldUpdate`, `mustUpdate`, `upToDate`, `inactive`, `failedToCheck`
  final VersionarteStatus status;

  /// [PlatformVersionarte] for the app.
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

  /// Overriding for a readable String representation of its instance.
  @override
  String toString() {
    return 'Result: \n- Status: $status, \n- message: $message';
  }
}
