part of '../app.dart';

class StyleManager {
  // Font Family
  static const String fontFamily = 'Inter';

  // style metrics
  static const Color primaryTextColor =
      Color(0xFF000000); // Default black color for primary text
  static const Color secondaryTextColor =
      Color(0xFF888888); // Default gray color for secondary text
  static const Color accentTextColor = Color(0xFF007AFF); // Blue accent color
  static const Color buttonEnabledTextColor = Color(0xFFeff5f9);
  static const Color buttonDisabledTextColor =
      Color(0xFF000000); // Blue accent color

  // Typography Scale - Inter Font System (iOS)
  // Heading Large
  static const double headingLargeSize = 28.0;
  static const double headingLargeLineHeight = 36.0;

  // Heading Medium
  static const double headingMediumSize = 24.0;
  static const double headingMediumLineHeight = 32.0;

  // Heading Small
  static const double headingSmallSize = 20.0;
  static const double headingSmallLineHeight = 28.0;

  // Sub-Header Medium
  static const double subHeaderMediumSize = 18.0;
  static const double subHeaderMediumLineHeight = 26.0;

  // Sub-Header Small
  static const double subHeaderSmallSize = 16.0;
  static const double subHeaderSmallLineHeight = 24.0;

  // Body
  static const double bodySize = 14.0;
  static const double bodyLineHeight = 20.0;

  // Small Body
  static const double smallBodySize = 12.0;
  static const double smallBodyLineHeight = 16.0;

  // Legacy sizes (kept for backward compatibility)
  static const double fontSizeSmall = 12.0;
  static const double fontSizeMedium = 14.0;
  static const double fontSizeLarge = 16.0;
  static const double fontSizeXLarge = 18.0;
  static const double fontSizeXXLarge = 24.0;
  static const double fontSizeXXXLarge = 32.0;

  static const double letterSpacingNormal = 0.0; // Inter uses 0% letter spacing
  static const double lineHeight = 1.5;

  // Text Styles - Inter Font System (iOS)
  // Heading Large
  static TextStyle get headingLargeSemiBold => const TextStyle(
        fontFamily: fontFamily,
        fontSize: headingLargeSize,
        height: headingLargeLineHeight / headingLargeSize,
        color: primaryTextColor,
        fontWeight: FontWeight.w600, // SemiBold
        letterSpacing: 0,
      );

  static TextStyle get headingLargeMedium => const TextStyle(
        fontFamily: fontFamily,
        fontSize: headingLargeSize,
        height: headingLargeLineHeight / headingLargeSize,
        color: primaryTextColor,
        fontWeight: FontWeight.w500, // Medium
        letterSpacing: 0,
      );

  // Heading Medium
  static TextStyle get headingMediumBold => const TextStyle(
        fontFamily: fontFamily,
        fontSize: headingMediumSize,
        height: headingMediumLineHeight / headingMediumSize,
        color: primaryTextColor,
        fontWeight: FontWeight.w700, // Bold
        letterSpacing: 0,
      );

  static TextStyle get headingMediumSemiBold => const TextStyle(
        fontFamily: fontFamily,
        fontSize: headingMediumSize,
        height: headingMediumLineHeight / headingMediumSize,
        color: primaryTextColor,
        fontWeight: FontWeight.w600, // SemiBold
        letterSpacing: 0,
      );

  // Heading Small
  static TextStyle get headingSmallBold => const TextStyle(
        fontFamily: fontFamily,
        fontSize: headingSmallSize,
        height: headingSmallLineHeight / headingSmallSize,
        color: primaryTextColor,
        fontWeight: FontWeight.w700, // Bold
        letterSpacing: 0,
      );

  static TextStyle get headingSmallSemiBold => const TextStyle(
        fontFamily: fontFamily,
        fontSize: headingSmallSize,
        height: headingSmallLineHeight / headingSmallSize,
        color: primaryTextColor,
        fontWeight: FontWeight.w600, // SemiBold
        letterSpacing: 0,
      );

  // Sub-Header Medium
  static TextStyle get subHeaderMediumSemiBold => const TextStyle(
        fontFamily: fontFamily,
        fontSize: subHeaderMediumSize,
        height: subHeaderMediumLineHeight / subHeaderMediumSize,
        color: primaryTextColor,
        fontWeight: FontWeight.w600, // SemiBold
        letterSpacing: 0,
      );

