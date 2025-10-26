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
    required this.onSaved,
    this.prefixText,
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
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height ?? 50,
          width: width ?? double.infinity,
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
            ),

            //
            style: style ?? TextStyle(fontSize: 14, color: AppColors.black),
            keyboardType: keyboardType ?? TextInputType.text,
            readOnly: isReadOnly ?? false,
            obscureText: obscureText ?? false,
          ),
        ),
        if (validator != null) getValidationHints(),
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
              Text(e, style: TextStyle(color: AppColors.red, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}
