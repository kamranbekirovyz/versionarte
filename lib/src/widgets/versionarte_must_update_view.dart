import 'package:flutter/material.dart';
import 'package:versionarte/src/widgets/_versionarte_base_view.dart';
import 'package:versionarte/versionarte.dart';

class VersionarteMustUpdateView extends StatelessWidget {
  /// Widget to be displayed at the top of the page.
  final Widget? header;

  /// Title to be displayed at the top of the page.
  final String title;

  /// Description to be displayed at the center of the page, below title.
  final String description;

  /// Label for the button which opens app in the relative store for the
  /// platform
  final String buttonLabel;

  /// `appleAppId`: App ID of the app on App Store (iOS). Used to open app in
  /// the Apple App Store.
  ///
  /// If your app is not published on the App Store, pass `appleAppId` as `null`
  final int? appleAppId;

  /// View can be used to show user when status is [VersionarteStatus.mustUpdate]
  const VersionarteMustUpdateView({
    Key? key,
    required this.title,
    required this.description,
    required this.buttonLabel,
    required this.appleAppId,
    this.header,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VersionarteBaseView(
      title: title,
      description: description,
      header: header,
      button: _buildButton(),
    );
  }

  Widget _buildButton() {
    return FilledButton.tonal(
      onPressed: _onUpdateTapped,
      child: Text(buttonLabel),
    );
  }

  void _onUpdateTapped() {
    Versionarte.openAppInStore(
      appleAppId: appleAppId,
    );
  }
}
