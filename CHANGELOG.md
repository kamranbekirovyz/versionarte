## 2.0.1

- Small improvements to codebase.
- Upgraded dependencies.

## 2.0.0

versionarte reaches its second major version! 🎉

- **BREAKING CHANGE**: Renamed `VersionarteResult.details` to `VersionarteResult.manifest`.
- **BREAKING CHANGE**: Details of current platform are now accessed via `VersionarteResult.manifest.currentPlatform`.
- **BREAKING CHANGE**: Renamed models to be more intuitive: `StoreVersioning` to `DistributionManifest`, `PlatformStoreDetails` to `PlatformDistributionInfo`
- Added `VersionarteResult.downloadUrls` getter to make it easier when calling `VersionarteResult.launchDownloadUrl`.
- Improved documentation throughout the codebase.

## 1.3.1
- Improve docs for custom providers.

## 1.3.0
- Improved documentation for better clarity.
- Added sponsors section.
- Added screenshots to show package in real use.
- Upgraded dependencies.

## 1.2.3

- Upgrade dependencies.

## 1.2.2

- Upgrade dependencies.

## 1.2.1

- Remove `dart:io` use, so that the package can be used in web.

## 1.2.0

- Add Windows and Linux support.
- Added `Versionarte.launchDownloadUrl` method to launch download page of the app.
- Add a getter for download urls of each platform.
- Update documentation.

## 1.1.0

- Add dynamic download url of each platform.
- Upgrade dependencies.

## 1.0.0

versionarte reaches its first stable version. 🎉

- **BREAKING CHANGE**: Updated `VersionarteStatus` values: `upToDate`, `forcedUpdate`, `outdated`, `inactive`, `unknown`.

## 0.9.2
- Fixed App Store redirection by replacing `appleAppId` with `appStoreUrl` directly to be safe.

## 0.9.1
- Upgrade dependencies: firebase_remote_config, http, package_info_plus, url_launcher

## 0.9.0
- Upgrade dependencies: firebase_remote_config, http, package_info_plus, url_launcher
- Update dependency constraints to `sdk: '>=3.0.0 <4.0.0'`

## 0.8.8
- Fix some analyzer warnings.
- Upgrade dependencies.
- Update dependency constraints to `sdk: '>=2.18.0 <4.0.0'`

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
