import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:versionarte/versionarte.dart';

/// A utility class that helps to check the version of the app on the device
/// against the version available on the app store.
class Versionarte {
  static PackageInfo? _packageInfo;

  /// Retrieves package information from the platform. This method uses the
  /// `package_info_plus` package to get the package information.
  static Future<PackageInfo> get packageInfo async {
    _packageInfo ??= await PackageInfo.fromPlatform();
    return _packageInfo!;
  }

  /// Checks app versioning status.
  ///
  /// Parameters:
  /// - `versionarteProvider`: A [VersionarteProvider] instance to retrieve
  /// [StoreVersioning] stored remotely.
  ///
  /// This method returns a [VersionarteResult] instance with the status of the
  /// app's versioning status.
  static Future<VersionarteResult> check({
    required VersionarteProvider versionarteProvider,
  }) async {
    try {
      final info = await packageInfo;
      final platformVersion = Version.parse(info.version);

      debugPrint('[VERSIONARTE] Current platform version: $platformVersion');
      debugPrint('[VERSIONARTE] VersionarteProvider: ${versionarteProvider.runtimeType}');

      final storeVersioning = await versionarteProvider.getStoreVersioning();

      if (storeVersioning == null) {
        return VersionarteResult(
          VersionarteStatus.unknown,
          message: 'Failed to get store versioning information using ${versionarteProvider.runtimeType}.',
        );
      }

      debugPrint('[VERSIONARTE] StoreVersioning: $storeVersioning');

      final storeDetails = storeVersioning.storeDetailsForPlatform;

      if (!storeDetails.active) {
        return VersionarteResult(
          VersionarteStatus.inactive,
          details: storeDetails,
        );
      } else {
        final minimumVersion = Version.parse(storeDetails.minimum);
        final latestVersion = Version.parse(storeDetails.latest);

        final minimumDifference = platformVersion.compareTo(minimumVersion);
        final latestDifference = platformVersion.compareTo(latestVersion);

        final status = minimumDifference < 0
            ? VersionarteStatus.mustUpdate
            : latestDifference == 0
                ? VersionarteStatus.upToDate
                : VersionarteStatus.couldUpdate;

        return VersionarteResult(
          status,
          details: storeDetails,
        );
      }
    } on FormatException catch (e) {
      final message = versionarteProvider is RemoteConfigVersionarteProvider
          ? 'Failed to parse json retrieved from Firebase Remote Config. '
              'Check out the example json file at path /versionarte.json, and make sure that the one you\'ve uploaded matches the pattern. '
              'If you have uploaded it with a custom key name make sure you specify keyName as a constructor to RemoteConfigVersionarteProvider.'
          : versionarteProvider is RestfulVersionarteProvider
              ? 'Failed to parse json received from RESTful API endpoint. '
                  'Check out the example json file at path /versionarte.json, and make sure that endpoint response body matches the pattern.'
              : e.toString();

      return VersionarteResult(
        VersionarteStatus.unknown,
        message: message,
      );
    } catch (e, s) {
      debugPrint('[VERSIONARTE] Exception: $e');
      debugPrint('[VERSIONARTE] Stack Trace: $s');

      return VersionarteResult(
        VersionarteStatus.unknown,
        message: 'An error occurred while checking for updates. '
            'Check the debug console to see the error and stack trace.',
      );
    }
  }

  /// Opens the app's page on the Play Store on Android and the App Store on iOS
  ///
  /// If the platform is not Android or iOS, the method logs an error message and
  /// returns `false`.
  ///
  /// Parameters:
  ///   - `appleAppId` (int): The app ID of the app on the App Store (iOS).
  ///     If the app is not published on the App Store, pass `null`.
  ///   - `androidPackageName` (String): The package name of the app (Android)
  ///     retrieved automatically from the device's `package_info` package
  ///
  /// Returns:
  ///   - A `Future<bool>` that indicates whether the URL was successfully
  ///     launched or not.
  static Future<bool> launchStore({
    required int? appleAppId,
    String? androidPackageName,
  }) async {
    const mode = LaunchMode.externalApplication;

    if (Platform.isAndroid) {
      // Retrieve package name from device's `package_info` package if needed
      androidPackageName ??= (await packageInfo).packageName;

      return launchUrl(
        Uri.parse(
          'https://play.google.com/store/apps/details?id=$androidPackageName',
        ),
        mode: mode,
      );
    } else if (Platform.isIOS) {
      return launchUrl(
        Uri.parse(
          'https://apps.apple.com/app/id$appleAppId',
        ),
        mode: mode,
      );
    } else {
      debugPrint('[VERSIONARTE] Opening store for ${Platform.operatingSystem} platform is not supported.');
      return false;
    }
  }
}
