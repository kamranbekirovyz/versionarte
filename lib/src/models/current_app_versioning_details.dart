class CurrentAppVersioningDetails {
  final int androidVersion;
  final int iosVersion;

  const CurrentAppVersioningDetails({
    required this.androidVersion,
    required this.iosVersion,
  });

  factory CurrentAppVersioningDetails.fromPackageInfo() {
    return const CurrentAppVersioningDetails(
      androidVersion: 0,
      iosVersion: 0,
    );
  }
}