  static TextStyle get subHeaderMediumMedium => const TextStyle(
        fontFamily: fontFamily,
        fontSize: subHeaderMediumSize,
        height: subHeaderMediumLineHeight / subHeaderMediumSize,
        color: primaryTextColor,
        fontWeight: FontWeight.w500, // Medium
        letterSpacing: 0,
      );

  static TextStyle get subHeaderMediumRegular => const TextStyle(
        fontFamily: fontFamily,
        fontSize: subHeaderMediumSize,
        height: subHeaderMediumLineHeight / subHeaderMediumSize,
        color: primaryTextColor,
        fontWeight: FontWeight.w400, // Regular
        letterSpacing: 0,
      );

  // Sub-Header Small
  static TextStyle get subHeaderSmallSemiBold => const TextStyle(
        fontFamily: fontFamily,
        fontSize: subHeaderSmallSize,
        height: subHeaderSmallLineHeight / subHeaderSmallSize,
        color: primaryTextColor,
        fontWeight: FontWeight.w600, // SemiBold
        letterSpacing: 0,
      );

  static TextStyle get subHeaderSmallMedium => const TextStyle(
        fontFamily: fontFamily,
        fontSize: subHeaderSmallSize,
        height: subHeaderSmallLineHeight / subHeaderSmallSize,
        color: primaryTextColor,
        fontWeight: FontWeight.w500, // Medium
        letterSpacing: 0,
      );

  static TextStyle get subHeaderSmallRegular => const TextStyle(
        fontFamily: fontFamily,
        fontSize: subHeaderSmallSize,
        height: subHeaderSmallLineHeight / subHeaderSmallSize,
        color: primaryTextColor,
        fontWeight: FontWeight.w400, // Regular
        letterSpacing: 0,
      );

  // Body
  static TextStyle get bodySemiBold => const TextStyle(
        fontFamily: fontFamily,
        fontSize: bodySize,
        height: bodyLineHeight / bodySize,
        color: primaryTextColor,
        fontWeight: FontWeight.w600, // SemiBold
        letterSpacing: 0,
      );

  static TextStyle get bodyMedium => const TextStyle(
        fontFamily: fontFamily,
        fontSize: bodySize,
        height: bodyLineHeight / bodySize,
        color: primaryTextColor,
        fontWeight: FontWeight.w500, // Medium
        letterSpacing: 0,
      );

  static TextStyle get bodyRegular => const TextStyle(
        fontFamily: fontFamily,
        fontSize: bodySize,
        height: bodyLineHeight / bodySize,
        color: primaryTextColor,
        fontWeight: FontWeight.w400, // Regular
        letterSpacing: 0,
      );

  // Small Body
  static TextStyle get smallBodySemiBold => const TextStyle(
        fontFamily: fontFamily,
        fontSize: smallBodySize,
        height: smallBodyLineHeight / smallBodySize,
        color: primaryTextColor,
        fontWeight: FontWeight.w600, // SemiBold
        letterSpacing: 0,
      );

  static TextStyle get smallBodyMedium => const TextStyle(
        fontFamily: fontFamily,
        fontSize: smallBodySize,
        height: smallBodyLineHeight / smallBodySize,
        color: primaryTextColor,
        fontWeight: FontWeight.w500, // Medium
        letterSpacing: 0,
      );

  static TextStyle get smallBodyRegular => const TextStyle(
        fontFamily: fontFamily,
        fontSize: smallBodySize,
        height: smallBodyLineHeight / smallBodySize,
        color: primaryTextColor,
        fontWeight: FontWeight.w400, // Regular
        letterSpacing: 0,
      );

