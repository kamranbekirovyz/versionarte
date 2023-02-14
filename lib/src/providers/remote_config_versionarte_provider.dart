import 'dart:async';
import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:versionarte/src/models/serverside_versioning.dart';
import 'package:versionarte/src/providers/versionarte_provider.dart';

class RemoteConfigVersionarteProvider extends VersionarteProvider {
  final _remoteConfig = FirebaseRemoteConfig.instance;
  late final String _keyName;
  late final RemoteConfigSettings _remoteConfigSettings;
  late final bool _initializeRemoteConfig;

  /// A `VersionarteProvider` that helps retrieve `ServersideVersioning`
  /// information stored in `Firebase Remote Config` with a key name
  /// "versionarte" unless specified differently using `keyName` constructor
  /// property.
  ///
  /// By default `fetchTimeout` is set to 7 seconds, `minimumFetchInterval` to
  /// `Duration.zero`.
  ///
  /// To see example json file, check /versionarte.json file.
  RemoteConfigVersionarteProvider({
    bool initializeRemoteConfig = true,
    RemoteConfigSettings? remoteConfigSettings,
    String keyName = 'versionarte',
  }) {
    _keyName = keyName;
    _initializeRemoteConfig = initializeRemoteConfig;

    if (initializeRemoteConfig) {
      _remoteConfigSettings = remoteConfigSettings ??
          RemoteConfigSettings(
            fetchTimeout: const Duration(seconds: 7),
            minimumFetchInterval: Duration.zero,
          );
    }
  }

  /// Initializes (sets configurations) for `Firebase Remote Config`
  Future<void> _initialize(RemoteConfigSettings settings) async {
    return _remoteConfig.setConfigSettings(settings);
  }

  /// Fetches json uploaded to the `Firebase Remote Config`, parses it into an
  /// instance of `ServersideVersioning`
  @override
  FutureOr<ServersideVersioning?> getVersioningDetails() async {
    if (_initializeRemoteConfig) {
      await _initialize(_remoteConfigSettings);
    }

    await _remoteConfig.fetchAndActivate();

    final versionarteString = _remoteConfig.getString(_keyName);
    final versionarteDecoded = jsonDecode(versionarteString);

    return ServersideVersioning.fromJson(versionarteDecoded);
  }
}
