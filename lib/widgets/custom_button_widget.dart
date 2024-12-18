import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thrivve_assignment/core/helper/optional_mapper.dart';
import 'package:thrivve_assignment/core/themes/colors.dart';
import 'package:thrivve_assignment/widgets/custom_text_widget.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color colorButton;
  final Color colorText;
  final Color colorBorder;
  final double elevation;
  final EdgeInsetsDirectional? padding;
  final double? minimumSizeButton;
  final bool enabled;
  final double radius;
  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.elevation = 1,
    this.colorButton = ThemeColors.primaryColor,
    this.colorText = ThemeColors.white,
    this.colorBorder = ThemeColors.primaryColor,
    this.padding,
    this.radius = 6,
    this.minimumSizeButton,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading || enabled.inverted ? null : onPressed,
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: colorButton.withOpacity(0.2),
        elevation: elevation,
        side: enabled
            ? BorderSide(
                color: colorBorder,
              )
            : null,
        backgroundColor: colorButton,
        padding: padding ?? EdgeInsets.symmetric(vertical: 14.sp),
        minimumSize: Size(double.infinity, minimumSizeButton ?? 46.sp),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      child: isLoading
          ? SizedBox(
              height: 20.sp,
              width: 20.sp,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : CustomTextWidget(
              title: text,
              color: colorText,
              size: 16,
              fontWeight: FontWeight.w600,
            ),
    );
  }
}
