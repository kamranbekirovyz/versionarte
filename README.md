# versionarte

A package for Flutter that allows you to remotely manage your app's versioning and availability. With versionarte, you can easily disable your app for usage with custom remotely stored information texts, show a forced update screen, show an update available screen, and provide a changelog.


<img src="https://raw.githubusercontent.com/kamranbekirovyz/cupertino-refresh/master/.docs/cover.png" alt="cover_picture" />

## 🚀 Motivation

Mobile application development is unique in that any changes, whether it be adding new features, fixing bugs, or taking the app offline for maintenance, requires submitting a new version to the app store and waiting for approval. Even after approval, users may still need to manually update their app to access the latest version. This process can be time-consuming and frustrating for both developers and users.

To simplify the app versioning process, versionarte offers remote management of app versioning. With versionarte, you can easily manage app versioning and updates without the need for app store submissions or manual user updates. This makes the app development process more efficient and seamless, benefiting both developers and users alike.

## 🖋️JSON format

versionarte has a specific JSON format, which you must use to provide the versioning details remotely. Whether you're using `RemoteConfigVersionarteProvider`, `RestfulVersionarteProvider`, or a custom `VersionarteProvider`, you must always use the structured JSON below:

```js
{
    "android": {
        "minimum": {
            "number": 12,
            "name": "2.7.4"
        },
        "latest": {
            "number": 14,
            "name": "2.8.0"
        },
        "availability": {
            "available": true,
            "message": "Versionarte is unavailable.",
            "details": "App is in maintanence mode, please come back later."
        },
        "changelog": {
            "en": [
                "Minor improvements.",
                "Fixed login issue."
            ],
            "es": [
                "Pequeñas mejoras.",
                "Solucionado el problema de inicio de sesión."
            ]
        }
    },
    "ios": {
        // same data we used for "android"
    }
}
```

## 👀 Before usage: terminology

StoreVersioning: A model that represents the JSON structure mentioned earlier. It contains versioning details of the app, such as the latest version number, minimum version number, changelog, and so on.

VersionarteProvider: A delegate that fetches an instance of StoreVersioning. It can be implemented to create other sources of VersionarteProviders such as Firestore, GraphQL, and so on.

RemoteConfigVersionarteProvider: A VersionarteProvider that fetches StoreVersioning based on the Firebase Remote Config.

RestfulVersionarteProvider: A VersionarteProvider that fetches StoreVersioning information by sending an HTTP GET request to the given URL.

LocalVersioning: A model that contains versioning details of the currently running app. It has three fields: androidVersion for the current version number of the running Android app, iosVersion for the current version number of the running iOS app, and platformVersion for the version number of the current platform. The platformVersion property is a getter that returns the version number depending on the target platform of the app.

## 🕹️ Usage

### A basic example
Below here is minimal example of `Versionarte` with Firebase Remote Config to retrieve a `VersionarteResult`:

```dart
final result = await Versionarte.check(
    versionarteProvider: RemoteConfigVersionarteProvider(),
    localVersioning: await LocalVersioning.fromPackageInfo(),
);
```

Then using `result` we can decide what we want to do with:

```dart
if (result == VersionarteResult.unavailable) {
// TODO: 
} else if (result == VersionarteResult.mustUpdate) {
// TODO: 
} else if (result == VersionarteResult.couldUpdate) {
// TODO: 
} 
```

Here you don't need to try-catch the function: called function catches all the erros inside, if anything goes wrong, still an instance of `VersionarteResult` is returned with a `message` property containing error message. Also, be sure to check debug console to see the debug-only prints that package prints.

You want to use your own RESTful API instead of FirebaseRemoteConfig? Use `RestfulVersionarteProvider`:

```dart
final result = await Versionarte.check(
    versionarteProvider: RestfulVersionarteProvider(
        url: 'https://myapi.com/getVersioning',
    ),
    localVersioning: await LocalVersioning.fromPackageInfo(),
);
```

Maybe you want to use Firestore, Graphql or any other service to provider `StoreVersioning`? Extend `VersionarteProvider`, override `getStoreVersioning`, fetch serverside data, parse it into a `StoreVersioning` instance using `StoreVersioning.fromJson` factory constructor:



See the <a href="https://github.com/kamranbekirovyz/versionarte/tree/main/example">example</a> directory for a complete sample app.

## 🛣️ Roadmap

✅ Firebase Remote Config, RESTful API, and custom  versioning provider support.  
✅ Built-in views and components.  
✅ Launch the App Store on iOS and the Play Store on Android.  
✅ Add support for providing the latest release notes/changelog.  
⏳ Detailed examples for every use case.  
⏳ Ability to launch AppGallery on Huawei devices.  
⏳ Documentation website: https://versionarte.dev  
⏳ Support for separate web, macOS, windows, linux platform  support.  
⏳ Test coverage.  
🤔 Implement in-app upgrade on Android.  
🤔 An int indicating how many times the user opened the app.  
🤔 Execute function when the user installs the new version.  
🤔 A bool indicating the user opening this build/version for the first time.  

## 🤓 Contributors

<a  href="https://github.com/kamranbekirovyz/versionarte/graphs/contributors"> <img  src="https://github.com/kamranbekirovyz.png" height="100"></a>

## 💡 Inspired from/by

- Although this package's functionalities differ, I got some inspiration from <a href="https://github.com/levin-riegner/lr-app-versioning">lr-app-versioning</a> package.

## 🐞 Bugs/Requests

If you encounter any problems please open an issue. If you feel the library is missing a feature, please raise a ticket on GitHub and we'll look into it. Pull requests are welcome.

## 📃 License

<a href="https://github.com/kamranbekirovyz/versionarte/blob/main/LICENSE">MIT License</a>