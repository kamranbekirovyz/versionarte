import 'dart:async';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:versionarte/src/helpers/logger.dart';
import 'package:versionarte/src/models/versionarte_result.dart';
import 'package:versionarte/src/providers/versionarte_provider.dart';
import 'package:versionarte/versionarte.dart';

class Versionarte {
  static PackageInfo? _packageInfo;
  static FutureOr<PackageInfo?> get packageInfo async {
    _packageInfo ??= await PackageInfo.fromPlatform();

    return _packageInfo;
  }

  static Future<VersionarteResult> check({
    required VersionarteProvider versionarteProvider,
    required CurrentVersioningDetails? currentVersioningDetails,
  }) async {
    try {
      if (currentVersioningDetails == null) {
        logV('A null CurrentVersioningDetails instance received :( terminating the process.');

        return VersionarteResult(
          VersionarteDecision.nullCurrentVersioningDetails,
          message: 'A null `CurrentVersioningDetails` received. If you\'ve used `CurrentVersioningDetails.fromPackageInfo`, package_info plugin might have failed.',
        );
      }

      logV('Received CurrentVersioningDetails: $currentVersioningDetails');
      logV('Checking versionarte using ${versionarteProvider.runtimeType}');

      final serversideVersioningDetails = await versionarteProvider.getVersioningDetails();

      if (serversideVersioningDetails == null) {
        logV('Some error(s) occured while fetching servers-side versioning details.');

        return VersionarteResult(
          VersionarteDecision.unknown,
          message: 'For some unknown reasons ServersideVersioningDetails could not be fetched.',
        );
      }

      logV('Received ServersideVersioningDetails: \n$serversideVersioningDetails');

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
      if (versionarteProvider is RemoteConfigVersionarteProvider) {
        return VersionarteResult(
          VersionarteDecision.failedToParseJson,
          message: 'Failed to parse json received from RemoteConfig. Check out the example json file at path /versionarte.json, and make sure that the one you\'ve uploaded to RemoteConfig matches the pattern. If you have uploaded it with a custom key name  make sure you specify as a `keyName`.',
        );
      } else if (versionarteProvider is RestfulVersionarteProvider) {
        return VersionarteResult(
          VersionarteDecision.failedToParseJson,
          message: 'Failed to parse json received from RESTful API endpoint. Check out the example json file at path /versionarte.json, and make sure that endpoint response body matches the pattern.',
        );
      } else {
        return VersionarteResult(
          VersionarteDecision.unknown,
          message: e.toString(),
        );
      }
    } catch (e, s) {
      logV('Exception: $e');
      logV('Stack Trace: $s');

      return VersionarteResult(
        VersionarteDecision.unknown,
        message: e.toString(),
      );
    }
  }
}
