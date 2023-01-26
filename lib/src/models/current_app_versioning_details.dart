class CurrentAppServerdideVersioningDetails {
  final int androidVersion;
  final int iosVersion;

  const CurrentAppServerdideVersioningDetails({
    required this.androidVersion,
    required this.iosVersion,
  });

  factory CurrentAppServerdideVersioningDetails.fromPackageInfo() {
    return const CurrentAppServerdideVersioningDetails(
      androidVersion: 0,
      iosVersion: 0,
    );
  }
}
