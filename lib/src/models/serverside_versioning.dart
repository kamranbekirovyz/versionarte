import 'dart:io';

/// Dart class representing server-side versioning details.
///
/// See example json file at path "/versionarte.json".
class ServersideVersioning {
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

  /// Optional title text to show to user when the app is inactive.
  final String? inactiveTitle;

  /// Optional description text to show to user when the app is inactive.
  final String? inactiveDescription;

  /// Changelog of the latest release for multiple languages.
  ///
  /// Key of the `MapEntry` is language key and its values as a list of
  /// `List<String>`
  final Map<String?, List<String?>?>? changelog;

  const ServersideVersioning({
    required this.minAndroidVersionNumber,
    required this.latestAndroidVersionNumber,
    required this.minIosVersionNumber,
    required this.latestIosVersionNumber,
    required this.latestReadableAndroidVersion,
    required this.latestReadableIosVersion,
    required this.inactive,
    required this.inactiveTitle,
    required this.inactiveDescription,
    required this.changelog,
  });

  /// Instantiates a `ServersideVersioning` instance from json.
  ///
  /// See example json file at path "/versionarte.json".
  factory ServersideVersioning.fromJson(Map<String, dynamic> json) {
    return ServersideVersioning(
      minAndroidVersionNumber: json['min_android_version_number'],
      minIosVersionNumber: json['min_ios_version_number'],
      latestAndroidVersionNumber: json['latest_android_version_number'],
      latestIosVersionNumber: json['latest_ios_version_number'],
      latestReadableAndroidVersion: json['latest_readable_android_version'],
      latestReadableIosVersion: json['latest_readable_ios_version'],
      inactive: json['inactive'] ?? false,
      inactiveTitle: json['inactive_title'],
      inactiveDescription: json['inactive_description'],
      changelog: json['changelog'],
    );
  }

  /// Returns minimum version of the currently running platform.
  int get minPlatformVersion =>
      Platform.isAndroid ? minAndroidVersionNumber : minIosVersionNumber;

  /// Returns latest version of the currently running platform.
  int get latestPlatformVersion =>
      Platform.isAndroid ? latestAndroidVersionNumber : latestIosVersionNumber;

  /// Overriding for a readable String representation of its instance.
  @override
  String toString() {
    return '''minAndroidVersionNumber: $minAndroidVersionNumber
minIosVersionNumber: $minIosVersionNumber
latestAndroidVersionNumber: $latestAndroidVersionNumber
latestIosVersionNumber: $latestIosVersionNumber
latestReadableAndroidVersion: $latestReadableAndroidVersion
latestReadableIosVersion: $latestReadableIosVersion
inactive: $inactive
inactiveTitle: $inactiveTitle
inactiveDescription: $inactiveDescription
changelog: $changelog
''';
  }
}
