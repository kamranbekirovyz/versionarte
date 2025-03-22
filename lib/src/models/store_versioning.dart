import 'package:flutter/foundation.dart';

/// A serverside representation model of the app versioning.
class StoreVersioning {
  /// For Android platform.
  final StorePlatformDetails? android;

  /// For iOS platform.
  final StorePlatformDetails? iOS;

  /// For macOS platform.
  final StorePlatformDetails? macOS;

  /// For Windows platform.
  final StorePlatformDetails? windows;

  /// The versioning information for the Linux platform.
  final StorePlatformDetails? linux;

  const StoreVersioning({
    this.android,
    this.iOS,
    this.macOS,
    this.windows,
    this.linux,
  });

  /// Creates an instance of [StoreVersioning] from a JSON [Map].
  StoreVersioning.fromJson(Map<String, dynamic> json)
      : android = json["android"] != null
            ? StorePlatformDetails.fromJson(json["android"])
            : null,
        iOS = json["iOS"] != null
            ? StorePlatformDetails.fromJson(json["iOS"])
            : null,
        macOS = json["macOS"] != null
            ? StorePlatformDetails.fromJson(json["macOS"])
            : null,
        windows = json["windows"] != null
            ? StorePlatformDetails.fromJson(json["windows"])
            : null,
        linux = json["linux"] != null
            ? StorePlatformDetails.fromJson(json["linux"])
            : null;

  /// Returns the [PlatformStoreDetails] object corresponding to the current platform.
  ///
  /// Throws an [UnimplementedError] if the current platform is not supported by the package.
  StorePlatformDetails? get current {
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => android,
      TargetPlatform.iOS => iOS,
      TargetPlatform.macOS => macOS,
      TargetPlatform.windows => windows,
      TargetPlatform.linux => linux,
      _ => throw UnimplementedError(
          'Platform ${defaultTargetPlatform.toString()} is not supported by the package.',
        ),
    };
  }

  String? get downloadUrlForPlatform {
    return current?.downloadUrl;
  }

  String? getMessageForLanguage(String code) {
    return current?.status.getMessageForLanguage(code);
  }

  Map<TargetPlatform, String?> get downloadUrls {
    return {
      TargetPlatform.android: android?.downloadUrl,
      TargetPlatform.iOS: iOS?.downloadUrl,
      TargetPlatform.macOS: macOS?.downloadUrl,
      TargetPlatform.windows: windows?.downloadUrl,
      TargetPlatform.linux: linux?.downloadUrl,
    };
  }

  /// Returns a JSON representation of this object.
  Map<String, dynamic> toJson() {
    return {
      "android": android?.toJson(),
      "iOS": iOS?.toJson(),
      "macOS": macOS?.toJson(),
      "windows": windows?.toJson(),
      "linux": linux?.toJson(),
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class StorePlatformDetails {
  /// The version details for this platform.
  final VersionDetails version;

  /// The download URL for this platform.
  final String? downloadUrl;

  /// The status details for this platform.
  final StatusDetails status;

  const StorePlatformDetails({
    required this.downloadUrl,
    required this.version,
    required this.status,
  });

  /// Creates an instance of [StorePlatformDetails] from a JSON [Map].
  StorePlatformDetails.fromJson(Map<String, dynamic> json)
      : version = VersionDetails.fromJson(json["version"]),
        downloadUrl = json["download_url"],
        status = StatusDetails.fromJson(json["status"]);

  /// Returns a JSON representation of this object.
  Map<String, dynamic> toJson() {
    return {
      "version": version.toJson(),
      "download_url": downloadUrl,
      "status": status.toJson(),
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

/// Represents the minimum and latest versions of an application.
class VersionDetails {
  final String minimum;
  final String latest;

  const VersionDetails({
    required this.minimum,
    required this.latest,
  });

  VersionDetails.fromJson(Map<String, dynamic> json)
      : minimum = json["minimum"],
        latest = json["latest"];

  /// Returns a JSON representation of this object.
  Map<String, dynamic> toJson() {
    return {
      "minimum": minimum,
      "latest": latest,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

/// Represents the status of an application.
class StatusDetails {
  final bool active;
  final Map<String?, dynamic>? message;

  const StatusDetails({
    required this.active,
    required this.message,
  });

  StatusDetails.fromJson(Map<String, dynamic> json)
      : active = json["active"],
        message = json["message"];

  String? getMessageForLanguage(String code) {
    return message?[code];
  }

  /// Returns a JSON representation of this object.
  Map<String, dynamic> toJson() {
    return {
      "active": active,
      "message": message,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
