import 'package:e4u_application/app/app.dart';
import 'package:e4u_application/gen/assets.gen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AuthRequiredLabel extends StatelessWidget {
  const AuthRequiredLabel({
    super.key,
    required this.label,
    this.isRequired = true,
  });

  final String label;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: StyleManager.bodyMedium.copyWith(color: ColorManager.grey950),
        ),
        if (isRequired) ...[
          const SizedBox(width: 4),
          Text(
            '*',
            style: StyleManager.smallBodyMedium
                .copyWith(color: const Color(0xFFED5554)),
          ),
        ],
      ],
    );
  }
}

class AuthPillTextField extends StatelessWidget {
  const AuthPillTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.validator,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.keyboardType,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputAction textInputAction;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        style: StyleManager.bodySemiBold.copyWith(color: ColorManager.grey950),
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: ColorManager.baseWhite,
          hintText: hintText,
          hintStyle:
              StyleManager.bodyMedium.copyWith(color: ColorManager.grey400),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(96),
            borderSide: const BorderSide(
              color: ColorManager.grey100,
              width: 1.2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(96),
            borderSide: const BorderSide(
              color: ColorManager.grey100,
              width: 1.2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(96),
            borderSide: const BorderSide(
              color: ColorManager.grey100,
              width: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}

class AuthPrimaryPillButton extends StatelessWidget {
  const AuthPrimaryPillButton({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ColorManager.purpleHard,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        text,
        style: StyleManager.subHeaderSmallMedium.copyWith(color: Colors.white),
      ),
    );
  }
}

class AuthOrDivider extends StatelessWidget {
  const AuthOrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(color: ColorManager.grey300, height: 1),
        ),
        const SizedBox(width: 16),
        Text(
          'Or',
          style: StyleManager.subHeaderSmallRegular
              .copyWith(color: ColorManager.grey400),
        ),
        const SizedBox(width: 16),
        const Expanded(
          child: Divider(color: ColorManager.grey300, height: 1),
        ),
      ],
    );
  }
}

class AuthSocialButton extends StatelessWidget {
  const AuthSocialButton({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
  });

  final String label;
  final AssetGenImage icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: onTap,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: ColorManager.baseWhite,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: ColorManager.grey100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon.image(width: 20, height: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: StyleManager.subHeaderSmallMedium
                  .copyWith(color: ColorManager.grey950),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthTermsText extends StatelessWidget {
  const AuthTermsText({
    super.key,
    required this.onTapTerms,
    required this.onTapPrivacy,
  });

  final VoidCallback onTapTerms;
  final VoidCallback onTapPrivacy;

  @override
  Widget build(BuildContext context) {
    final baseStyle =
        StyleManager.bodyMedium.copyWith(color: ColorManager.grey500);
    final linkStyle = baseStyle.copyWith(
      color: ColorManager.purpleHard,
      decoration: TextDecoration.underline,
    );

    return Text.rich(
      TextSpan(
        style: baseStyle,
        children: [
          const TextSpan(text: 'By continuing, you agree to Fluengo AI '),
          TextSpan(
            text: 'Terms & Service',
            style: linkStyle,
            recognizer: TapGestureRecognizer()..onTap = onTapTerms,
          ),
          const TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy.',
            style: linkStyle,
            recognizer: TapGestureRecognizer()..onTap = onTapPrivacy,
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}

class AuthBottomLink extends StatelessWidget {
  const AuthBottomLink({
    super.key,
    required this.prefix,
    required this.linkText,
    required this.onTap,
  });

  final String prefix;
  final String linkText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final baseStyle =
        StyleManager.bodyMedium.copyWith(color: ColorManager.grey500);
    final linkStyle = baseStyle.copyWith(
      color: ColorManager.purpleHard,
      decoration: TextDecoration.underline,
    );

    return Text.rich(
      TextSpan(
        style: baseStyle,
        children: [
          TextSpan(text: prefix),
          TextSpan(
            text: linkText,
            style: linkStyle,
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
