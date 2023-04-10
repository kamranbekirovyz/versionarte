# versionarte

Versionarte allows you to remotely manage your Flutter app's versioning and availability, with a variety of heplful, and in some cases life-saving features with total freedom over the UI allowing you to customize the user experience to fit your app's branding and style.

Features you can implement with versionarte:
- ✋ Force users to update to the latest version of your app before continuing.
- 💆🏻‍♂️ Have separate minimum, latest versions and availability status for platforms.
- 🚧 Disable your app for maintenance with custom information text.
- 🆕 Inform users when an optional update is available.
- 🔗 Launch the App Store on iOS and Play Store on Android.

<img src="https://raw.githubusercontent.com/kamranbekirovyz/versionarte/master/assets/cover.png" alt="cover_picture" />

## 👨‍🔬 Get the status

We get `VersionarteResult` (an object containing app status and availability information), by calling `Versionarte.check` method by providing it a `VersionarteProvider` (an object responsible for fetching the versioning information from the remote service). 

There are 2 built-in providers, `RemoteConfigVersionarteProvider` and `RestfulVersionarteProvider`, which fetches the versioning information from Firebase Remote Config and RESTful API respectively. You can also create your own custom provider by extending the `VersionarteProvider` class.

ℹ️ No need to try-catch the `Versionarte.check` method, as the it catches all the errors internally and if something goes wrong, an instance of `VersionarteResult` with status `VersionarteStatus.unknown` is returned.  
ℹ️ Be sure to check the debug console to see insightful the debug-only prints.

### 1. Using Firebase Remote Config

The `RemoteConfigVersionarteProvider` fetches information stored in Firebase Remote Config with the key name of "versionarte". You need to set up the Firebase Remote Config service before using this provider. See [Firebase Remote Config setup guide](#🚜-firebase-remote-config-setup-guide) to learn more about configuration.

Example:

```dart
final result = await Versionarte.check(
    versionarteProvider: RemoteConfigVersionarteProvider(),
);
```

Optional parameters:
- `keyName`: key name for the Firebase Remote Config to fetch. By default, it's set to "versionarte". Specify if you upload the [configuration JSON](#-json-format) using a different key name.

### 2. Using RESTful API

The `RestfulVersionarteProvider` fetches versioning and availability information by sending HTTP GET request to the specified URL with optional headers. The response body should be a JSON string that follows the [configuration JSON](#-json-format) format.

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

## 🙌 Handle the status

Obtained `VersionarteResult` has 3 parameters:

- `status`: (VersionarteResult) the status of the app. It can be one of the following values:
    - `VersionarteStatus.appInactive`: the app is inactive, user can't use the app.
    - `VersionarteStatus.mustUpdate`:  there is a mandatory update, user must update before continuing.
    - `VersionarteStatus.shouldUpdate`: there is an optional update, user can continue with and without updating.
    - `VersionarteStatus.upToDate`: the user is using the latest version.
    - `VersionarteStatus.unknown`: versioning status is unknown (some error occured while checking status).
- `details`: (StorePlatformDetails) Details for the current platform, including messages for when the app is inactive. 

Then, based on `VersionarteStatus`, you can decide what to do next. Here's an example of how to handle the different cases:

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

The `Versionarte.launchStore` method is a utility method provided by the Versionarte package that opens the app's store page in the device's app store app.

See the <a href="https://github.com/kamranbekirovyz/versionarte/tree/main/example">example</a> directory for a complete sample app.

## 🖋️ JSON format

versionarte requires a specific JSON format for providing versioning and availability details remotely. Whether you're using `RemoteConfigVersionarteProvider`, `RestfulVersionarteProvider`, or a custom `VersionarteProvider`, make sure to use this universal JSON structure.

ℹ️ Information for all platforms in the JSON is not necessary: you can provide information for only one platform, or for two platforms, or for all three platforms.   
ℹ️ While the app status is active, the `message` can be left empty or set to `null`.

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

- `version`: Information about the minimum and latest versions of the app:
    - `minimum`: The minimum version of the app that users can use. 
    - `latest`: The latest version of the app that is available. 
- `status`: Information about the availability of the app:
    - `active`: A boolean that indicates whether the app is currently active or not.
    - `message`: A map that contains the maintenance messages for different languages. The keys of the map represent the language codes (e.g., "en" for English, "es" for Spanish), and the values represent the corresponding message in that language. If the app is not in maintenance mode, this field may be empty or set to `null`.

## 🐞 Bugs/Requests

If you encounter any problems please open an issue. If you feel the library is missing a feature, please raise a ticket on GitHub and we'll look into it. Pull requests are welcome.

## 📃 License

<a href="https://github.com/kamranbekirovyz/versionarte/blob/main/LICENSE">MIT License</a>