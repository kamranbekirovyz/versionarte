# versionarte

Remotely manage your Flutter app's versioning and availability, with a variety of helpful, and in some cases life-saving features with total freedom over the UI allowing you to customize the user experience to fit your app's branding and style.

<img src="https://raw.githubusercontent.com/kamranbekirovyz/versionarte/main/assets/cover.png" alt="cover_picture" />

Features can be implemented with versionarte:
- ✋ Force users to update to the latest version of your app before continuing
- 💆🏻‍♂️ Have separate minimum, latest versions and availability status for platforms
- 🚧 Disable your app for maintenance with custom information text
- 🆕 Inform users when an optional update is available
- 🔗 Launch the App Store on iOS and Play Store on Android

## 🏁 Getting started

How this works? Call `Versionarte.check` method by providing it a `VersionarteProvider` (an object responsible for fetching the versioning information from a remote service) which returns a `VersionarteResult` (an object containing app's versioning and availability information).

There are 2 built-in providers, [RemoteConfigVersionarteProvider](#1-using-firebase-remote-config) and [RestfulVersionarteProvider](#2-using-restful-api), which fetches the versioning information from Firebase Remote Config and RESTful API respectively. You can also create your own custom provider by extending the [VersionarteProvider](#3-using-custom-versionarteprovider) class.

💡 No need to try-catch the `Versionarte.check` method, as it catches all the errors internally and if something goes wrong, an instance of `VersionarteResult` with status `VersionarteStatus.unknown` is still returned.  
💡 Be sure to check the debug console to see insightful debug-only prints.

### 1. Using Firebase Remote Config

The `RemoteConfigVersionarteProvider` fetches information stored in Firebase Remote Config with the key name of "versionarte". You need to set up the Firebase Remote Config service before using this provider. See <a href="https://github.com/kamranbekirovyz/versionarte/blob/main/firebase_remote_config_setup.md#-firebase-remote-config-setup-guide" target="_blank">Firebase Remote Config setup guide</a> to learn more about configuration.

Example:

```dart
final result = await Versionarte.check(
    versionarteProvider: RemoteConfigVersionarteProvider(),
);
```

Optional parameters:
- `keyName`: key name for the Firebase Remote Config to fetch. By default, it's set to "versionarte". Specify if you upload the [configuration JSON](#%EF%B8%8F-configuration-json) using a different key name.
- `initializeInternally`: if your project already initializes and configures Firebase Remote Config, set this to `false`. By default, it's set to `true`.
- `remoteConfigSettings`: settings for Firebase Remote Config if `initializeInternally` set to true. By default, `fetchTimeout` and `minimumFetchInterval` are set to `10 seconds`.

### 2. Using RESTful API

The `RestfulVersionarteProvider` fetches versioning and availability information by sending HTTP GET request to the specified URL with optional headers. The response body should be a JSON string that follows the [configuration JSON](#%EF%B8%8F-configuration-json) format.

Example:

```dart
final result = await Versionarte.check(
    versionarteProvider: RestfulVersionarteProvider(
        url: 'https://myapi.com/getVersioning',
    ),
);
```

Optional parameters:
- `headers`: headers to send with the HTTP GET request. By default, it's set to an empty map.

### 3. Using custom VersionarteProvider

To use remote services to provide versioning and availability information of your app, extend the `VersionarteProvider` class and override the `getStoreVersioning` method which is responsible for fetching the information and returning it as a `StoreVersioning` object.

```dart
class MyCustomVersionarteProvider extends VersionarteProvider {
  @override
  Future<StoreVersioning> getStoreVersioning() async {
    final result = MyCustomService.fetchVersioning();

    final decodedResult = jsonDecode(result);

    return StoreVersioning.fromJson(decodedResult);
  }
```
    
Example:
```dart
final result = await Versionarte.check(
    versionarteProvider: MyCustomVersionarteProvider(),
);
```

## 🙌 Handle the result

Obtained `VersionarteResult` has 3 parameters:

- `status`: (VersionarteResult) the status of the app. It can be one of the following values:
    - `VersionarteStatus.appInactive`: the app is inactive for usage.
    - `VersionarteStatus.mustUpdate`:  user must update before continuing.
    - `VersionarteStatus.shouldUpdate`: user can continue with and without updating.
    - `VersionarteStatus.upToDate`: the user's version is up to date.
    - `VersionarteStatus.unknown`: error occured while checking status.
- `details`: (StorePlatformDetails) Details for the current platform, including messages for when the app is inactive. 

Then, based on `status` do the if-else checks:

```dart
if (result == VersionarteResult.appInactive) {
    final message = result.status.getMessageForLanguage('en');
    // TODO: Handle the case where the app is inactive
} else if (result == VersionarteResult.mustUpdate) {
    // TODO: Handle the case where an update is required
} else if (result == VersionarteResult.shouldUpdate) {
    // TODO: Handle the case where an update is optional
} 
```

## 🔗 Launching the stores

To launch the App Store on iOS and Play Store on Android, use the `Versionarte.launchStore` method by providing it with `appleAppId` (int) for App Store and `androidPackageName` (String) for Play Store.

```dart
Versionarte.launchStore(
    appleAppId: 123456789,
    androidPackageName: 'com.example.app',
);
```

💡 `androidPackageName` is optional: if not provided corresponding value obtained from `package_info` will be used.
💡 It's suggested to test launching store on a real device.

See the <a href="https://github.com/kamranbekirovyz/versionarte/tree/main/example">example</a> directory for a complete sample app.

## 🖋️ Configuration JSON

For providing app's status and availability information, versionarte requires a specific JSON format. Whether you're using `RemoteConfigVersionarteProvider`, `RestfulVersionarteProvider`, or a custom `VersionarteProvider`, make sure to use this JSON format.

💡 Information for all platforms in the JSON is not necessary: you can provide information for only one platform, or for two platforms, or for all three platforms.   
💡 While the app status is active, the `message` can be left empty or set to `null`.

```js
{
    "android": {
        "version": {
            "minimum": "2.7.0",
            "latest": "2.8.0"
        },
        "status": {
            "active": true,
            "message": {
                "en": "App is in maintanence mode, please come back later.",
                "es": "La aplicación está en modo de mantenimiento, vuelva más tarde."
            }
        }
    },
    "iOS": {
        // same data we used for "android"
    }
    "macOS": {
        // same data we used for "android"
    }
}
```

This JSON represents information stored separately for three platforms, containing the minimum and latest versions, and the availability status.

Each platform contains two objects:

- `version`:
    - `minimum`: The minimum version of the app users can use. 
    - `latest`: The latest version of the app available. 
- `status`:
    - `active`: A boolean that indicates whether the app is currently active or not.
    - `message`: A Map that contains the messages for different languages to be displayed to the user when app is inactive. The keys of the map represent the language codes (e.g., "en" for English, "es" for Spanish), and the values represent the message in that language.

## 🐞 Bugs/Requests

If you encounter any problems please open an issue. If you feel the library is missing a feature, please raise a ticket on GitHub and we'll look into it. Pull requests are welcome.

## 📃 License

<a href="https://github.com/kamranbekirovyz/versionarte/blob/main/LICENSE">MIT License</a>