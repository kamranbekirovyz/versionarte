# versionarte

Versionarte allows you to remotely manage your Flutter app's versioning and availability, with a variety of heplful, and in some cases life-saving features with total freedom over the UI allowing you to customize the user experience to fit your app's branding and style.

Features you can implement with versionarte:
- 😈 Force users to update to the latest version of your app before continuing.
- 💆🏻‍♂️ Have separate minimum, latest versions and availability status for platforms.
- 🚧 Disable your app for maintenance with custom information text.
- 🆕 Inform users when an optional update is available..
- 🔗 Launch the App Store on iOS and Play Store on Android.

<img src="https://raw.githubusercontent.com/kamranbekirovyz/versionarte/master/assets/cover.png" alt="cover_picture" />

<!-- ## 🚀 Motivation

Mobile application development is unique in that any changes, whether it be adding new features, fixing bugs, or disabling the app for maintenance, requires submitting a new version to the stores and waiting for approval. Even after approval, users may still need to manually update their app to have the latest version.

To simplify the app versioning process, versionarte offers remote management of app versioning and availability. This makes the app development process more controllable. -->

## 🕹️ Usage

Before using this package, it is important to note that it uses a specific JSON format to convey the app's version and availability status to the package. Please refer to the JSON format section for more information.

Contents:
- [Getting status](#getting-status)
    - [Using Firebase Remote Config](#using-firebase-remote-config)
    - [Using RESTful API](#-using-restful-api)
    - [Using custom VersionarteProvider](#-using-custom-versionarteprovider)
- [Handling the status](#-handling-the-result)
- [Redirecting to the stores](#-redirecting-to-the-stores)
- [Firebase Remote Config setup guide](#-firebase-remote-config-setup-guide)

### Getting status

There are multiple ways to obtain the app's version and availability status.

<!-- Note that you don't need to try-catch the Versionarte.check function, as the called function catches all the errors inside. If anything goes wrong, an instance of VersionarteResult is still returned, with a message property containing the error message. Also, be sure to check the debug console to see the debug-only prints that the package prints. -->

#### 1. Using Firebase Remote Config

The `RemoteConfigVersionarteProvider` fetches versioning and availability information stored in Firebase Remote Config with the key name of "versionarte". You need to set up the Firebase Remote Config service before using this provider. See [Firebase Remote Config setup guide](#🚜-firebase-remote-config-setup-guide) to learn more about configuration.

Below is a example of how to use versionarte with `RemoteConfigVersionarteProvider`:

```dart
final result = await Versionarte.check(
    versionarteProvider: RemoteConfigVersionarteProvider(),
);
```

The `RemoteConfigVersionarteProvider` has 1 optional parameter:
- `keyName`: specifies the key name for the Firebase Remote Config to fetch. By default, it's set to "versionarte". Specify if you upload the [configuration JSON](#-json-format) using a different key name.

#### 2. Using RESTful API

The `RestfulVersionarteProvider` fetches versioning and availability information by sending HTTP GET request to the specified URL with optional headers. The response body should be a JSON string that follows the [configuration JSON](#-json-format) format.

Below is a example of how to use versionarte with `RemoteConfigVersionarteProvider`:

```dart
final result = await Versionarte.check(
    versionarteProvider: RestfulVersionarteProvider(
        url: 'https://myapi.com/getVersioning',
    ),
);
```

The `RestfulVersionarteProvider` has 1 optional parameter:
- `headers`: request headers to send with the HTTP GET request. By default, it's set to an empty map.

#### 3. Using custom VersionarteProvider

If you want to use a custom provider, say you use some other remote service to provide versioning and availability information of your app, extend the `VersionarteProvider` class and override the `getStoreVersioning` method. This method is responsible for fetching the versioning information from the remote service and returning it as a `StoreVersioning` object.

```dart
class MyCustomVersionarteProvider extends VersionarteProvider {
  @override
  Future<StoreVersioning> getStoreVersioning() async {
    final result = MyCustomService.fetchVersioning();

    final decodedResult = jsonDecode(result);

    return StoreVersioning.fromJson(decodedResult);
  }
```
    
Below is a example of how to use versionarte with `MyCustomVersionarteProvider`:

```dart
final result = await Versionarte.check(
    versionarteProvider: MyCustomVersionarteProvider(),
);
```

### Handling the status

After fetching the versioning information using the `Versionarte.check()` method, the method returns a `VersionarteResult` object, which contains 3 parameters:

The method returns a `VersionarteResult` object, which contains 3 parameters:
- `status`: the versioning status of the app. It can be one of the following values:
    - `VersionarteStatus.appInactive`: the app is inactive and should not be used.
    - `VersionarteStatus.mustUpdate`: the app is active, but the user must update to the latest version.
    - `VersionarteStatus.shouldUpdate`: the app is active, but the user should update to the latest version.
    - `VersionarteStatus.upToDate`: the app is active and the user is using the latest version.
    - `VersionarteStatus.unknown`: the app is active, but the versioning status is unknown.
- `details`: The version details of the app for the current platform, including messages for when the app is inactive. 
- `errorMessage`: The error message if any error occurred while fetching the versioning information.

Then, based on the versioning state, you can decide what to do next. Here's an example of how to handle the different cases:

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

### Redirecting to the stores

The `Versionarte.launchStore` method is a utility method provided by the Versionarte package that opens the app's store page in the device's app store app.

See the <a href="https://github.com/kamranbekirovyz/versionarte/tree/main/example">example</a> directory for a complete sample app.

## 🖋️ JSON format

versionarte requires a specific JSON format for providing versioning and availability details remotely. Whether you're using RemoteConfigVersionarteProvider, RestfulVersionarteProvider, or a custom VersionarteProvider, you must always follow this structure.

Note:
- Versioning information for all platforms is not necessary. If you have only an Android app, you can provide versioning information for Android and leave the iOS and macOS objects empty.
- If the app status is active, you can leave the `message` object empty or set to `null`.

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

This JSON object represents versioning information for an app, including the minimum and latest versions, and the availability status. The information is stored separately for three different platforms: Android, iOS, and macOS.

Each platform contains two objects:

- `version`: An object that contains information about the minimum and latest version of the app. 
    - `minimum`: The minimum version of the app that users can use. 
    - `latest`: The latest version of the app that is available.
- `status`: An object that contains information about the availability of the app.
    - `active`: A boolean that indicates whether the app is currently in active or not.
    - `message`: A map that contains the maintenance messages for different languages. The keys of the map represent the language codes (e.g., "en" for English, "es" for Spanish), and the values represent the corresponding maintenance message in that language. If the app is not in maintenance mode, this field may be empty or set to `null`.

## 🚜 Firebase Remote Config setup guide

To use `RemoteConfigVersionarteProvider`, you must first set up Firebase Remote Config in your app. You can follow the <a href="https://firebase.google.com/docs/remote-config/get-started?platform=flutter">official Flutter guide</a> to set up Firebase Remote Config in your app.

Assuming you've already set up Firebase Remote Config in your app, below are steps on how to set up versionarte with Firebase Remote Config:

### Step 1: open Remote Config tab
Navigate to the Remote Config tab of the Firebase Console. You should see a screen similar to the one below:

### Step 2: Upload "versionarte" parameter.

1. Create a new Firebase Remote Config parameter in the Firebase console. The parameter name must be `versionarte` and the default value must be the JSON object that contains the versioning information for your app. See the <a href="

## 🐞 Bugs/Requests

If you encounter any problems please open an issue. If you feel the library is missing a feature, please raise a ticket on GitHub and we'll look into it. Pull requests are welcome.

## 📃 License

<a href="https://github.com/kamranbekirovyz/versionarte/blob/main/LICENSE">MIT License</a>