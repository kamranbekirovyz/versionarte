import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:versionarte/versionarte.dart';

/// Built-in view to display when app is inactive.
///
/// `title`, `description` and a header `Widget` can be specified. Also,
/// `scaffoldBackgroundColor`, `titleStyle`, `descriptionStyle` and
/// `systemUiOverlayStyle` properties let you customize the components.
class VersionarteInactiveView extends StatelessWidget {
  /// (Optional) Title to be displayed at the top of the page.
  final String? title;

  /// (Optional) Description to be displayed at the top of the page.
  final String? description;

  /// (Optional) Widget to be displayed at the top of the page.
  final Widget? header;

  /// The background color of the view that underlies the entire page.
  ///
  /// The theme's [ThemeData.scaffoldBackgroundColor] by default.
  final Color? scaffoldBackgroundColor;

  /// [TextStyle] to be used for title.
  ///
  /// Defaults to TextStyle( fontSize: 24.0, color: Colors.black, fontWeight:
  /// FontWeight.w500, height: 32.0 / 24.0)
  final TextStyle? titleStyle;

  /// [TextStyle] to be used for description.
  ///
  /// Defaults to TextStyle( fontSize: 16.0, height: 22.0 / 16.0)
  final TextStyle? descriptionStyle;

  /// Specifies a preference for the style of the system overlays for the view.
  ///
  /// Defaults to [SystemUiOverlayStyle.dark]
  final SystemUiOverlayStyle? systemUiOverlayStyle;

  const VersionarteInactiveView({
    Key? key,
    this.title,
    this.description,
    this.header,
    this.scaffoldBackgroundColor,
    this.titleStyle = const TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w500,
      height: 32.0 / 24.0,
    ),
    this.descriptionStyle = const TextStyle(
      fontSize: 16.0,
      height: 22.0 / 16.0,
    ),
    this.systemUiOverlayStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final systemUiOverlayStyle_ = systemUiOverlayStyle ?? (Theme.of(context).brightness == Brightness.dark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.light);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemUiOverlayStyle_,
      child: Scaffold(
        backgroundColor: scaffoldBackgroundColor,
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
                      style: titleStyle,
                    ),
                    const SizedBox(height: 16.0),
                  ],
                  if (description != null) ...[
                    Text(
                      description!,
                      textAlign: TextAlign.center,
                      style: descriptionStyle,
                    ),
                  ],
                ],
              ),
            ),
            VersionarteIndicator(
              textStyle: Theme.of(context).textTheme.bodySmall,
            ),
            if (!Platform.isIOS) const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}
