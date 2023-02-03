import 'package:flutter/foundation.dart';

/// Enum representing decision for app and its update availability.
enum VersionarteDecision {
  /// "There is a new version available"
  couldUpdate,

  /// "There is a new version available and user must update the app to continue"
  mustUpdate,

  /// "All good, user has the latest version of the app"
  upToDate,

  /// "App is inactive for usage"
  inactive,

  /// "Some kind of error occured (check [message] propery of [VersionarteResult]"
  failedToCheck,
}

extension VersionarteDecisionX on VersionarteDecision {
  void when({
    required VoidCallback couldUpdate,
    required VoidCallback mustUpdate,
    required VoidCallback inactive,
    VoidCallback? upToDate,
    VoidCallback? failedToCheck,
  }) {
    switch (this) {
      case VersionarteDecision.couldUpdate:
        return couldUpdate.call();

      case VersionarteDecision.mustUpdate:
        return mustUpdate.call();

      case VersionarteDecision.upToDate:
        return upToDate?.call();

      case VersionarteDecision.inactive:
        return couldUpdate.call();

      case VersionarteDecision.failedToCheck:
      default:
        return couldUpdate.call();
    }
  }
}
