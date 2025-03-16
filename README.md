# versionarte

Force update, show update indicator and disable the app for maintenance with total freedom over the UI.

<!-- <img src="https://raw.githubusercontent.com/kamranbekirovyz/versionarte/main/assets/cover.png" alt="cover_picture" /> -->

## 😎 Benefits

- ✋ Force users to update to the latest version
- 💆🏻‍♂️ Have separate values for each platform
- 🚧 Disable app for maintenance with custom informative text
- 🆕 Inform users about an optional update availability
- 🔗 Launch the App Store on iOS and Play Store on Android

|Forced update|New version indicator|Maintenance mode|
|---|---|---|
|<img width="200" src="https://github.com/kamranbekirovyz/versionarte/blob/main/assets/screenshots/forced-update.png?raw=true"/>|<img width="200" src="https://github.com/kamranbekirovyz/versionarte/blob/main/assets/screenshots/outdated.png?raw=true"/>|<img width="200" src="https://github.com/kamranbekirovyz/versionarte/blob/main/assets/screenshots/inactive.png?raw=true"/>


## 💖 Sponsors

<img src="https://www.userorient.com/assets/extras/sponsor.png">

## 🛫 Getting Started

Add the package and import it:

```yaml
dependencies:
  versionarte: <latest_version>
```

```dart
import 'package:versionarte/versionarte.dart';
```

## 📡 Checking Version Status

Call `Versionarte.check` with a provider to get the app's versioning status:

```dart
// Using Firebase Remote Config (most common)
final result = await Versionarte.check(
    versionarteProvider: RemoteConfigVersionarteProvider(),
);
```

Choose from three provider types based on your backend:

### 1. Using Firebase Remote Config

**Recommended for apps already using Firebase**

```dart
final result = await Versionarte.check(
    versionarteProvider: RemoteConfigVersionarteProvider(),
);
```

Optional parameters:
- `keyName`: Firebase config key (default: "versionarte")
- `initializeInternally`: Set to `false` if your app already initializes Firebase
- `remoteConfigSettings`: Custom settings if needed

See <a href="https://github.com/kamranbekirovyz/versionarte/blob/main/firebase_remote_config_setup.md#-firebase-remote-config-setup-guide" target="_blank">Firebase Remote Config setup guide</a> for configuration details.

### 2. Using RESTful API

**Recommended for apps with custom backends**

```dart
final result = await Versionarte.check(
    versionarteProvider: RestfulVersionarteProvider(
        url: 'https://myapi.com/getVersioning',
    ),
);
```

Optional parameters:
- `headers`: Custom HTTP headers if needed

### 3. Using Custom VersionarteProvider

**For advanced use cases with custom data sources**

```dart
class MyCustomVersionarteProvider extends VersionarteProvider {
  @override
  Future<StoreVersioning> getStoreVersioning() async {
    final result = MyCustomService.fetchVersioning();
    final decodedResult = jsonDecode(result);
    return StoreVersioning.fromJson(decodedResult);
  }
}
```

## 🎯 Handle the Status

Use the `status` value to determine what action to take:

```dart
if (result.status == VersionarteStatus.inactive) {
    // App is in maintenance mode
    final message = result.details.status.getMessageForLanguage('en');
    showMaintenanceScreen(message);
} else if (result.status == VersionarteStatus.forcedUpdate) {
    // User must update to continue
    showForceUpdateScreen();
    await Versionarte.launchDownloadUrl(result.storeVersioning!.downloadUrls);
} else if (result.status == VersionarteStatus.outdated) {
    // Update available but optional
    showUpdateBanner();
} else if (result.status == VersionarteStatus.upToDate) {
    // App is up to date, continue as normal
    continueToApp();
}
```

## 🔗 Launching the Store

To open the appropriate store for the current platform:

```dart
await Versionarte.launchDownloadUrl(result.storeVersioning!.downloadUrls);
```

> **Note**: Add "download_url" in your configuration JSON for each platform. The correct store opens automatically based on the current platform.

See the <a href="https://github.com/kamranbekirovyz/versionarte/tree/main/example">example</a> directory for a complete sample app.

## 🖋️ Configuration JSON

The configuration JSON contains versioning and status information for each platform. **Only configure platforms that your app supports.**

```js
{
    "android": {
        "version": {
            "minimum": "2.7.0", // Minimum required version
            "latest": "2.8.0"   // Latest available version
        },
        "download_url": "https://play.google.com/store/apps/details?id=app.example",
        "status": {
            "active": true,     // Whether app is currently active
            "message": {        // Only needed if active is false
                "en": "App is in maintenance mode, please come back later.",
                "es": "La aplicación está en modo de mantenimiento, vuelva más tarde."
            }
        }
    },
    "iOS": {
        // Same structure as Android
    },
    // Optional: Include other platforms if needed (macOS, windows, linux)
}
```

## 🐞 Need help?

If you encounter any problems or need a feature, please raise a ticket on <a href=https://github.com/kamranbekirovyz/versionarte/issues>GitHub</a>.

## 📃 License

<a href="https://github.com/kamranbekirovyz/versionarte/blob/main/LICENSE">MIT License</a>