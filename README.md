# versionarte

Version management package for Flutter that lets you inform your users when a new version of your app is available, they must update the app to be able to continue and deactivate the app with custom information texts.

<img src="#" alt="cover_picture" />

## 🚀 Motivation

Mobile application development differs from other front-end development domains for one very specific reason: when you want to modify and publish a new version of your app you have to send it to be reviewed by the stores (AppStore, Play Store, AppGallery and etc.) and most specifically when a new version is available users must choose to update the app, as opposed to the WEB, otherwise, they stay in older and may be buggy or risky version 🥺.

Since I've developed nearly 50-something mobile apps, I almost always tried to implement version management logic for my clients' apps so that whenever 

## 🕹️ Usage

To get started..

```dart
final int a = 1;
```

See the <a href="#">example</a> directory for a complete sample app.

## 🛣️ Roadmap
ROADMAP:

[x] RemoteConfig, RESTful API, and custom validation support (respectively: `RemoteConfigVersionarteProvider`, `RestfulVersionarteProvider`, `CustomVersionarteProvider`).

[x] Ability to write your own `VersionarteProvider`
[x] Version indicator `Widget`: "App name v1.0.0+1" (`VersionarteIndicator`).
[x] Launch the App Store on iOS and the Play Store on Android.
[] Ability to launch AppGallery on Huawei devices.
[] Making it testable.
[] Detailed examples for every use case.
[] Documentation website: https://versionarte.dev
[] (ongoing) Built-in UI-kit and components support: `VersionarteInactiveView`, `VersionarteMustUpdateView`, `VersionarteIndicator`.
[] Enable debugging logging.
[] Add support for providing the latest release notes/changelog.
[] Implement in-app upgrade on Android.
[] Int indicating how many times the user opened the app.
[] Execute function when the user installs the new version.
[] Boolean indicating the user opening this build/version for the first time.

[I believe that the app's all screens should have the same design patterns. But, anyways, I've created some simple and almost customizable UI components that might be useful to developers.]

## 🤓 Contributors

<a  href="https://github.com/al-ventures/telpo-flutter-sdk/graphs/contributors"> <img  src="https://github.com/kamranbekirovyz.png" height="100">

## 💡 Inspired from/by

- Although this package's functionalities differ, I got some inspiration from <a href="https://github.com/levin-riegner/lr-app-versioning">lr-app-versioning</a> package.

## 🐞 Bugs/Requests

If you encounter any problems please open an issue. If you feel the library is missing a feature, please raise a ticket on GitHub and we'll look into it. Pull requests are welcome.

## 📃 License

MIT License