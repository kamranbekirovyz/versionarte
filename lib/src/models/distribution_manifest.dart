import 'package:flutter/foundation.dart';

/// A serverside representation model of the app versioning.
class DistributionManifest {
  /// For Android platform.
  final PlatformDistributionInfo? android;

  /// For iOS platform.
  final PlatformDistributionInfo? iOS;

  /// For macOS platform.
  final PlatformDistributionInfo? macOS;

  /// For Windows platform.
  final PlatformDistributionInfo? windows;

  /// The versioning information for the Linux platform.
  final PlatformDistributionInfo? linux;

  const DistributionManifest({
    this.android,
    this.iOS,
    this.macOS,
    this.windows,
    this.linux,
  });

  /// Creates an instance of [DistributionManifest] from a JSON [Map].
  DistributionManifest.fromJson(Map<String, dynamic> json)
      : android = json["android"] != null
            ? PlatformDistributionInfo.fromJson(json["android"])
            : null,
        iOS = json["iOS"] != null
            ? PlatformDistributionInfo.fromJson(json["iOS"])
            : null,
        macOS = json["macOS"] != null
            ? PlatformDistributionInfo.fromJson(json["macOS"])
            : null,
        windows = json["windows"] != null
            ? PlatformDistributionInfo.fromJson(json["windows"])
            : null,
        linux = json["linux"] != null
            ? PlatformDistributionInfo.fromJson(json["linux"])
            : null;

  /// Returns the [PlatformStoreDetails] object corresponding to the current platform.
  ///
  /// Throws an [UnimplementedError] if the current platform is not supported by the package.
  PlatformDistributionInfo? get currentPlatform {
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
    return currentPlatform?.downloadUrl;
  }

  String? getMessageForLanguage(String code) {
    return currentPlatform?.status.getMessageForLanguage(code);
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

class PlatformDistributionInfo {
  /// The version details for this platform.
  final VersionDetails version;

  /// The download URL for this platform.
  final String? downloadUrl;

  /// The status details for this platform.
  final StatusDetails status;

  const PlatformDistributionInfo({
    required this.downloadUrl,
    required this.version,
    required this.status,
  });

  /// Creates an instance of [PlatformDistributionInfo] from a JSON [Map].
  PlatformDistributionInfo.fromJson(Map<String, dynamic> json)
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
