import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thrivve_assignment/core/themes/colors.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool
      enabled; // New field to control whether the text field is enabled or disabled

  const CustomTextField({
    Key? key,
    required this.hint,
    this.isPassword = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.enabled = true, // Default is enabled
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.enabled
            ? ThemeColors.white
            : ThemeColors.colorE5E5E5, // Light gray background when disabled
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword ? _obscureText : false,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        style: TextStyle(
          fontSize: 16.sp,
          color: widget.enabled
              ? Colors.black87
              : Colors.grey, // Change text color when disabled
        ),
        enabled: widget.enabled, // Control the enabled state
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(
            color: widget.enabled
                ? ThemeColors.color515151
                    .withOpacity(0.5) // Hint text color when enabled
                : ThemeColors.colorA8A8A8
                    .withOpacity(0.5), // Gray hint text color when disabled
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: widget.enabled
                        ? ThemeColors.colorA8A8A8 // Icon color when enabled
                        : ThemeColors.colorA8A8A8
                            .withOpacity(0.5), // Gray icon color when disabled
                    size: 24.sp,
                  ),
                  onPressed: widget
                          .enabled // Only toggle the password visibility when enabled
                      ? () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        }
                      : null,
                )
              : null,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              width: 1,
              color: widget.enabled
                  ? ThemeColors.colorE5E5E5
                  : ThemeColors.colorE5E5E5
                      .withOpacity(0.5), // Lighter border color when disabled
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              width: 1,
              color: widget.enabled
                  ? ThemeColors.colorE5E5E5
                  : ThemeColors.colorE5E5E5.withOpacity(0.5),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              width: 1,
              color: widget.enabled
                  ? ThemeColors.color515151.withOpacity(0.5)
                  : ThemeColors.color515151
                      .withOpacity(0.3), // Lighter border when disabled
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              width: 1,
              color: ThemeColors.colorE5E5E5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              width: 1,
              color: ThemeColors.colorE5E5E5,
            ),
          ),
          filled: true,
          fillColor: widget.enabled
              ? const Color(0xFFFFFFFF)
              : const Color(
                  0xFFF2F2F2), // Lighter background color when disabled
        ),
      ),
    );
  }
}
