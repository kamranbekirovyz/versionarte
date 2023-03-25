# versionarte

Versionarte allows you to remotely manage your Flutter app's versioning and availability, with a variety of heplful, and in some cases life-saving features with total freedom over the UI allowing you to customize the user experience to fit your app's branding and style.

Features you can implement with versionarte:
- 😈 Force users to update to the latest version of your app before continuing.
- 💆🏻‍♂️ Have different minimum, latest versions and availability status for separate platforms.
- 🚧 Disable your app for maintenance with custom information text.
- 🆕 Inform users when a new, optional update is available..
- 🔗 Launch the App Store on iOS and Play Store on Android.

<img src="https://raw.githubusercontent.com/kamranbekirovyz/versionarte/master/assets/cover.png" alt="cover_picture" />

## 🚀 Motivation

Mobile application development is unique in that any changes, whether it be adding new features, fixing bugs, or disabling the app for maintenance, requires submitting a new version to the stores and waiting for approval. Even after approval, users may still need to manually update their app to have the latest version.

To simplify the app versioning process, versionarte offers remote management of app versioning and availability. This makes the app development process more controllable.

## 🕹️ Usage

Before using this package, it is important to note that it uses a specific JSON format to convey the app's version and availability status to the package. Please refer to the JSON format section for more information.

Contents:
- [Getting status](#-getting-status)
    - [Using Firebase Remote Config](#-using-firebase-remote-config)
    - [Using RESTful API](#-using-restful-api)
    - [Using custom VersionarteProvider](#-using-custom-versionarteprovider)
- [Handling the status](#-handling-the-result)
- [Redirecting to the stores](#-redirecting-to-the-stores)
- [Firebase Remote Config setup guide](#-firebase-remote-config-setup-guide)

### Getting status

There are multiple ways to obtain the app's version and availability status using this package:

<!-- Using Firebase Remote Config: This is the recommended method and requires Firebase Remote Config to be set up. Please refer to the Firebase Remote Config setup guide section for more information.

Using RESTful API: This method involves making a RESTful API call to a specified URL to retrieve the JSON file containing the app's version and availability status.

Using custom VersionarteProvider: This method allows you to provide a custom implementation of the VersionarteProvider class to fetch the app's version and availability status from any source you desire.

Please refer to the individual sections for detailed information on how to use each of these methods. -->

### Using Firebase Remote Config
The `RemoteConfigVersionarteProvider` fetches versioning information stored in FirebaseRemoteConfig with the key name of "versionarte". You need to set up the Firebase Remote Config service before using this provider. See [Firebase Remote Config setup guide](-firebase-remote-config-setup-guide) to learn more about configuration.

Below is a example of how to use versionarte with Firebase Remote Config:

```dart
final result = await Versionarte.check(
    versionarteProvider: RemoteConfigVersionarteProvider(),
);
```

The `RemoteConfigVersionarteProvider` has 1 optional parameter:
- `keyName`: used to specify the key name for the Firebase Remote Config to fetch. By default, it's set to "versionarte". If you want to upload the [configuration JSON](#json-format) using different key name, you can use this parameter to specify the key name.

#### Using RESTful API

Below is a example of how to use versionarte with RESTful API:

```dart
final result = await Versionarte.check(
    versionarteProvider: RestfulVersionarteProvider(
        url: 'https://myapi.com/getVersioning',
    ),
);
```

The `RestfulVersionarteProvider` has 1 optional parameter:
- `headers`: used to specify the headers for the request. By default, it's set to an empty map.

#### Using custom VersionarteProvider

This method allows you to provide a custom implementation of the VersionarteProvider class to fetch the app's version and availability status from any source you desire.

If you want to use a custom provider, say you use some other remote service to provide versioning details of your app, you can extend the VersionarteProvider class and override the getStoreVersioning method. This method is responsible for fetching the versioning information from the remote service and returning it as a StoreVersioning object.

```dart
class MyCustomVersionarteProvider extends VersionarteProvider {
  @override
  Future<StoreVersioning> getStoreVersioning() async {
    final result = MyCustomService.fetchVersioning();

    final decodedResult = jsonDecode(result);

    return StoreVersioning.fromJson(decodedResult);
  }
```
    
Below is a example of how to use versionarte with `MyCustomVersionarteProvider` we created before:

```dart
final result = await Versionarte.check(
    versionarteProvider: MyCustomVersionarteProvider(),
);
```

### Handling the status

After fetching the versioning information using the Versionarte.check() method, the method returns a VersionarteResult object, which contains 3 parameters:

The method returns a `VersionarteResult` object, which contains 3 parameters:
- `status`: the versioning status of the app. It can be one of the following values:
    - `VersionarteStatus.appInactive`: the app is inactive and should not be used.
    - `VersionarteStatus.mustUpdate`: the app is active, but the user must update to the latest version.
    - `VersionarteStatus.shouldUpdate`: the app is active, but the user should update to the latest version.
    - `VersionarteStatus.upToDate`: the app is active and the user is using the latest version.
    - `VersionarteStatus.unknown`: the app is active, but the versioning status is unknown.
- `details`: The version details of the app for the current platform, including messages for when the app is inactive. 
- 'errorMessage`: The error message if any error occurred while fetching the versioning information.

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

There are two other values that you can receive as a result: `VersionarteStatus.upToDate` and `VersionarteStatus.unknown`. But these two are never used mostly.

Note that you don't need to try-catch the Versionarte.check function, as the called function catches all the errors inside. If anything goes wrong, an instance of VersionarteResult is still returned, with a message property containing the error message. Also, be sure to check the debug console to see the debug-only prints that the package prints.

Maybe you want to use Firestore, Graphql or any other service to provider `StoreVersioning`? Extend `VersionarteProvider`, override `getStoreVersioning`, fetch serverside data, parse it into a `StoreVersioning` instance using `StoreVersioning.fromJson` factory constructor:

### Redirecting to the stores

The `Versionarte.launchStore` method is a utility method provided by the Versionarte package that opens the app's store page in the device's app store app.

See the <a href="https://github.com/kamranbekirovyz/versionarte/tree/main/example">example</a> directory for a complete sample app.

## 🖋️ JSON format

versionarte has a specific JSON format, which you must use to provide the versioning details remotely. Whether you're using `RemoteConfigVersionarteProvider`, `RestfulVersionarteProvider`, or a custom `VersionarteProvider`, you must always use the structured JSON below:

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

This JSON object represents the versioning information for an app, including its minimum and latest versions, and the maintenance status of the app. The information is stored separately for three different platforms: Android, iOS, and macOS.

Each platform contains two objects:

- `version`: An object that contains information about the minimum and latest version of the app. 
    - `minimum`: The minimum version of the app that users can use. 
    - `latest`: The latest version of the app that is available.
- `status`: An object that contains information about the availability of the app.
    - `active`: A boolean that indicates whether the app is currently in active or not.
    - `message`: A map that contains the maintenance messages for different languages. The keys of the map represent the language codes (e.g., "en" for English, "es" for Spanish), and the values represent the corresponding maintenance message in that language. If the app is not in maintenance mode, this field may be null or empty.

## 🚜 Firebase Remote Config setup guide

## 🐞 Bugs/Requests

If you encounter any problems please open an issue. If you feel the library is missing a feature, please raise a ticket on GitHub and we'll look into it. Pull requests are welcome.

## 📃 License

<a href="https://github.com/kamranbekirovyz/versionarte/blob/main/LICENSE">MIT License</a>