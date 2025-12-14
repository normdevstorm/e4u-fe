part of '../app.dart';

class ColorManager {
  // ============================================
  // Figma Design System Colors - iOS Purple/Pink
  // ============================================

  // Purple Colors
  static const Color purpleMain = Color(0xFFE6DBFF);
  static const Color purpleStroke = Color(0xFFDAC9FF);
  static const Color purpleElements = Color(0xFFDAC9FF); // Same as Stroke
  static const Color purpleDark = Color(0xFF61537F);
  static const Color purpleHard = Color(0xFF713AED);
  static const Color purpleLight = Color(0xFFF1ECFE);

  // Extra Colors
  static const Color extraPink = Color(0xFFF089C4);
  static const Color extraSky = Color(0xFFABE2FB);
  static const Color extraPurple = Color(0xFFB99BF8);
  static const Color extraYellow = Color(0xFFF8CD55);

  // Orange Colors
  static const Color orangeMain = Color(0xFFFFDECF);
  static const Color orangeStroke = Color(0xFFFFCBB4);
  static const Color orangeElements = Color(0xFFFFCBB4); // Same as Stroke
  static const Color orangeLighter = Color(0x0ffef0ea);

  // Grey Scale (50-950)
  static const Color grey50 = Color(0xFFF7F8F8);
  static const Color grey100 = Color(0xFFEDEEF1);
  static const Color grey200 = Color(0xFFD8DBDF);
  static const Color grey300 = Color(0xFFB6BAC3);
  static const Color grey400 = Color(0xFF8E95A2);
  static const Color grey500 = Color(0xFF6B7280);
  static const Color grey600 = Color(0xFF5B616E);
  static const Color grey700 = Color(0xFF4A4E5A);
  static const Color grey800 = Color(0xFF40444C);
  static const Color grey900 = Color(0xFF383A42);
  static const Color grey950 = Color(0xFF25272C);

  // Base Colors
  static const Color baseWhite = Color(0xFFFFFFFF);
  static const Color baseBlack = Color(0xFF1E1F20);

  // ============================================
  // Legacy Theme Colors (kept for backward compatibility)
  // ============================================
  // Light Theme Colors
  static const Color primaryColorLight =
      Color(0xFF713AED); // Updated to purpleHard
  static const Color primaryVariantColorLight = Color(0xFF713AED);
  static const Color secondaryColorLight =
      Color(0xFFF089C4); // Updated to extraPink
  static const Color secondaryVariantColorLight = Color(0xFF018786);
  static const Color surfaceColorLight = Color(0xFFF7F8F8); // Updated to grey50
  static const Color backgroundColorLight = Color(0xFFFFFFFF);
  static const Color errorColorLight = Color(0xFFB00020);
  static const Color onPrimaryColorLight = Color(0xFFFFFFFF);
  static const Color onSecondaryColorLight = Color(0xFF000000);
  static const Color onSurfaceColorLight = Color(0xFF000000);
  static const Color onBackgroundColorLight = Color(0xFF000000);
  static const Color onErrorColorLight = Color(0xFFFFFFFF);

  static const Color appBarColorLight =
      Color(0xFF713AED); // Updated to purpleHard
  static const Color dividerColorLight =
      Color(0xFFD8DBDF); // Updated to grey200
  static const Color highlightColorLight =
      Color(0xFF713AED); // Updated to purpleHard
  static const Color hintColorLight = Color(0xFF6B7280); // Updated to grey500
  static const Color selectedRowColorLight =
      Color(0xFFF7F8F8); // Updated to grey50
  static const Color splashColorLight =
      Color(0xFF713AED); // Updated to purpleHard
  static const Color unselectedWidgetColorLight =
      Color(0xFF6B7280); // Updated to grey500

  static const Color iconButtonColorLight =
      Color(0xFFF1ECFE); // Updated to purpleLight
  static const Color textBlockColorLight =
      Color(0xFF1E1F20); // Updated to baseBlack
  static const Color textFieldColorLight =
      Color(0xFF1E1F20); // Updated to baseBlack
  static const Color textFieldCheckoutColorLight =
      Color(0xFF1E1F20); // Updated to baseBlack
  static const Color toggleBackgroundColorLight =
      Color(0xFFEDEEF1); // Updated to grey100
  static const Color searchBarColorLight =
      Color(0xFF1E1F20); // Updated to baseBlack
  static const Color mapViewPinColorLight =
      Color(0xFF713AED); // Updated to purpleHard
  static const Color bottomNavColorLight =
      Color(0xFF1E1F20); // Updated to baseBlack
  static const Color illustrationColorLight =
      Color(0xFF713AED); // Updated to purpleHard
  static const Color pagerIndicatorColorLight =
      Color(0xFF6B7280); // Updated to grey500
  static const Color ratingBarColorLight =
      Color(0xFFF8CD55); // Updated to extraYellow
  static const Color iconColorLight = Color(0xFFB6BAC3); // Updated to grey300
  static const Color textBlockCardColorLight =
      Color(0xFF6B7280); // Updated to grey500
  static const Color cardFieldColorLight =
      Color(0xFF1E1F20); // Updated to baseBlack
  static const Color avatarBorderColorLight =
      Color(0xFFB6BAC3); // Updated to grey300
  static const Color pinFieldColorLight =
      Color(0xFF1E1F20); // Updated to baseBlack
  static const Color radioButtonColorLight =
      Color(0xFF713AED); // Updated to purpleHard
  static const Color datePickerColorLight =
      Color(0xFF713AED); // Updated to purpleHard
  static const Color chipColorLight = Color(0xFF6B7280); // Updated to grey500
  static const Color cardColorLight = Color(0xFFFFFFFF);
  static const Color tabsColorLight = Color(0xFF6B7280); // Updated to grey500
  static const Color dialogBackgroundColorLight = Color(0xFFFFFFFF);
  static const Color secondaryButtonColorLight =
      Color(0xFF6B7280); // Updated to grey500
  static const Color captionColorLight =
      Color(0xFF6B7280); // Updated to grey500

