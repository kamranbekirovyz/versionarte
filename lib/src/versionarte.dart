import 'dart:developer';

import 'package:versionarte/src/models/current_versioning_details.dart';
import 'package:versionarte/src/models/versionarte_decision.dart';
import 'package:versionarte/src/models/versionarte_result.dart';
import 'package:versionarte/src/providers/versionarte_provider.dart';

class Versionarte {
  static Future<VersionarteResult> check({
    required VersionarteProvider versionarteProvider,
    required CurrentVersioningDetails currentVersioningDetails,
  }) async {
    try {
      final serversideVersioningDetails = await versionarteProvider.getVersioningDetails();

      if (serversideVersioningDetails == null) {
        return const VersionarteResult(
          VersionarteDecision.unknown,
        );
      }

      final inactive = serversideVersioningDetails.inactive;
      if (inactive) {
        return VersionarteResult(
          VersionarteDecision.inactive,
          message: serversideVersioningDetails.inactiveDescription,
          details: serversideVersioningDetails,
        );
      }

      final currentPlatformVersion = currentVersioningDetails.platformVersion;

      final serversideMinPlatformVersion = serversideVersioningDetails.minPlatformVersion;
      final mustUpdate = serversideMinPlatformVersion > currentPlatformVersion;
      if (mustUpdate) {
        return VersionarteResult(
          VersionarteDecision.mustUpdate,
          details: serversideVersioningDetails,
        );
      }

      final serversideLatestPlatformVersion = serversideVersioningDetails.latestPlatformVersion;
      final shouldUpdate = serversideLatestPlatformVersion > currentPlatformVersion;
      if (shouldUpdate) {
        return VersionarteResult(
          VersionarteDecision.shouldUpdate,
          details: serversideVersioningDetails,
        );
      }

      return const VersionarteResult(VersionarteDecision.upToDate);
    } catch (e, s) {
      _log('Exception: $e');
      _log('Stack Trace: $s');

      return VersionarteResult(
        VersionarteDecision.unknown,
        message: e.toString(),
      );
    }
  }
}

/// A simple logging utility function.
void _log(String? s) {
  // TODO: replace with logar..
  log('[VERSIONARTE] $s');
}
