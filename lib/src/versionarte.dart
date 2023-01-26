import 'dart:io';

import 'package:versionarte/src/models/current_app_versioning_details.dart';
import 'package:versionarte/src/versionarte_decision.dart';
import 'package:versionarte/src/versionarte_provider.dart';

class Versionarte {
  // FirebaseRemoteConfig? _remoteConfig;
  late final VersionarteProvider _versionarteProvider;

  void configure(VersionarteProvider versionarteProvider) {
    _versionarteProvider = _versionarteProvider;
  }

  Future<VersionarteDecision> checkDecision(
    CurrentAppServerdideVersioningDetails currentAppServerdideVersioningDetails,
  ) async {
    try {
      final serversideVersioningDetails = await _versionarteProvider.getServerdideVersioningDetails();

      final inactive = serversideVersioningDetails.inactive;
      if (inactive) {
        return VersionarteDecision.inactive;
      }

      final currentPlatformVersion = Platform.isAndroid ? currentAppServerdideVersioningDetails.androidVersion : currentAppServerdideVersioningDetails.iosVersion;

      final serversideMinPlatformVersion = Platform.isAndroid ? serversideVersioningDetails.minAndroidVersion : serversideVersioningDetails.minIosVersion;
      final mustUpdate = serversideMinPlatformVersion > currentPlatformVersion;
      if (mustUpdate) {
        return VersionarteDecision.mustUpdate;
      }

      final serversideLatestPlatformVersion = Platform.isAndroid ? serversideVersioningDetails.latestAndroidVersion : serversideVersioningDetails.latestIosVersion;
      final shouldUpdate = serversideLatestPlatformVersion > currentPlatformVersion;
      if (shouldUpdate) {
        return VersionarteDecision.shouldUpdate;
      }

      return VersionarteDecision.upToDate;
    } catch (e, s) {
      return VersionarteDecision.unknown;
    }
  }
}
