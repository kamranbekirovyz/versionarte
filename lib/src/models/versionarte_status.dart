/// Enum representing the versioning status of the app for the current platform.
enum VersionarteStatus {
  /// The user has the latest version of the app.
  upToDate,

  /// There is a new version available, but it is not mandatory to update.
  outdated,

  /// There is a new version available and the user must update to continue using the app.
  forcedUpdate,

  /// The app is not currently available, for example due to maintenance.
  inactive,

  /// An error occurred while checking.
  ///
  /// The `message` property of the [VersionarteResult] object can be checked to see
  /// the possible error that caused this status.
  unknown,
}
