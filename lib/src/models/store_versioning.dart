import 'dart:io';

/// A serverside representation model of the app versioning.
class StoreVersioning {
  /// The versioning information for Android platform.
  final StorePlatformDetails? android;

  /// The versioning information for iOS platform.
  final StorePlatformDetails? iOS;

  /// The versioning information for macOS platform.
  final StorePlatformDetails? macOS;

  const StoreVersioning({
    this.android,
    this.iOS,
    this.macOS,
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
            : null;

  /// Returns the [PlatformStoreDetails] object corresponding to the current platform.
  ///
  /// Throws an [UnimplementedError] if the current platform is not supported by the package.
  StorePlatformDetails? get storeDetailsForPlatform {
    switch (Platform.operatingSystem) {
      case 'android':
        return android;
      case 'ios':
        return iOS;
      case 'macos':
        return macOS;
      default:
        throw UnsupportedError(
          '${Platform.operatingSystem} not supported',
        );
    }
  }

  /// Returns a JSON representation of this object.
  Map<String, dynamic> toJson() {
    return {
      "android": android?.toJson(),
      "iOS": iOS?.toJson(),
      "macOS": macOS?.toJson(),
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
