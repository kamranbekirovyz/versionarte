import 'package:versionarte/src/utilities/logger.dart';
import 'package:versionarte/versionarte.dart';

/// Result of a version check
class VersionarteResult {
  /// The status of the version check
  ///
  /// Possible values are:
  ///   - [VersionarteStatus.outdated]: A new version is available, but optional to update.
  ///   - [VersionarteStatus.forcedUpdate]: A new version is available, must update to continue.
  ///   - [VersionarteStatus.upToDate]: The app is up-to-date.
  ///   - [VersionarteStatus.inactive]: The app is currently inactive.
  ///   - [VersionarteStatus.unknown]: An error occurred while checking.
  final VersionarteStatus status;

  /// The versioning information all platforms.
  final StoreVersioning? platforms;

  /// Creates a new [VersionarteResult] instance.
  VersionarteResult(
    this.status, {
    this.platforms,
  }) : super() {
    logVersionarte('VersionarteResult: $this');
  }

  String? getMessageForLanguage(String code) {
    return platforms?.current?.status.getMessageForLanguage(code);
  }

  /// Returns a JSON representation of this object.
  @override
  String toString() {
    return 'status: $status';
  }
}
