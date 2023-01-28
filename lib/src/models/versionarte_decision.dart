/// Enum representing decision for app and its update availability.
enum VersionarteDecision {
  /// "There is a new version available"
  shouldUpdate,

  /// "There is a new version available and user must update the app to continue"
  mustUpdate,

  /// "All good, user has the latest version of the app"
  upToDate,

  /// "App is inactive for usage"
  inactive,

  /// "Some kind of error occured (check [message] propery of [VersionarteResult]"
  failedToCheck,
}