  // Button element colors
  static const Color buttonEnabledColorLight =
      Color(0xFF713AED); // Updated to purpleHard
  static const Color buttonDisbledColorLight =
      Color(0xFFEDEEF1); // Updated to grey100
  static const Color buttonBorderColorLight =
      Color(0xFFB6BAC3); // Updated to grey300
  static Color buttonShadowColorLight = Colors.grey.withOpacity(0.2);

  ///Dark Theme Colors (using darker variants from Figma)
  static const Color primaryColorDark = Color(0xFF713AED); // purpleHard
  static const Color primaryVariantColorDark = Color(0xFF61537F); // purpleDark
  static const Color secondaryColorDark = Color(0xFFF089C4); // extraPink
  static const Color secondaryVariantColorDark = Color(0xFFF089C4);
  static const Color surfaceColorDark = Color(0xFF25272C); // grey950
  static const Color backgroundColorDark = Color(0xFF1E1F20); // baseBlack
  static const Color errorColorDark = Color(0xFFCF6679);
  static const Color onPrimaryColorDark = Color(0xFFFFFFFF);
  static const Color onSecondaryColorDark = Color(0xFFFFFFFF);
  static const Color onSurfaceColorDark = Color(0xFFFFFFFF);
  static const Color onBackgroundColorDark = Color(0xFFFFFFFF);
  static const Color onErrorColorDark = Color(0xFFFFFFFF);

  static const Color appBarColorDark = Color(0xFF713AED); // purpleHard
  static const Color dividerColorDark = Color(0xFF40444C); // grey800
  static const Color highlightColorDark = Color(0xFF713AED); // purpleHard
  static const Color hintColorDark = Color(0xFF6B7280); // grey500
  static const Color selectedRowColorDark = Color(0xFF383A42); // grey900
  static const Color splashColorDark = Color(0xFF713AED); // purpleHard
  static const Color unselectedWidgetColorDark = Color(0xFF6B7280); // grey500

  static const Color iconButtonColorDark = Color(0xFF713AED); // purpleHard
  static const Color textBlockColorDark = Color(0xFFFFFFFF);
  static const Color textFieldColorDark = Color(0xFFFFFFFF);
  static const Color textFieldCheckoutColorDark = Color(0xFFFFFFFF);
  static const Color buttonColorDark = Color(0xFF713AED); // purpleHard
  static const Color searchBarColorDark = Color(0xFFFFFFFF);
  static const Color mapViewPinColorDark = Color(0xFF713AED); // purpleHard
  static const Color bottomNavColorDark = Color(0xFFFFFFFF);
  static const Color illustrationColorDark = Color(0xFF713AED); // purpleHard
  static const Color pagerIndicatorColorDark = Color(0xFF6B7280); // grey500
  static const Color ratingBarColorDark = Color(0xFFF8CD55); // extraYellow
  static const Color iconColorDark = Color(0xFFB6BAC3); // grey300
  static const Color textBlockCardColorDark = Color(0xFF6B7280); // grey500
  static const Color cardFieldColorDark = Color(0xFFFFFFFF);
  static const Color avatarBorderColorDark = Color(0xFFB6BAC3); // grey300
  static const Color pinFieldColorDark = Color(0xFFFFFFFF);
  static const Color radioButtonColorDark = Color(0xFF713AED); // purpleHard
  static const Color datePickerColorDark = Color(0xFF713AED); // purpleHard
  static const Color chipColorDark = Color(0xFF6B7280); // grey500
  static const Color cardColorDark = Color(0xFF383A42); // grey900
  static const Color tabsColorDark = Color(0xFF6B7280); // grey500
  static const Color dialogBackgroundColorDark = Color(0xFF383A42); // grey900
  static const Color secondaryButtonColorDark = Color(0xFF6B7280); // grey500
  static const Color captionColorDark = Color(0xFFB6BAC3); // grey300
}
