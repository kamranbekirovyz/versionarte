class ServerdideVersioningDetails {
  final String? inactiveDescription;
  final int minAndroidVersion;
  final int minIosVersion;
  final int latestAndroidVersion;
  final int latestIosVersion;
  final bool inactive;

  const ServerdideVersioningDetails({
    required this.inactiveDescription,
    required this.minAndroidVersion,
    required this.latestAndroidVersion,
    required this.minIosVersion,
    required this.latestIosVersion,
    required this.inactive,
  });

  factory ServerdideVersioningDetails.fromJson(Map<String, dynamic> json) {
    return ServerdideVersioningDetails(
      inactiveDescription: json['inactive_description'],
      minAndroidVersion: json['min_android_version'],
      minIosVersion: json['min_ios_version'],
      latestAndroidVersion: json['latest_android_version'],
      latestIosVersion: json['latest_ios_version'],
      inactive: json['in_active'] ?? false,
    );
  }
}
