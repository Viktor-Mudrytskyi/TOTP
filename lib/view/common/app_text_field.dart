import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:totp_authenticator/core/core.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.keyboardType,
    this.suffixIcon,
    this.prefixIcon,
    this.focusNode,
    this.contentPadding,
    this.hintText,
    this.hintStyle,
    this.colorBorder,
    this.errorText,
    this.initialValue,
    this.onChanged,
    this.obscureText,
    this.controller,
    this.showError = true,
    this.enabled = true,
    this.isDense,
    this.width,
    this.onTap,
    this.maxLines = 1,
    this.formatters,
    this.prefixConstr,
    this.expands,
    this.minLines,
    this.textAlign,
    this.onEditingComplete,
    this.maxLength,
    this.onTapOutside,
    this.enableInteractiveSelection,
    this.inputFormatters,
    this.showCursor,
    this.isRequired,
    this.titleText,
    this.autofocus,
    this.scrollPadding = const EdgeInsets.all(20),
    this.style,
    this.decoration,
    this.cursorHeight,
    this.cursorColor,
    this.suffixIconConstraints,
    this.textCapitalization,
  });

  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final EdgeInsets? contentPadding;
  final String? hintText;
  final TextStyle? hintStyle;
  final Color? colorBorder;
  final String? errorText;
  final String? initialValue;
  final bool? obscureText;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final bool? showCursor;
  final TextEditingController? controller;
  final bool showError;
  final bool enabled;
  final bool? isDense;
  final double? width;
  final int? maxLines;
  final List<TextInputFormatter>? formatters;
  final BoxConstraints? prefixConstr;
  final BoxConstraints? suffixIconConstraints;
  final bool? expands;
  final int? minLines;
  final TextAlign? textAlign;
  final int? maxLength;
  final void Function(PointerDownEvent)? onTapOutside;
  final void Function()? onEditingComplete;
  final bool? enableInteractiveSelection;
  final List<TextInputFormatter>? inputFormatters;
  final bool? isRequired;
  final String? titleText;
  final bool? autofocus;
  final EdgeInsets scrollPadding;
  final TextStyle? style;
  final InputDecoration? decoration;
  final double? cursorHeight;
  final Color? cursorColor;
  final TextCapitalization? textCapitalization;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (titleText != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Text(
                    titleText!,
                  ),
                  if (isRequired ?? false)
                    const Text(
                      '*',
                    ),
                ],
              ),
            ),
          TextFormField(
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            obscuringCharacter: '*',
            scrollPadding: scrollPadding,
            autofocus: autofocus ?? false,
            showCursor: showCursor ?? true,
            cursorHeight: cursorHeight,
            inputFormatters: inputFormatters,
            enableInteractiveSelection: enableInteractiveSelection ?? true,
            maxLines: maxLines,
            minLines: minLines,
            maxLength: maxLength,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            textAlign: textAlign ?? TextAlign.start,
            expands: expands ?? false,
            onTap: onTap,
            controller: controller,
            initialValue: initialValue,
            onChanged: onChanged,
            enabled: enabled,
            onEditingComplete: onEditingComplete,
            onTapOutside: onTapOutside,
            cursorColor: Colors.black,
            keyboardType: keyboardType,
            style: style,
            focusNode: focusNode,
            obscureText: obscureText ?? false,
            decoration: decoration ??
                InputDecoration(
                  // filled: true,
                  // fillColor: AppColors.whiteBackground,
                  // counterStyle: AppTextStyles.textfielInput,
                  isDense: true,
                  contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                  border: (showError && errorText.isNotNullOrEmpty)
                      ? OutlineInputBorder(
                          borderSide: BorderSide(
                            color: colorBorder ?? Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        )
                      : OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                  hintText: hintText,
                  hintStyle: hintStyle ?? const TextStyle(color: Colors.grey),
                  suffixIcon: suffixIcon,
                  suffixIconConstraints: suffixIconConstraints ??
                      const BoxConstraints(
                        minHeight: 24,
                        minWidth: 24,
                      ),
                  prefixIcon: prefixIcon,
                  prefixIconConstraints: prefixConstr ??
                      const BoxConstraints(
                        minHeight: 24,
                        minWidth: 24,
                      ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: colorBorder ?? Colors.red,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: (showError && errorText.isNotNullOrEmpty)
                      ? OutlineInputBorder(
                          borderSide: BorderSide(
                            color: colorBorder ?? Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        )
                      : OutlineInputBorder(
                          borderSide: BorderSide(
                            color: colorBorder ?? Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                  focusedBorder: (showError && errorText.isNotNullOrEmpty)
                      ? OutlineInputBorder(
                          borderSide: BorderSide(
                            color: colorBorder ?? Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        )
                      : OutlineInputBorder(
                          borderSide: BorderSide(
                            color: colorBorder ?? Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: colorBorder ?? Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
          ),
          if (errorText != null && showError)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                errorText ?? '',
                style: const TextStyle(color: Colors.red),
              ),
            ),
        ],
      );
}
