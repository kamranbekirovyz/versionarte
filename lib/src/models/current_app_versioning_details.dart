class CurrentAppServersideVersioningDetails {
  final int androidVersion;
  final int iosVersion;

  const CurrentAppServersideVersioningDetails({
    required this.androidVersion,
    required this.iosVersion,
  });

  factory CurrentAppServersideVersioningDetails.fromPackageInfo() {
    return const CurrentAppServersideVersioningDetails(
      androidVersion: 0,
      iosVersion: 0,
    );
  }
}
