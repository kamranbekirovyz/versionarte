import 'package:flutter/foundation.dart';

/// A serverside representation model of the app versioning.
class StoreVersioning {
  const StoreVersioning({
    required this.android,
    required this.ios,
  });

  /// The versioning information for Android platform.
  final StorePlatformDetails android;

  /// The versioning information for iOS platform.
  final StorePlatformDetails ios;

  /// Creates an instance of [StoreVersioning] from a JSON [Map].
  factory StoreVersioning.fromJson(Map<String, dynamic> json) {
    return StoreVersioning(
      android: StorePlatformDetails.fromJson(json["android"]),
      ios: StorePlatformDetails.fromJson(json["ios"]),
    );
  }

  /// Returns a JSON [Map] representation of this object.
  Map<String, dynamic> toJson() {
    return {
      'android': android.toJson(),
      'ios': ios.toJson(),
    };
  }

  /// Returns the [PlatformStoreDetails] object corresponding to the current platform.
  ///
  /// Throws an [UnimplementedError] if the current platform is not supported by the package.
  StorePlatformDetails get currentPlatformStoreDetails {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      default:
        throw UnimplementedError(
          '$defaultTargetPlatform not implemented in this package',
        );
    }
  }

  @override
  String toString() {
    return toJson().toString();
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

  Map<String, dynamic> toJson() {
    return {
      'version': version.toJson(),
      'status': status.toJson(),
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class StatusDetails {
  final bool available;
  final Map<String?, String?>? message;

  const StatusDetails({
    required this.available,
    required this.message,
  });

  factory StatusDetails.fromJson(Map<String, dynamic> json) {
    return StatusDetails(
      available: json["available"],
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'available': available,
      'message': message,
    };
  }

  /// Get content for unavailable app in the given language.
  ///
  /// If no content is available for the given language code, null is returned.
  String? getMessageForLanguageCode(String languageCode) {
    return message?[languageCode];
  }
}

class VersionDetails {
  final int minimum;
  final int latest;

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

  Map<String, dynamic> toJson() {
    return {
      'minimum': minimum,
      'latest': latest,
    };
  }
}
