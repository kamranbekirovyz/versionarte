import 'dart:async';
import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:versionarte/src/models/serverside_versioning.dart';
import 'package:versionarte/src/providers/versionarte_provider.dart';

class RemoteConfigVersionarteProvider extends VersionarteProvider {
  final _remoteConfig = FirebaseRemoteConfig.instance;
  late final String _keyName;

  /// Initializes [FirebaseRemoteConfig] for this project, if not initialized.
  ///
  /// By default [fetchTimeout] is set to 7 seconds, [minimumFetchInterval] to
  /// Duration.zero.
  RemoteConfigVersionarteProvider({
    bool initializeRemoteConfig = true,
    RemoteConfigSettings? remoteConfigSettings,
    String keyName = 'versionarte',
  }) {
    _keyName = keyName;

    if (initializeRemoteConfig) {
      remoteConfigSettings = remoteConfigSettings ??
          RemoteConfigSettings(
            fetchTimeout: const Duration(seconds: 7),
            minimumFetchInterval: Duration.zero,
          );

      _initialize(remoteConfigSettings);
    }
  }

  Future<void> _initialize(RemoteConfigSettings settings) async {
    return _remoteConfig.setConfigSettings(settings);
  }

  @override
  FutureOr<ServersideVersioning?> getVersioningDetails() async {
    await _remoteConfig.fetchAndActivate();

    final versionarteString = _remoteConfig.getString(_keyName);
    final versionarteDecoded = jsonDecode(versionarteString);

    return ServersideVersioning.fromJson(versionarteDecoded);
  }
}
