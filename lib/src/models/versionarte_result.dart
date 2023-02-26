import 'package:versionarte/src/helpers/logger.dart';
import 'package:versionarte/versionarte.dart';

/// A class representing the result of a version check for the app on the current platform.
class VersionarteResult {
  /// The status of the version check for the app on the current platform.
  ///
  /// Possible values are:
  ///   - [VersionarteStatus.couldUpdate]: A new version is available, but it is optional to update.
  ///   - [VersionarteStatus.mustUpdate]: A new version is available, and the user must update to continue using the app.
  ///   - [VersionarteStatus.upToDate]: The app is up-to-date and no new version is available.
  ///   - [VersionarteStatus.unavailable]: The app is currently unavailable, for example due to maintenance.
  ///   - [VersionarteStatus.failedToCheck]: An error occurred while checking the versioning status for the current platform.
  final VersionarteStatus status;

  /// The version details for the app on the current platform, including
  /// changelog and messages for when the app is unavailable.
  final StorePlatformDetails? details;

  /// An optional error message in case of [VersionarteStatus.failedToCheck] status.
  final String? message;

  /// Creates a new [VersionarteResult] instance.
  ///
  /// If `details` or `message` are not provided, they default to `null`.
  VersionarteResult(
    this.status, {
    this.details,
    this.message,
  }) : super() {
    logV(toString());
  }

  /// Returns a readable string representation of the [VersionarteResult] instance.
  @override
  String toString() {
    return 'Result:\n'
        '- Status: $status,\n'
        '- Message: $message';
  }
}
