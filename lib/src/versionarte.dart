import 'dart:developer';
import 'dart:io';

import 'package:versionarte/src/models/current_app_versioning_details.dart';
import 'package:versionarte/src/models/versionarte_decision.dart';
import 'package:versionarte/src/models/versionarte_result.dart';
import 'package:versionarte/src/providers/versionarte_provider.dart';

class Versionarte {
  late final VersionarteProvider _versionarteProvider;

  void configure(VersionarteProvider versionarteProvider) {
    _versionarteProvider = _versionarteProvider;
  }

  Future<VersionarteResult> check(
    CurrentAppVersioningDetails currentAppVersioningDetails,
  ) async {
    try {
      final serversideVersioningDetails = await _versionarteProvider.getVersioningDetails();

      final inactive = serversideVersioningDetails.inactive;
      if (inactive) {
        return VersionarteResult(
          VersionarteDecision.inactive,
          message: serversideVersioningDetails.inactiveDescription,
          details: serversideVersioningDetails,
        );
      }

      final currentPlatformVersion = Platform.isAndroid ? currentAppVersioningDetails.androidVersion : currentAppVersioningDetails.iosVersion;

      final serversideMinPlatformVersion = Platform.isAndroid ? serversideVersioningDetails.minAndroidVersion : serversideVersioningDetails.minIosVersion;
      final mustUpdate = serversideMinPlatformVersion > currentPlatformVersion;
      if (mustUpdate) {
        return VersionarteResult(
          VersionarteDecision.mustUpdate,
          details: serversideVersioningDetails,
        );
      }

      final serversideLatestPlatformVersion = Platform.isAndroid ? serversideVersioningDetails.latestAndroidVersion : serversideVersioningDetails.latestIosVersion;
      final shouldUpdate = serversideLatestPlatformVersion > currentPlatformVersion;
      if (shouldUpdate) {
        return VersionarteResult(
          VersionarteDecision.shouldUpdate,
          details: serversideVersioningDetails,
        );
      }

      return const VersionarteResult(VersionarteDecision.upToDate);
    } catch (e, s) {
      log('[VERSIONARTE] Exception: $e');
      log('[VERSIONARTE] Stack Trace: $s');

      return VersionarteResult(
        VersionarteDecision.unknown,
        message: e.toString(),
      );
    }
  }
}
