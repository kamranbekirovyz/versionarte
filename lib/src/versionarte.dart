import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:versionarte/src/versionarte_decision.dart';

class Versionarte {
  FirebaseRemoteConfig? _remoteConfig;

  Future<VersionarteDecision> checkDecision() async {
    try {
      await _remoteConfig?.ensureInitialized();

      return VersionarteDecision.unknown;
    } catch (e, s) {
      return VersionarteDecision.unknown;
    }
  }

  Future<void> initializeRemoteConfig(
    RemoteConfigSettings? remoteConfigSettings,
    FirebaseRemoteConfig? remoteConfig,
  ) async {
    _remoteConfig = remoteConfig ?? FirebaseRemoteConfig.instance;

    remoteConfigSettings = RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 15),
      minimumFetchInterval: Duration.zero,
    );

    await _remoteConfig?.setConfigSettings(remoteConfigSettings);
  }
}
