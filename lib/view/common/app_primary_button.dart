import 'package:flutter/material.dart';

/// Enum representing the different styles of the primary button.
enum PrimaryButtonStyle {
  /// White style for the primary button.
  white,

  /// Blue style for the primary button.
  blue,

  /// Disable style for the primary button.
  disable,

  ///Light blue button style
  lightBlue,

  red,
}

/// Extension on [PrimaryButtonStyle] to provide additional helper methods.
extension PrimaryButtonStyleExtension on PrimaryButtonStyle? {
  /// Returns `true` if the button style is white.
  bool get isWhite => this == PrimaryButtonStyle.white;

  /// Returns `true` if the button style is blue.
  bool get isBlue => this == PrimaryButtonStyle.blue;

  /// Returns `true` if the button style is disable.
  bool get isDisable => this == PrimaryButtonStyle.disable;

  /// Returns `true` if the button style is not white.
  bool get isNotWhite => this != PrimaryButtonStyle.white;

  /// Returns `true` if the button style is not blue.
  bool get isNotBlue => this != PrimaryButtonStyle.blue;

  /// Returns `true` if the button style is not disable.
  bool get isNotDisable => this != PrimaryButtonStyle.disable;

  /// Returns `true` if the button style is not null.
  bool get isNotNull => this != null;
}

/// Abstract class for handling the styles of the primary button.
abstract class PrimaryButtonHandlerStyle {
  /// Returns the color for the given [style].
  ///
  /// The [style] parameter represents the style of the primary button.
  /// It can be one of the following values:
  /// - [PrimaryButtonStyle.blue]: Returns the primary blue color.
  /// - [PrimaryButtonStyle.white]: Returns the white background color.
  ///
  /// Returns the corresponding color based on the given [style].
  static LinearGradient getButtonColor(PrimaryButtonStyle style) {
    switch (style) {
      case PrimaryButtonStyle.blue:
        return const LinearGradient(
          begin: Alignment(1, 0.01),
          end: Alignment(-1, -0.01),
          colors: <Color>[
            Color(0xFF4849FD),
            Color(0xFF2350FB),
            Color(0xFF2C4EFB),
            Color(0xFF4849FD),
          ],
        );
      case PrimaryButtonStyle.white:
        return const LinearGradient(
          begin: Alignment(1, 0.01),
          end: Alignment(-1, -0.01),
          colors: <Color>[
            Colors.white,
            Colors.white,
            Colors.white,
          ],
        );
      case PrimaryButtonStyle.disable:
        return const LinearGradient(
          begin: Alignment(1, 0.01),
          end: Alignment(-1, -0.01),
          colors: <Color>[
            Colors.lightBlue,
            Colors.lightBlue,
            Colors.lightBlue,
          ],
        );
      case PrimaryButtonStyle.lightBlue:
        return const LinearGradient(
          begin: Alignment(1, 0.01),
          end: Alignment(-1, -0.01),
          colors: <Color>[
            Colors.lightBlue,
            Colors.lightBlue,
            Colors.lightBlue,
          ],
        );
      case PrimaryButtonStyle.red:
        return const LinearGradient(
          begin: Alignment(1, 0.01),
          end: Alignment(-1, -0.01),
          colors: <Color>[Colors.red, Colors.red],
        );
    }
  }

  /// Returns the text style for the given [style].
  ///
  /// The [style] parameter determines the style of the primary button.
  /// If [style] is [PrimaryButtonStyle.white], it returns the text style for a white button.
  /// If [style] is [PrimaryButtonStyle.blue], it returns the text style for a blue button.
  ///
  /// Returns the appropriate [TextStyle] based on the [style] parameter.
  static TextStyle getButtonTextStyle(
    PrimaryButtonStyle style, [
    bool isEnabled = true,
  ]) {
    if (!isEnabled) {
      return const TextStyle(color: Colors.grey);
    }
    switch (style) {
      case PrimaryButtonStyle.white:
        return const TextStyle(color: Colors.blue);
      case PrimaryButtonStyle.blue:
        return const TextStyle(color: Colors.white);
      case PrimaryButtonStyle.disable:
        return const TextStyle(color: Colors.grey);
      case PrimaryButtonStyle.lightBlue:
        return const TextStyle(color: Colors.lightBlue);
      case PrimaryButtonStyle.red:
        return const TextStyle(color: Colors.white);
    }
  }
}

/// A custom primary button widget.
///
/// This widget displays a primary button with customizable properties such as text, height, width, enabled state, prefix and suffix icons, and button style.
class AppPrimaryButton extends StatelessWidget {
  /// Creates a new instance of [AppPrimaryButton].
  ///
  /// The [buttonText] parameter is required.
  /// The [onPressed], [height], [width], [isEnabled], [prefixIcon], [suffixIcon], and [style] parameters are optional.
  const AppPrimaryButton({
    super.key,
    this.buttonText,
    this.onPressed,
    this.height,
    this.width,
    this.isEnabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.style,
  });

  /// The text to display on the button.
  final String? buttonText;

  /// The callback function to be called when the button is pressed.
  final void Function()? onPressed;

  /// The height of the button.
  final double? height;

  /// The width of the button.
  final double? width;

  /// Whether the button is enabled or disabled.
  final bool isEnabled;

  /// The widget to display as a prefix icon.
  final Widget? prefixIcon;

  /// The widget to display as a suffix icon.
  final Widget? suffixIcon;

  /// The style of the button.
  final PrimaryButtonStyle? style;

  @override
  Widget build(BuildContext context) => Material(
        borderRadius: BorderRadius.circular(100),
        child: InkWell(
          onTap: (style.isDisable || !isEnabled) ? null : onPressed,
          borderRadius: BorderRadius.circular(100),
          child: Ink(
            width: width ?? double.maxFinite,
            height: height ?? 56,
            decoration: isEnabled
                ? BoxDecoration(
                    gradient: PrimaryButtonHandlerStyle.getButtonColor(
                      (style.isNotNull) ? style! : PrimaryButtonStyle.blue,
                    ),
                    borderRadius: BorderRadius.circular(100),
                  )
                : BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(100),
                  ),
            child: Center(
              child: Text(
                buttonText ?? '',
                style: PrimaryButtonHandlerStyle.getButtonTextStyle(
                  (style.isNotNull) ? style! : PrimaryButtonStyle.blue,
                  isEnabled,
                ),
              ),
            ),
          ),
        ),
      );
}
