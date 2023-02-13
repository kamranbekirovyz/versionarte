import 'package:flutter/foundation.dart';

/// Enum representing status of the app for the platform.
enum VersionarteStatus {
  /// "There is a new version available"
  couldUpdate,

  /// "There is a new version available and user must update"
  mustUpdate,

  /// "User has the latest version"
  upToDate,

  /// "App is not available for the time being"
  unavailable,

  /// "Error occured while checking status for the platform."
  ///
  ///  Check `message` property of `VersionarteResult` to see the possible
  /// error caused it.
  failedToCheck,
}

extension VersionarteStatusX on VersionarteStatus {
  void when({
    required VoidCallback mustUpdate,
    required VoidCallback unavailable,
    VoidCallback? couldUpdate,
    VoidCallback? upToDate,
    VoidCallback? failedToCheck,
  }) {
    switch (this) {
      case VersionarteStatus.couldUpdate:
        return couldUpdate?.call();

      case VersionarteStatus.mustUpdate:
        return mustUpdate.call();

      case VersionarteStatus.upToDate:
        return upToDate?.call();

      case VersionarteStatus.unavailable:
        return unavailable.call();

      case VersionarteStatus.failedToCheck:
      default:
    }
  }
}
