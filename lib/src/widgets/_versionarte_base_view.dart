import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:versionarte/versionarte.dart';

class VersionarteBaseView extends StatelessWidget {
  final Widget? header;
  final String title;
  final String description;
  final Widget? button;

  const VersionarteBaseView({
    Key? key,
    required this.title,
    required this.description,
    this.header,
    this.button,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final systemUiOverlayStyle = isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemUiOverlayStyle,
      child: Scaffold(
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
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
                  const SizedBox(height: 40.0),
                ],
                Text(title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        )),
                const SizedBox(height: 16.0),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (button != null) ...[
                  const SizedBox(height: 24.0),
                  button!,
                ],
              ],
            ),
          ),
          const SafeArea(
            child: VersionarteIndicator(),
          ),
          if (Platform.isAndroid) const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
