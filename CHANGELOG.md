## 0.8.7
- Fix errors in README and prepare for publishing.

## 0.8.6
- Updated README and [Firebase Remote Config setup guide](https://github.com/kamranbekirovyz/versionarte/blob/main/firebase_remote_config_setup.md#-firebase-remote-config-setup-guide)

## 0.8.5
- Add internal initialization option to `RemoteConfigVersionarteProvider`.
- Add [Firebase Remote Config setup guide](https://github.com/kamranbekirovyz/versionarte/blob/main/firebase_remote_config_setup.md#-firebase-remote-config-setup-guide)

## 0.8.4
- Important bug fix in version comparison.
- Updated README.

## 0.8.3
- Improved `RemoteConfigVersiorteProvider`.
- Pretty logs and some minor improvements besides almost finished documentation.

## 0.8.0
- New updated values for `VersionarteStatus`: upToDate, optionalUpdateAvailable, mandatoryUpdateRequired, appInactive, unknown.

## 0.7.2
- Renamed `openAppInStore` as `launchStore`.
- Renamed `VersionarteStatus.unavailable` as `VersionarteStatus.inactive`.
- Updated JSON structure so that comparison is now done with "version name" (1.0.0) instead of "version number" (1).
- Added support for macOS in addition to iOS and Android.

## 0.6.1
- [VersionarteStatus.failedToCheck] renamed as [VersionarteStatus.unknown].
- All UI related widgets are moved to <a href="https://pub.dev/packages/versionarte_ui_kit">versionarte_ui_kit</a> package 💆🏻‍♂️.
- Upgraded dependencies to the latest version.

## 0.5.0
- Now, you can provide information texts in multiple languages when app is disabled (`VersionarteStatus.unavailable`).

## 0.4.3
- Renamed `PlatformStoreDetails` as `StorePlatformDetails`.
- Renamed `androidVersion` and `iosVersion` as `androidVersionNumber` and `iOSVersionNumber` respectively.
- Improved documentation comments.

## 0.4.2
- Renamed `PlatformVersionate` as `PlatformStoreDetails`.
- Added `LaunchMode.externalApplication` when openAppInStore(...) is called.
- Improved documentation comments.

## 0.4.1
- Now, `VersionarteIndicator` besides `PackageInfo` also uses cached value of `LocalVersioning` that used to check the app status.
- Improved documentation comments.

## 0.4.0
- Renamed `ServersideVersioning` as `StoreVersioning` to be more intuitive with `LocalVersioning`.

## 0.3.3
- Small changes to versionarte.json file structure to make it more readable and compact.
- `ServersideVersioning` is rewritten to be compatible with new versionarte.json format.
- Renamed `CurrentVersioning` as `LocalVersioning`.

## 0.3.0
- More intuitive, more platform specific and customizable `ServersideVersioning` (new json format).
- `VersionarteStatus.inactive` changed to `VersionarteStatus.unavailable`.
- Added changelog property to provide latest release's changelog in multiple languages.
- Fixed some critical bugs encountered while testing.
- Initial version of README with roadmap in it.

## 0.2.0
- when utility extension for `VersionarteDecision`.
- Built-in components: `VersionarteView.mustUpdate` and `VersionarteView.inactive`.

## 0.1.5

- Added documentation comments and customization properties for `VersionarteInactiveView`, improved its UI components.
- Fixed minor bugs.

## 0.1.4

- Added `VersionarteInactiveView` as a UI kit component to display to your users when the app is inactive.
- Improved documentation comments.

## 0.1.2

- Updated namings of `ServersideVersioning` and `CurrentVersioning`.
- Added some documentation as a comment.

## 0.1.1

- `VersionarteIndicator` utility widget for displaying current platform version name and number alongside with app name.

## 0.1.0

- Initial release for the package.
