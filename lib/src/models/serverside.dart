class ServersideVersioning {
  final VersionartePlatform android;
  final VersionartePlatform ios;
  final Attributes attributes;
  final Changelog changelog;

  const ServersideVersioning({
    required this.android,
    required this.ios,
    required this.attributes,
    required this.changelog,
  });

  factory ServersideVersioning.fromJson(Map<String, dynamic> json) {
    return ServersideVersioning(
      android: VersionartePlatform.fromJson(json["android"]),
      ios: VersionartePlatform.fromJson(json["ios"]),
      attributes: Attributes.fromJson(json["attributes"]),
      changelog: Changelog.fromJson(json["changelog"]),
    );
  }
}

class VersionartePlatform {
  VersionartePlatform({
    required this.minimum,
    required this.latest,
    required this.active,
  });

  final ReleaseDetails minimum;
  final ReleaseDetails latest;
  final bool active;

  factory VersionartePlatform.fromJson(Map<String, dynamic> json) {
    return VersionartePlatform(
      minimum: ReleaseDetails.fromJson(json["minimum"]),
      latest: ReleaseDetails.fromJson(json["latest"]),
      active: json["active"] ?? false,
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

class Attributes {
  final String inactiveMessage;
  final String inactiveDetails;
  final Map<String, dynamic>? raw;

  const Attributes({
    required this.inactiveMessage,
    required this.inactiveDetails,
    required this.raw,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) {
    return Attributes(
      inactiveMessage: json["inactive_message"],
      inactiveDetails: json["inactive_details"],
      raw: json,
    );
  }

  String getAttribute(String key) => raw?[key];
}

class Changelog {
  final List<String> en;
  final List<String> es;

  const Changelog({
    required this.en,
    required this.es,
  });

  factory Changelog.fromJson(Map<String, dynamic> json) {
    return Changelog(
      en: List<String>.from(json["en"].map((x) => x)),
      es: List<String>.from(json["es"].map((x) => x)),
    );
  }
}
