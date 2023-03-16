# versionarte

Versionarte allows you to remotely manage your Flutter app's versioning and availability, with a variety of heplful, and in some cases life-saving features with total freedom over the UI allowing you to customize the user experience to fit your app's branding and style:

- 😈 Force users to update to the latest version of the app before continuing.
- 🚧 Disable your app for maintenance using custom remotely-stored info text.
- 🆕 Inform users when a new optional update is available for your app.
- 🔗 Launch the App Store on iOS and Play Store on Android.

<img src="https://raw.githubusercontent.com/kamranbekirovyz/versionarte/master/assets/cover.png" alt="cover_picture" />

## 🚀 Motivation

Mobile application development is unique in that any changes, whether it be adding new features, fixing bugs, or disabling the app for maintenance, requires submitting a new version to the app store and waiting for approval. Even after approval, users may still need to manually update their app to access the latest version. 

To simplify the app versioning process, versionarte offers remote management of app versioning and availability. This makes the app development process more controllable.

## 🕹️ Usage

The version of the app that is running is get by `package_info_plus` plugin and compared to the one that is fetched remotely from a service.

Package comes with built-in RESTful API and Firebase Remote Config support. However, you can also fetch your configuration data from any source by extending the `VersionarteProvider` class.

### Using Firebase Remote Config
Below is a example of how to use Versionarte with Firebase Remote Config:

```dart
final result = await Versionarte.check(
    versionarteProvider: RemoteConfigVersionarteProvider(),
);
```

In this example, we import the required packages and call the Versionarte.check function to retrieve the VersionarteResult. The RemoteConfigVersionarteProvider is used to retrieve the remote version information from Firebase Remote Config.

Then, we use the result to decide what to do next based on the versioning state. Here's an example of how to do that:

```dart
if (result == VersionarteResult.inactive) {
  // TODO: Handle the case where remote version information is inactive
} else if (result == VersionarteResult.mandatory) {
  // TODO: Handle the case where an update is required
} else if (result == VersionarteResult.optional) {
  // TODO: Handle the case where an update is optional
} 
```

There are two other values that you can receive as a result: `VersionarteStatus.upToDate` and `VersionarteStatus.unknown`. But these two are never used mostly.

Note that you don't need to try-catch the Versionarte.check function, as the called function catches all the errors inside. If anything goes wrong, an instance of VersionarteResult is still returned, with a message property containing the error message. Also, be sure to check the debug console to see the debug-only prints that the package prints.

You want to use your own RESTful API instead of FirebaseRemoteConfig? Use `RestfulVersionarteProvider`:

```dart
final result = await Versionarte.check(
    versionarteProvider: RestfulVersionarteProvider(
        url: 'https://myapi.com/getVersioning',
    ),
);
```

Maybe you want to use Firestore, Graphql or any other service to provider `StoreVersioning`? Extend `VersionarteProvider`, override `getStoreVersioning`, fetch serverside data, parse it into a `StoreVersioning` instance using `StoreVersioning.fromJson` factory constructor:

See the <a href="https://github.com/kamranbekirovyz/versionarte/tree/main/example">example</a> directory for a complete sample app.

## 🖋️JSON format

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
    "ios": {
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
- `active`: A boolean that indicates whether the app is currently in maintenance mode or not.
- `message`: A map that contains the maintenance messages for different languages. The keys of the map represent the language codes (e.g., "en" for English, "es" for Spanish), and the values represent the corresponding maintenance message in that language. If the app is not in maintenance mode, this field may be null or empty.

## 🤓 Contributors

<a  href="https://github.com/kamranbekirovyz/versionarte/graphs/contributors"> <img  src="https://github.com/kamranbekirovyz.png" height="100"></a>

## 🐞 Bugs/Requests

If you encounter any problems please open an issue. If you feel the library is missing a feature, please raise a ticket on GitHub and we'll look into it. Pull requests are welcome.

## 📃 License

<a href="https://github.com/kamranbekirovyz/versionarte/blob/main/LICENSE">MIT License</a>