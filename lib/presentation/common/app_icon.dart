import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../app/app.dart';

/// AppIcon - Reusable icon widget that handles both SVG and PNG icons
/// Provides consistent sizing, coloring, and styling
///
/// Usage:
/// ```dart
/// // Using IconManager
/// AppIcon(assetPath: IconManager.home)
///
/// // Using flutter_gen (after running fluttergen)
/// AppIcon(assetPath: Assets.icons.svg.home04)
/// ```
class AppIcon extends StatelessWidget {
  final String assetPath;
  final double? size;
  final Color? color;
  final BoxFit fit;
  final String? semanticLabel;

  const AppIcon({
    super.key,
    required this.assetPath,
    this.size,
    this.color,
    this.fit = BoxFit.contain,
    this.semanticLabel,
  });

  /// Create AppIcon from IconManager path
  factory AppIcon.fromPath(
    String path, {
    double? size,
    Color? color,
    BoxFit fit = BoxFit.contain,
    String? semanticLabel,
  }) {
    return AppIcon(
      assetPath: path,
      size: size,
      color: color,
      fit: fit,
      semanticLabel: semanticLabel,
    );
  }

  /// Create AppIcon with default size from StyleManager
  factory AppIcon.sized(
    String path, {
    double? size,
    Color? color,
    BoxFit fit = BoxFit.contain,
    String? semanticLabel,
  }) {
    return AppIcon(
      assetPath: path,
      size: size ?? 24.0,
      color: color,
      fit: fit,
      semanticLabel: semanticLabel,
    );
  }

  @override
  Widget build(BuildContext context) {
    final iconSize = size ?? 24.0;
    final iconColor = color ?? ColorManager.textBlockColorLight;

    // Check if it's an SVG file
    if (assetPath.endsWith('.svg')) {
      return SvgPicture.asset(
        assetPath,
        width: iconSize,
        height: iconSize,
        colorFilter: iconColor != Colors.transparent
            ? ColorFilter.mode(iconColor, BlendMode.srcIn)
            : null,
        fit: fit,
        semanticsLabel: semanticLabel,
      );
    } else {
      // Handle PNG or other image formats
      return Image.asset(
        assetPath,
        width: iconSize,
        height: iconSize,
        color: iconColor != Colors.transparent ? iconColor : null,
        fit: fit,
        semanticLabel: semanticLabel,
      );
    }
  }
}

/// AppIconButton - Icon wrapped in a button for easy interaction
class AppIconButton extends StatelessWidget {
  final String assetPath;
  final VoidCallback? onPressed;
  final double? size;
  final Color? color;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final String? tooltip;
  final String? semanticLabel;

  const AppIconButton({
    super.key,
    required this.assetPath,
    this.onPressed,
    this.size,
    this.color,
    this.backgroundColor,
    this.padding,
    this.tooltip,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    final icon = AppIcon(
      assetPath: assetPath,
      size: size,
      color: color,
      semanticLabel: semanticLabel,
    );

    Widget button = IconButton(
      onPressed: onPressed,
      icon: icon,
      padding: padding ?? EdgeInsets.zero,
      tooltip: tooltip,
      color: color,
    );

    if (backgroundColor != null) {
      button = Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: button,
      );
    }

    return button;
  }
}
