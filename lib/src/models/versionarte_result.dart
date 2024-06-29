import 'package:versionarte/src/utilities/logger.dart';
import 'package:versionarte/versionarte.dart';

/// A class representing the result of a version check for the app on the current platform.
class VersionarteResult {
  /// The status of the version check for the app on the current platform.
  ///
  /// Possible values are:
  ///   - [VersionarteStatus.outdated]: A new version is available, but it is optional to update.
  ///   - [VersionarteStatus.forcedUpdate]: A new version is available, and the user must update to continue using the app.
  ///   - [VersionarteStatus.upToDate]: The app is up-to-date and no new version is available.
  ///   - [VersionarteStatus.inactive]: The app is currently inactive, for example due to maintenance.
  ///   - [VersionarteStatus.unknown]: An error occurred while checking the versioning status for the current platform.
  final VersionarteStatus status;

  /// The version details for the app on the current platform, including
  /// messages for when the app is inactive.
  final StorePlatformDetails? details;

  /// Creates a new [VersionarteResult] instance.
  VersionarteResult(
    this.status, {
    this.details,
  }) : super() {
    logVersionarte('VersionarteResult: $this');
  }

  String? getMessageForLanguage(String code) {
    return details?.status.getMessageForLanguage(code);
  }

  /// Returns a JSON representation of this object.
  @override
  String toString() {
    return 'status: $status';
  }
}
