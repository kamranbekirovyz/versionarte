import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:versionarte/versionarte.dart';

class VersionarteInactiveView extends StatelessWidget {
  final String? title;
  final String? description;
  final Widget? header;

  const VersionarteInactiveView({
    Key? key,
    this.title,
    this.description,
    this.header,
  }) : super(key: key);

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
                        height: 22.0 / 16.0,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const VersionarteIndicator(),
            if (!Platform.isIOS) const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}
