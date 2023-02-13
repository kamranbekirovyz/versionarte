import 'package:flutter/foundation.dart';

class ServersideVersioning {
  const ServersideVersioning({
    required this.android,
    required this.ios,
  });

  final PlatformVersionarte android;
  final PlatformVersionarte ios;

  factory ServersideVersioning.fromJson(Map<String, dynamic> json) {
    return ServersideVersioning(
      android: PlatformVersionarte.fromJson(json["android"]),
      ios: PlatformVersionarte.fromJson(json["ios"]),
    );
  }

  PlatformVersionarte get platform {
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
}

class PlatformVersionarte {
  final ReleaseDetails minimum;
  final ReleaseDetails latest;
  final Availability availability;
  final Map<String?, List<String?>?>? changelog;

  const PlatformVersionarte({
    required this.minimum,
    required this.latest,
    required this.availability,
    required this.changelog,
  });

  factory PlatformVersionarte.fromJson(Map<String, dynamic> json) {
    final Map<String?, List<String?>?> changelog_ = {};

    json['changelog']?.forEach(
      (String? key, dynamic value) {
        changelog_[key] = value.cast<String?>();
      },
    );
    return PlatformVersionarte(
      minimum: ReleaseDetails.fromJson(json["minimum"]),
      latest: ReleaseDetails.fromJson(json["latest"]),
      availability: Availability.fromJson(json["availability"]),
      changelog: changelog_,
    );
  }
}

class Availability {
  final bool available;
  final String? message;
  final String? details;

  const Availability({
    required this.available,
    required this.message,
    required this.details,
  });

  factory Availability.fromJson(Map<String, dynamic> json) {
    return Availability(
      available: json["available"],
      message: json["message"],
      details: json["details"],
    );
  }
}

class ReleaseDetails {
  final int number;
  final String name;

  const ReleaseDetails({
    required this.number,
    required this.name,
  });

  factory ReleaseDetails.fromJson(Map<String, dynamic> json) {
    return ReleaseDetails(
      number: json["number"],
      name: json["name"],
    );
  }
}
