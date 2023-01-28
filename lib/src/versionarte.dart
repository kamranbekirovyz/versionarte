import 'dart:developer';

import 'package:versionarte/src/models/versionarte_decision.dart';
import 'package:versionarte/src/models/versionarte_result.dart';
import 'package:versionarte/src/providers/versionarte_provider.dart';
import 'package:versionarte/versionarte.dart';

class Versionarte {
  static Future<VersionarteResult> check({
    required VersionarteProvider versionarteProvider,
    required CurrentVersioningDetails? currentVersioningDetails,
  }) async {
    try {
      if (currentVersioningDetails == null) {
        _log('A null CurrentVersioningDetails instance received :( terminating the process.');

        return VersionarteResult(
          VersionarteDecision.nullCurrentVersioningDetails,
          message: 'A null `CurrentVersioningDetails` received. If you\'ve used `CurrentVersioningDetails.fromPackageInfo`, package_info plugin might have failed.',
        );
      }

      _log('Received CurrentVersioningDetails: $currentVersioningDetails');
      _log('Checking versionarte using ${versionarteProvider.runtimeType}');

      final serversideVersioningDetails = await versionarteProvider.getVersioningDetails();

      if (serversideVersioningDetails == null) {
        _log('Some error(s) occured while fetching servers-side versioning details.');

        return VersionarteResult(
          VersionarteDecision.unknown,
          // TODO: add message
        );
      }

      _log('Received ServersideVersioningDetails: \n$serversideVersioningDetails');

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

      return VersionarteResult(VersionarteDecision.upToDate);
    } on FormatException catch (e) {
      // TODO: take RestfulVersionarteProvider into consideration.
      // if (versionarteProvider is RemoteConfigVersionarteProvider) {
      return VersionarteResult(
        VersionarteDecision.failedToParseJson,
        message: 'Failed to parse json received from RemoteConfig. Check out the example json file at path /versionarte.json, and make sure that the one you\'ve uploaded to RemoteConfig matches the pattern. If you have uploaded it with a custom key name  make sure you specify as a `keyName`.',
      );
      // }
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