  // Legacy Headings (kept for backward compatibility)
  static TextStyle get h1 => const TextStyle(
        fontSize: fontSizeSmall,
        color: primaryTextColor,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get h2 => const TextStyle(
        fontSize: fontSizeMedium,
        color: primaryTextColor,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get h3 => const TextStyle(
        fontSize: fontSizeLarge,
        color: primaryTextColor,
        fontWeight: FontWeight.bold,
      );

  // Title (e.g., "Phone Number Verified", "Reset Password?")
  static TextStyle get title => const TextStyle(
        fontSize: fontSizeXXXLarge,
        color: primaryTextColor,
        fontWeight: FontWeight.bold,
      );

  // Subtitle (e.g., "Congratulations, your phone number has been verified")
  static TextStyle get subtitle => const TextStyle(
        fontSize: fontSizeMedium,
        color: secondaryTextColor,
        fontWeight: FontWeight.normal,
        letterSpacing: letterSpacingNormal,
      );

  // Button Text (e.g., "Continue", "Reset", "Submit")
  static TextStyle get buttonText => const TextStyle(
        fontSize: fontSizeLarge,
        color: buttonEnabledTextColor,
        fontWeight: FontWeight.bold,
      );

  // Form Field Label (e.g., "Email Address", "Phone Number")
  static TextStyle get formFieldLabel => const TextStyle(
        fontSize: fontSizeMedium,
        color: primaryTextColor,
        fontWeight: FontWeight.w600,
      );

  // Form Field Text (e.g., input fields for text like "Enter your address")
  static TextStyle get formFieldText => const TextStyle(
        fontSize: fontSizeLarge,
        color: primaryTextColor,
        fontWeight: FontWeight.normal,
      );

  // Small Info Text (e.g., "Save shipping address")
  static TextStyle get smallInfoText => const TextStyle(
        fontSize: fontSizeSmall,
        color: secondaryTextColor,
        fontWeight: FontWeight.normal,
        letterSpacing: letterSpacingNormal,
      );

  // Error Message Text (e.g., "Oops! Failed", "Appointment failed")
  static TextStyle get errorMessage => const TextStyle(
        fontSize: fontSizeXLarge,
        color: ColorManager.errorColorLight, // Red error color
        fontWeight: FontWeight.bold,
      );

  // Success Message Text (e.g., "Congratulations!")
  static TextStyle get successMessage => const TextStyle(
        fontSize: fontSizeXLarge,
        color: buttonEnabledTextColor, // Blue accent color for success
        fontWeight: FontWeight.bold,
      );

  // List Item Text (e.g., "Dr. Jenny Watson", "Muhammad Haris", in review summary)
  static TextStyle get listItemText => const TextStyle(
        fontSize: fontSizeLarge,
        color: primaryTextColor,
        fontWeight: FontWeight.w500,
      );

  // Small Caption Text (e.g., Doctor's title, e.g., "Immunologist" under the name)
  static TextStyle get smallCaptionText => const TextStyle(
        fontSize: fontSizeSmall,
        color: secondaryTextColor,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.25,
      );

  // Pin Entry Text (e.g., "Enter Your PIN")
  static TextStyle get pinEntryText => const TextStyle(
        fontSize: fontSizeXXLarge,
        color: primaryTextColor,
        fontWeight: FontWeight.w600,
      );

  // Date and Time Text (e.g., "Dec 23, 2024", "10:00 AM")
  static TextStyle get dateTimeText => const TextStyle(
        fontSize: fontSizeMedium,
        color: primaryTextColor,
        fontWeight: FontWeight.normal,
      );

  // Reschedule Option Text (e.g., "I'm not available on schedule")
  static TextStyle get rescheduleOptionText => const TextStyle(
        fontSize: fontSizeMedium,
        color: primaryTextColor,
        fontWeight: FontWeight.normal,
      );

  // Review Summary Text (e.g., "Date & Hour", "Package")
  static TextStyle get reviewSummaryText => const TextStyle(
        fontSize: fontSizeMedium,
        color: primaryTextColor,
        fontWeight: FontWeight.w500,
      );

  // Price Text (e.g., "$20", "$50" in Review Summary)
  static TextStyle get priceText => const TextStyle(
        fontSize: fontSizeLarge,
        color: primaryTextColor,
        fontWeight: FontWeight.bold,
      );

  // Footer Navigation Text (e.g., "Home", "Appointments", "Doctors")
  static TextStyle get footerNavText => const TextStyle(
        fontSize: fontSizeMedium,
        color: secondaryTextColor,
        fontWeight: FontWeight.normal,
      );

  // Toolbar Text (e.g., "Health Management")
  static TextStyle get toolbarText => const TextStyle(
        fontSize: fontSizeXXLarge,
        color: primaryTextColor,
        fontWeight: FontWeight.bold,
      );

  // Hint Text (e.g., "Enter your email", "Enter your password")
  static TextStyle get hintText => const TextStyle(
        fontSize: fontSizeMedium,
        color: secondaryTextColor,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.italic,
      );
}
