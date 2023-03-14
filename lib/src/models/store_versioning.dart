import 'package:flutter/foundation.dart';

/// A serverside representation model of the app versioning.
class StoreVersioning {
  const StoreVersioning({
    this.android,
    this.iOS,
    this.windows,
    this.linux,
    this.macOS,
    this.fuchsia,
  });

  /// The versioning information for Android platform.
  final StorePlatformDetails? android;

  /// The versioning information for iOS platform.
  final StorePlatformDetails? iOS;

  /// The versioning information for Android platform.
  final StorePlatformDetails? windows;

  /// The versioning information for iOS platform.
  final StorePlatformDetails? linux;

  /// The versioning information for iOS platform.
  final StorePlatformDetails? macOS;

  /// The versioning information for iOS platform.
  final StorePlatformDetails? fuchsia;

  /// Creates an instance of [StoreVersioning] from a JSON [Map].
  factory StoreVersioning.fromJson(Map<String, dynamic> json) {
    return StoreVersioning(
      android: json["android"] != null
          ? StorePlatformDetails.fromJson(
              json["android"],
            )
          : null,
      iOS: json["iOS"] != null
          ? StorePlatformDetails.fromJson(
              json["iOS"],
            )
          : null,
      windows: json["windows"] != null
          ? StorePlatformDetails.fromJson(
              json["windows"],
            )
          : null,
      linux: json["linux"] != null
          ? StorePlatformDetails.fromJson(
              json["linux"],
            )
          : null,
      macOS: json["macOS"] != null
          ? StorePlatformDetails.fromJson(
              json["macOS"],
            )
          : null,
      fuchsia: json["fuchsia"] != null
          ? StorePlatformDetails.fromJson(
              json["fuchsia"],
            )
          : null,
    );
  }

  /// Returns the [PlatformStoreDetails] object corresponding to the current platform.
  ///
  /// Throws an [UnimplementedError] if the current platform is not supported by the package.
  StorePlatformDetails? get storeDetailsForPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return iOS;
      case TargetPlatform.fuchsia:
        return fuchsia;
      case TargetPlatform.linux:
        return linux;
      case TargetPlatform.macOS:
        return macOS;
      case TargetPlatform.windows:
        return windows;
      default:
        throw UnimplementedError(
          '$defaultTargetPlatform not supported',
        );
    }
  }
}

class StorePlatformDetails {
  final VersionDetails version;
  final StatusDetails status;

  const StorePlatformDetails({
    required this.version,
    required this.status,
  });

  factory StorePlatformDetails.fromJson(Map<String, dynamic> json) {
    return StorePlatformDetails(
      version: VersionDetails.fromJson(json["version"]),
      status: StatusDetails.fromJson(json["status"]),
    );
  }
}

class VersionDetails {
  final String minimum;
  final String latest;

  const VersionDetails({
    required this.minimum,
    required this.latest,
  });

  factory VersionDetails.fromJson(Map<String, dynamic> json) {
    return VersionDetails(
      minimum: json["minimum"],
      latest: json["latest"],
    );
  }
}

class StatusDetails {
  final bool active;
  final Map<String?, String?>? message;

  const StatusDetails({
    required this.active,
    required this.message,
  });

  factory StatusDetails.fromJson(Map<String, dynamic> json) {
    return StatusDetails(
      active: json["active"],
      message: json["message"],
    );
  }

  String? getMessageForLanguage(String code) {
    return message?[code];
  }
}
