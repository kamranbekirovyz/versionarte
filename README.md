# versionarte

A package for Flutter that lets you remotly manage your versioning and its availability. Meaning that you can disable the app for usage with custom remotly stored information texts..

<img src="https://raw.githubusercontent.com/kamranbekirovyz/cupertino-refresh/master/.docs/cover.png" alt="cover_picture" />

## 🚀 Motivation

There is one fundamental characteristic that makes mobile application development distinct from other development domains (such as web or back-end): while developing a mobile application, as soon as you add a new module/functionality, fix a critical or non-critical bug, or just want to make the app unavailable for some short or long period of time (maybe because of maintenance you’re doing on your server) you have to go through the procedure of submitting the new version of the app to the relative stores, wait for them to hopefully approve (not reject) and after all that, although your app is live on the store, there will be some users those who have to manually choose to update your app to the latest version.

There seems to be a some kind of a way to remotely do this.

## 🖋️JSON format

`Versionarte` has a specific json format, which you must use to provide the versioning details remotely.

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
            "message": "App Unavailable.",
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
        "minimum": {
            "number": 12,
            "name": "2.7.4"
        },
        "latest": {
            "number": 15,
            "name": "2.8.1+hotfix"
        },
        "availability": {
            "available": true,
            "message": "App Unavailable.",
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
    }
}
```

## 🕹️ Usage

### A basic example
Below here is an example of how to use `Versionarte` with Firebase Remote Config to retrieve a `VersionarteResult`:

```dart
final result = await Versionarte.check(
    versionarteProvider: RemoteConfigVersionarteProvider(),
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

To get started..

```dart
final int a = 1;
```

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