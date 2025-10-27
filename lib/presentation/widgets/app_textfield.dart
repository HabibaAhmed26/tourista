import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tourista/core/theme/app_colors.dart';
import 'package:tourista/core/utils/validator/app_Validator.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.onChange,
    this.hint,
    this.suffixIcon,
    this.prefixIcon,
    this.style,
    this.keyboardType,
    this.isReadOnly,
    this.obscureText,
    this.width,
    this.height,
    this.validator,
    this.inputFormatters,
    this.onSaved,
    this.prefixText,
    this.color,
    this.radius,
  });
  final TextEditingController controller;
  final Function(String)? onChange;
  final Function(String?)? onSaved;
  final String? hint;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextStyle? style;
  final TextInputType? keyboardType;
  final bool? isReadOnly;
  final bool? obscureText;
  final double? width;
  final double? height;
  final AppValidator? validator;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefixText;
  final Color? color;
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
            color: color ?? AppColors.white,
          ),
          height: height ?? 50,
          width: width ?? double.infinity,
          child: Center(
            child: TextFormField(
              controller: controller,
              //
              onChanged: onChange,
              onSaved: onSaved,
              //
              inputFormatters: inputFormatters,
              decoration: InputDecoration(
                hintText: hint,
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon,
                prefixText: prefixText,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
              ),

              //
              style: style ?? TextStyle(fontSize: 14, color: AppColors.black),
              keyboardType: keyboardType ?? TextInputType.text,
              readOnly: isReadOnly ?? false,
              obscureText: obscureText ?? false,
              textAlign: TextAlign.justify,
            ),
          ),
        ),
        if (validator != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: getValidationHints(),
          ),
      ],
    );
  }

  Widget getValidationHints() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ...validator!.reasons.map(
          (e) => Column(
            children: [
              const SizedBox(height: 5),
              Text(
                e,
                style: TextStyle(
                  color: AppColors.red,
                  fontSize: 10,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
