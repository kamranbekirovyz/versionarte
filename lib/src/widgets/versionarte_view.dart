import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:versionarte/versionarte.dart';

class VersionarteView extends StatelessWidget {
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

  const VersionarteView.mustUpdate({
    Key? key,
    required this.appleAppId,
    required this.title,
    required this.description,
    required this.header,
    required this.buttonLabel,
  })  : _status = VersionarteStatus.mustUpdate,
        super(key: key);

  const VersionarteView.unavailable({
    Key? key,
    required this.title,
    required this.description,
    this.header,
  })  : _status = VersionarteStatus.unavailable,
        buttonLabel = 'N/A',
        appleAppId = null,
        super(key: key);

  final VersionarteStatus _status;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        width: double.maxFinite,
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
                      style: const TextStyle(
                        fontSize: 24.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        height: 32.0 / 24.0,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                  ],
                  if (description != null) ...[
                    Text(
                      description!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black87,
                        height: 22.0 / 16.0,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (_status == VersionarteStatus.mustUpdate) ...[
              _buildUpdateButton(context),
              const SizedBox(height: 16.0),
            ],
            const VersionarteIndicator(),
            if (!Platform.isIOS) const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdateButton(BuildContext context) {
    final text = Text(
      buttonLabel,
      style: const TextStyle(
        color: Colors.white,
      ),
    );

    return SizedBox(
      height: 56.0,
      width: double.maxFinite,
      child: Platform.isIOS
          ? CupertinoButton(
              color: CupertinoColors.activeBlue,
              onPressed: _onUpdateTapped,
              child: text,
            )
          : TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
              ),
              onPressed: _onUpdateTapped,
              child: text,
            ),
    );
  }

  void _onUpdateTapped() {
    Versionarte.openAppInStore(
      appleAppId: appleAppId,
    );
  }
}
