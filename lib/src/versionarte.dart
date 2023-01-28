import 'dart:async';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:versionarte/src/helpers/logger.dart';
import 'package:versionarte/src/models/versionarte_result.dart';
import 'package:versionarte/src/providers/versionarte_provider.dart';
import 'package:versionarte/versionarte.dart';

class Versionarte {
  static PackageInfo? _packageInfo;

  /// Returns current platform package info.
  ///
  /// To see properties, check [PackageInfo] class.
  static Future<PackageInfo?> get packageInfo async {
    _packageInfo ??= await PackageInfo.fromPlatform();

    return _packageInfo;
  }

  static Future<VersionarteResult> check({
    required VersionarteProvider versionarteProvider,
    required CurrentVersioning? currentVersioning,
  }) async {
    try {
      if (currentVersioning == null) {
        logV('A null CurrentVersioning instance received :( terminating the process.');

        return VersionarteResult(
          VersionarteDecision.failedToCheck,
          message: 'A null `CurrentVersioning` received. If you\'ve used `CurrentVersioning.fromPackageInfo`, package_info plugin might have failed.',
        );
      }

      logV('Received CurrentVersioning: $currentVersioning');
      logV('Checking versionarte using ${versionarteProvider.runtimeType}');

      final serversideVersioning = await versionarteProvider.getVersioningDetails();

      if (serversideVersioning == null) {
        logV('Some error(s) occured while fetching servers-side versioning details.');

        return VersionarteResult(
          VersionarteDecision.failedToCheck,
          message: 'For some unknown reasons ServersideVersioning could not be fetched.',
        );
      }

      logV('Received ServersideVersioning: \n$serversideVersioning');

      final inactive = serversideVersioning.inactive;
      if (inactive) {
        return VersionarteResult(
          VersionarteDecision.inactive,
          message: serversideVersioning.inactiveDescription,
          serversideVersioning: serversideVersioning,
        );
      }

      final currentPlatformVersion = currentVersioning.platformVersion;

      final serversideMinPlatformVersion = serversideVersioning.minPlatformVersion;
      final mustUpdate = serversideMinPlatformVersion > currentPlatformVersion;
      if (mustUpdate) {
        return VersionarteResult(
          VersionarteDecision.mustUpdate,
          serversideVersioning: serversideVersioning,
        );
      }

      final serversideLatestPlatformVersion = serversideVersioning.latestPlatformVersion;
      final shouldUpdate = serversideLatestPlatformVersion > currentPlatformVersion;
      if (shouldUpdate) {
        return VersionarteResult(
          VersionarteDecision.couldUpdate,
          serversideVersioning: serversideVersioning,
        );
      }

      return VersionarteResult(VersionarteDecision.upToDate);
    } on FormatException catch (e) {
      if (versionarteProvider is RemoteConfigVersionarteProvider) {
        return VersionarteResult(
          VersionarteDecision.failedToCheck,
          message: 'Failed to parse json received from RemoteConfig. Check out the example json file at path /versionarte.json, and make sure that the one you\'ve uploaded to RemoteConfig matches the pattern. If you have uploaded it with a custom key name  make sure you specify as a `keyName`.',
        );
      } else if (versionarteProvider is RestfulVersionarteProvider) {
        return VersionarteResult(
          VersionarteDecision.failedToCheck,
          message: 'Failed to parse json received from RESTful API endpoint. Check out the example json file at path /versionarte.json, and make sure that endpoint response body matches the pattern.',
        );
      } else {
        return VersionarteResult(
          VersionarteDecision.failedToCheck,
          message: e.toString(),
        );
      }
    } catch (e, s) {
      logV('Exception: $e');
      logV('Stack Trace: $s');

      return VersionarteResult(
        VersionarteDecision.failedToCheck,
        message: e.toString(),
      );
    }
  }
}
