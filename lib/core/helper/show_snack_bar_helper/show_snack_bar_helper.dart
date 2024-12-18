import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thrivve_assignment/core/themes/colors.dart';
import 'package:thrivve_assignment/core/utils/static_var.dart';
import 'package:thrivve_assignment/widgets/custom_text_widget.dart';

import 'i_show_snack_bar_helper.dart';
import 'show_snack_bar_input.dart';

class ShowSnackBarHelperImpl implements IShowSnackBarHelper {
  @override
  void showSnack(ShowSnackBarInput input) {
    ScaffoldMessenger.of(StaticVar.context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        padding: EdgeInsetsDirectional.all(2.sp),
        duration: input.duration,
        content: Container(
          padding: EdgeInsetsDirectional.symmetric(
              vertical: 8.sp, horizontal: 16.sp),
          margin: EdgeInsetsDirectional.all(10.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),
            border: Border.all(
              width: 1.5,
              color: ThemeColors.red,
            ),
            color: ThemeColors.white,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.error_outline,
                color: ThemeColors.red,
              ),
              Flexible(
                child: CustomTextWidget(
                  title: input.message ?? '',
                  color: ThemeColors.red,
                  paddingStart: 5.sp,
                  size: 13,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
