# versionarte

Force update, show update indicator and disable the app for maintenance with total freedom over the UI.


## 😎 Benefits

- ✋ Force users to update to the latest version
- 💆🏻‍♂️ Have separate values for each platform
- 🚧 Disable app for maintenance with custom informative text
- 🆕 Inform users about an optional update availability
- 🔗 Launch the App Store on iOS and Play Store on Android

|Forced update|New version indicator|Maintenance mode|
|---|---|---|
|<img width="200" src="https://github.com/kamranbekirovyz/versionarte/blob/main/assets/screenshots/forced-update.png?raw=true"/>|<img width="200" src="https://github.com/kamranbekirovyz/versionarte/blob/main/assets/screenshots/outdated.png?raw=true"/>|<img width="200" src="https://github.com/kamranbekirovyz/versionarte/blob/main/assets/screenshots/inactive.png?raw=true"/>

Read the [How to force users to update your Flutter app](https://flutterdeeper.com/blog/versionarte) article for detailed explanation.

## 🩵 Sponsors

<a href="https://userorient.com" target="_blank">
  <img src="https://www.userorient.com/assets/extras/sponsor.png">
</a>

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
final VersionarteResult result = await Versionarte.check(
    versionarteProvider: RemoteConfigVersionarteProvider(),
);
```

Choose from three provider types based on your backend:

### 1. Using Firebase Remote Config

**Recommended for apps already using Firebase**

```dart
final VersionarteResult result = await Versionarte.check(
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
final VersionarteResult result = await Versionarte.check(
    versionarteProvider: RestfulVersionarteProvider(
        url: 'https://myapi.com/getVersioning',
    ),
);
```

Optional parameters:
- `headers`: Custom HTTP headers if needed

> **Note**: Your RESTful endpoint must return the same JSON structure as shown in the [Configuration JSON](#-configuration-json) section below. 

### 3. Using Custom VersionarteProvider

**For advanced use cases with custom data sources**

```dart
class MyCustomVersionarteProvider extends VersionarteProvider {
  @override
  Future<DistributionManifest> getDistributionManifest() async {
    final String result = MyCustomService.fetchVersioning();
    final Map<String, dynamic> decodedResult = jsonDecode(result);
    
    return DistributionManifest.fromJson(decodedResult);
  }
}
```

## 🎯 Handle the Status

Use the `status` value to determine what action to take:

```dart
if (result.status == VersionarteStatus.inactive) {
    // App is in maintenance mode
    final String message = result.getMessageForLanguage('en');

    showMaintenanceDialog(message);
} else if (result.status == VersionarteStatus.forcedUpdate) {
    // User must update to continue
    showForceUpdateDialog(
      onUpdate: () {
        Versionarte.launchDownloadUrl(result.downloadUrls);
      },
    );
} else if (result.status == VersionarteStatus.outdated) {
    // Update available but optional
    showOptionalUpdateDialog(
      onUpdate: () {
        Versionarte.launchDownloadUrl(result.downloadUrls);
      },
    );
} 
```

**Tip**: You can also show different widgets based on status. For example, when the app is outdated, you might want to show an update indicator anywhere in your app (for example in home page):

```dart
Widget build(BuildContext context) {
  return Column(
    children: [
      // other widgets   
      if (result.status == VersionarteStatus.outdated)
        // A custom widget to show "Update available"
        NewVersionAvailableIndicator(
          onUpdate: () {
            Versionarte.launchDownloadUrl(result.downloadUrls);
          }
        ),
      // other widgets
    ],
  );
}
```

## 🔗 Launching the Store

To open the appropriate store for the current platform:

```dart
await Versionarte.launchDownloadUrl(result.downloadUrls);
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