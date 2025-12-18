import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

/// Mobile vs Desktop wrapper with web-friendly breakpoints.
/// Material suggests responsive widths at 480, 600, 840, 960, 1280, 1440, 1600.
/// For web, desktop commonly starts at 1024 (some teams use 960).
class BaseWrapper extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;

  /// Use 1024 by default; set to 960 if you want an earlier desktop layout.
  final double desktopBreakpoint;

  /// Optional max content width for wide desktop web (prevents lines from getting too long).
  final double? maxContentWidth;

  const BaseWrapper({
    Key? key,
    required this.mobile,
    required this.desktop,
    this.desktopBreakpoint = 1024, // Material-friendly desktop start
    this.maxContentWidth, // e.g., 1200–1440 for web
  })  : assert(desktopBreakpoint > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        // Decide mobile vs desktop by width
        final isDesktop = width >= desktopBreakpoint;

        if (!isDesktop) {
          // Mobile (phones and narrow web windows)
          return mobile;
        }

        // Desktop (including tablets in landscape on wide windows and web)
        final desktopChild = desktop;

        // On web, optionally bound content width and center it for readability.
        if (kIsWeb && maxContentWidth != null && width > maxContentWidth!) {
          return Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxContentWidth!),
              child: desktopChild,
            ),
          );
        }
        return desktopChild;
      },
    );
  }
}
