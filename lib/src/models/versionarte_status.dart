import 'package:flutter/foundation.dart';

/// Enum representing decision for app and its update availability.
enum VersionarteStatus {
  /// "There is a new version available"
  couldUpdate,

  /// "There is a new version available and user must update the app to
  /// be able to continue"
  mustUpdate,

  /// "All good, user has the latest version of the app"
  upToDate,

  /// "App is inactive for usage"
  unavailable,

  /// "Some kind of error occured (detailed at `message` property of
  /// [VersionarteResult]"
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
