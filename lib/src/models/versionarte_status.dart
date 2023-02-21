/// Enum representing the versioning status of the app for the current platform.
enum VersionarteStatus {
  /// There is a new version available, but it is not mandatory to update.
  couldUpdate,

  /// There is a new version available and the user must update to continue using the app.
  mustUpdate,

  /// The user has the latest version of the app.
  upToDate,

  /// The app is not available for the time being, e.g. it is currently undergoing maintenance.
  unavailable,

  /// An error occurred while checking the versioning status for the current platform.
  ///
  /// Check the `message` property of the [VersionarteResult] object to see the
  /// possible error that caused this status.
  failedToCheck,
}
