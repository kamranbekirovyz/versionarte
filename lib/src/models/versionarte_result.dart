import 'package:flutter/foundation.dart';
import 'package:versionarte/versionarte.dart';

/// A class representing the result of a version check for the app on the current platform.
class VersionarteResult {
  /// The status of the version check for the app on the current platform.
  ///
  /// Possible values are:
  ///   - [VersionarteStatus.couldUpdate]: A new version is available, but it is optional to update.
  ///   - [VersionarteStatus.mustUpdate]: A new version is available, and the user must update to continue using the app.
  ///   - [VersionarteStatus.upToDate]: The app is up-to-date and no new version is available.
  ///   - [VersionarteStatus.inactive]: The app is currently inactive, for example due to maintenance.
  ///   - [VersionarteStatus.unknown]: An error occurred while checking the versioning status for the current platform.
  final VersionarteStatus status;

  /// The version details for the app on the current platform, including
  /// messages for when the app is inactive.
  final StorePlatformDetails? details;

  /// An optional error message in case of [VersionarteStatus.unknown] status.
  // TODO: rname to errorMessage?
  final String? message;

  /// Creates a new [VersionarteResult] instance.
  ///
  /// If `details` or `message` are not provided, they default to `null`.
  VersionarteResult(
    this.status, {
    this.details,
    this.message,
  }) : super() {
    debugPrint('[VERSIONARTE] VersionarteResult: $this');
  }

  /// Returns a readable string representation of the [VersionarteResult] instance.
  @override
  String toString() {
    return 'Result:\n'
        '- Status: $status,\n'
        '- Message: $message';
  }
}
