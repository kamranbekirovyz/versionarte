import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:versionarte/versionarte.dart';

class VersionarteMustUpdateView extends StatelessWidget {
  /// Widget to be displayed at the top of the page.
  final Widget? header;

  /// Title to be displayed at the top of the page.
  final String? title;

  /// Description to be displayed at the center of the page, below title.
  final String? description;

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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final systemUiOverlayStyle = isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemUiOverlayStyle,
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (header != null) ...[
                      header!,
                      const SizedBox(height: 32.0),
                    ],
                    if (title != null) ...[
                      Text(
                        title!,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16.0),
                    ],
                    if (description != null) ...[
                      Text(
                        description!,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                    const SizedBox(height: 32.0),
                    FilledButton.tonal(
                      onPressed: _onUpdateTapped,
                      child: Text(buttonLabel),
                    ),
                  ],
                ),
              ),
              const SafeArea(
                child: VersionarteIndicator(),
              ),
              if (Platform.isAndroid) const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  void _onUpdateTapped() {
    Versionarte.openAppInStore(
      appleAppId: appleAppId,
    );
  }
}
