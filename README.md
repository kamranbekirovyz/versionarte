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

✅ Firebase Remote Config, RESTful API, and custom server-side versioning support (respectively: `RemoteConfigVersionarteProvider`,  `RestfulVersionarteProvider`, `CustomVersionarteProvider`).  
✅ Ability to write your own `VersionarteProvider`  
✅ Version indicator `Widget`: "App name v1.0.0+1" (`VersionarteIndicator`).  
✅ Built-in UI-kit and components: `VersionarteView.mustUpdate()`, `VersionarteView.inactive()`, `VersionarteIndicator`.  
✅ Launch the App Store on iOS and the Play Store on Android.  
✅ Add support for providing the latest release notes/changelog.  
⏳ Documentation website: https://versionarte.dev  
⏳ Ability to launch AppGallery on Huawei devices.  
⏳ Support separate web, macOS, windows, linux platform configurations.  
⏳ Making it testable.  
⏳ Detailed examples for every use case.  
⏳ Implement in-app upgrade on Android.  
🤔 Am int indicating how many times the user opened the app.  
🤔 Execute function when the user installs the new version.  
🤔 A bool indicating the user opening this build/version for the first time.  

[I believe that the app's all screens should have the same design patterns. But, anyways, I've created some simple and almost customizable UI components that might be useful to developers.]

## 🤓 Contributors

<a  href="https://github.com/kamranbekirovyz/versionarte/graphs/contributors"> <img  src="https://github.com/kamranbekirovyz.png" height="100">

## 💡 Inspired from/by

- Although this package's functionalities differ, I got some inspiration from <a href="https://github.com/levin-riegner/lr-app-versioning">lr-app-versioning</a> package.

## 🐞 Bugs/Requests

If you encounter any problems please open an issue. If you feel the library is missing a feature, please raise a ticket on GitHub and we'll look into it. Pull requests are welcome.

## 📃 License

<a href="https://github.com/kamranbekirovyz/versionarte/blob/main/LICENSE">MIT License</a>