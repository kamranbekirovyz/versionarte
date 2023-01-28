import 'dart:io';

/// Dart class representing server-side versioning details.
///
/// See example json file at path "/versionarte.json".
class ServersideVersioningDetails {
  /// Minimum Android platform version that users can have installed.
  final int minAndroidVersionNumber;

  /// Minimum iOS platform version that users can have installed.
  final int minIosVersionNumber;

  /// Latest Android (not minumum) version of the app released
  /// to the Google Play Store.
  final int latestAndroidVersionNumber;

  /// Latest iOS (not minumum) version of the app released
  /// to the Apple App Store.
  final int latestIosVersionNumber;

  /// Readable representation for the latest Android version of the app released
  /// to the Google Play Store.
  final String latestReadableAndroidVersion;

  /// Readable representation for the latest iOS version of the app released
  /// to the Apple App Store.
  final String latestReadableIosVersion;

  /// Determining whether app is active or not.
  final bool inactive;

  /// Optional text to show to user when app is inactive.
  final String? inactiveDescription;

  const ServersideVersioningDetails({
    required this.minAndroidVersionNumber,
    required this.latestAndroidVersionNumber,
    required this.minIosVersionNumber,
    required this.latestIosVersionNumber,
    required this.latestReadableAndroidVersion,
    required this.latestReadableIosVersion,
    required this.inactive,
    required this.inactiveDescription,
  });

  /// Instantiates a [ServersideVersioningDetails] instance from json.
  ///
  /// See example json file at path "/versionarte.json".
  factory ServersideVersioningDetails.fromJson(Map<String, dynamic> json) {
    return ServersideVersioningDetails(
      minAndroidVersionNumber: json['min_android_version_number'],
      minIosVersionNumber: json['min_ios_version_number'],
      latestAndroidVersionNumber: json['latest_android_version_number'],
      latestIosVersionNumber: json['latest_ios_version_number'],
      latestReadableAndroidVersion: json['latest_readable_android_version'],
      latestReadableIosVersion: json['latest_readable_ios_version'],
      inactive: json['inactive'] ?? false,
      inactiveDescription: json['inactive_description'],
    );
  }

  /// Returns minimum version of the currently running platform.
  int get minPlatformVersion => Platform.isAndroid ? minAndroidVersionNumber : minIosVersionNumber;

  /// Returns latest version of the currently running platform.
  int get latestPlatformVersion => Platform.isAndroid ? latestAndroidVersionNumber : latestIosVersionNumber;

  @override
  String toString() {
    return '''minAndroidVersionNumber: $minAndroidVersionNumber
minIosVersionNumber: $minIosVersionNumber
latestAndroidVersionNumber: $latestAndroidVersionNumber
latestIosVersionNumber: $latestIosVersionNumber
latestReadableAndroidVersion: $latestReadableAndroidVersion
latestReadableIosVersion: $latestReadableIosVersion
inactive: $inactive
inactiveDescription: $inactiveDescription
''';
  }
}
