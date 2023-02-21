import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:versionarte/src/helpers/logger.dart';
import 'package:versionarte/versionarte.dart';

/// A utility class that helps to check the version of the app on the device
/// against the version available on the app store.
class Versionarte {
  static PackageInfo? _packageInfo;
  static LocalVersioning? _localVersioning;

  /// Retrieves package information from the platform. This method uses the
  /// `package_info_plus` package to get the package information.
  static Future<PackageInfo?> get packageInfo async {
    _packageInfo ??= await PackageInfo.fromPlatform();
    return _packageInfo;
  }

  /// Cached version of [LocalVersioning] used when calling the
  /// `Versionarte.check(...)` method. This is used internally for the
  /// [VersionarteIndicator] widget.
  static LocalVersioning? get localVersioning => _localVersioning;

  /// Main method to check app versioning status. This method takes two
  /// parameters:
  ///
  /// - `versionarteProvider`: A [VersionarteProvider] instance to retrieve
  /// [StoreVersioning] stored remotely, most probably.
  /// - `localVersioning`: [LocalVersioning] of the currently running app. If
  /// it is not provided, the version information is obtained from the package
  /// information using [PackageInfo]. If you keep your current app version
  /// somewhere in your Dart codes, you can set a [LocalVersioning] manually.
  ///
  /// This method returns a [VersionarteResult] instance with the status of the
  /// app's versioning status.
  static Future<VersionarteResult> check({
    required VersionarteProvider versionarteProvider,
    LocalVersioning? localVersioning,
  }) async {
    try {
      localVersioning ??= await LocalVersioning.fromPackageInfo();
      _localVersioning = localVersioning;

      if (localVersioning == null) {
        return VersionarteResult(
          VersionarteStatus.failedToCheck,
          message: 'Failed to get local versioning information.',
        );
      }

      logV('Received LocalVersioning: $localVersioning');
      logV('Checking versionarte using ${versionarteProvider.runtimeType}');

      final storeVersioning = await versionarteProvider.getStoreVersioning();

      if (storeVersioning == null) {
        return VersionarteResult(
          VersionarteStatus.failedToCheck,
          message: 'Failed to get store versioning information using ${versionarteProvider.runtimeType}.',
        );
      }

      logV('Received StoreVersioning: \n$storeVersioning');

      final platformVersionarte = storeVersioning.platformVersionarte;

      final available = platformVersionarte.availability.available;
      if (!available) {
        return VersionarteResult(
          VersionarteStatus.unavailable,
          details: platformVersionarte,
        );
      }

      final localPlatformVersion = localVersioning.platformVersion;
      if (localPlatformVersion == null) {
        return VersionarteResult(
          VersionarteStatus.failedToCheck,
          message: 'LocalVersioning does not contain a version number for the platform $defaultTargetPlatform.',
        );
      }

      final storeMinPlatformVersion = platformVersionarte.minimum.number;
      final mustUpdate = storeMinPlatformVersion > localPlatformVersion;
      if (mustUpdate) {
        return VersionarteResult(
          VersionarteStatus.mustUpdate,
          details: platformVersionarte,
        );
      }

      final storeLatestPlatformVersion = platformVersionarte.latest.number;
      final couldUpdate = storeLatestPlatformVersion > localPlatformVersion;

      if (couldUpdate) {
        return VersionarteResult(
          VersionarteStatus.couldUpdate,
          details: platformVersionarte,
        );
      }

      return VersionarteResult(
        VersionarteStatus.upToDate,
        details: platformVersionarte,
      );
    } on FormatException catch (e) {
      final message = versionarteProvider is RemoteConfigVersionarteProvider
          ? 'Failed to parse json received from Firebase Remote Config. Check out the example json file at path /versionarte.json, and make sure that the one you\'ve uploaded matches the pattern. If you have uploaded it with a custom key name make sure you specify keyName as a constructor to RemoteConfigVersionarteProvider.'
          : versionarteProvider is RestfulVersionarteProvider
              ? 'Failed to parse json received from RESTful API endpoint. Check out the example json file at path /versionarte.json, and make sure that endpoint response body matches the pattern.'
              : e.toString();

      return VersionarteResult(
        VersionarteStatus.failedToCheck,
        message: message,
      );
    } catch (e, s) {
      logV('Exception: $e');
      logV('Stack Trace: $s');

      return VersionarteResult(
        VersionarteStatus.failedToCheck,
        message: 'An error occurred while checking for updates. Check the debug console to see the error and stack trace.',
      );
    }
  }

  /// Opens the app's page on the Play Store on Android and the App Store on iOS
  /// using the `url_launcher` package.
  ///
  /// On Android, the `androidPackageName` parameter is used to generate the
  /// Play Store URL. If the parameter is `null`, the package name is retrieved
  /// automatically from the device's `package_info` package. On iOS, the
  /// `appleAppId` parameter is used to generate the App Store URL.
  ///
  /// If the platform is not Android or iOS, the method logs an error message and
  /// returns `false`.
  ///
  /// Parameters:
  ///   - `appleAppId` (int): The app ID of the app on the App Store (iOS).
  ///     If the app is not published on the App Store, pass `null`.
  ///   - `androidPackageName` (String): The package name of the app (Android).
  ///
  /// Returns:
  ///   - A `Future<bool>` that indicates whether the URL was successfully
  ///     launched or not.
  static Future<bool> openAppInStore({
    required int? appleAppId,
    String? androidPackageName,
  }) async {
    if (Platform.isAndroid) {
      // Retrieve package name from device's `package_info` package if needed
      androidPackageName ??= (await packageInfo)?.packageName;

      if (androidPackageName != null) {
        // Generate Play Store URL and launch it
        return launchUrl(
          Uri.parse(
            'https://play.google.com/store/apps/details?id=$androidPackageName',
          ),
        );
      } else {
        // Unable to retrieve package name
        return false;
      }
    } else if (Platform.isIOS) {
      // Generate App Store URL and launch it
      return launchUrl(
        Uri.parse(
          'https://apps.apple.com/app/id$appleAppId',
        ),
      );
    } else {
      // Platform is not supported
      logV('${Platform.operatingSystem} is not supported.');
      return false;
    }
  }
}
