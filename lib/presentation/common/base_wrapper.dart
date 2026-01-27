import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform;
import 'package:flutter/material.dart';

/// Responsive wrapper that switches between mobile and desktop layouts.
class BaseWrapper extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;
  final double breakpoint;

  const BaseWrapper({
    super.key,
    required this.mobile,
    required this.desktop,
    this.breakpoint = 600,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = _isDesktopPlatform || width >= breakpoint;

    return isDesktop ? desktop : mobile;
  }

  bool get _isDesktopPlatform => false;

  /// TODO: temporary set false for mobile web
  // kIsWeb ||
  // defaultTargetPlatform == TargetPlatform.macOS ||
  // defaultTargetPlatform == TargetPlatform.windows ||
  // defaultTargetPlatform == TargetPlatform.linux;
}
