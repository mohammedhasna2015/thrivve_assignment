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
    ScaffoldMessenger.of(StaticVar.context).showSnackBar(SnackBar(
        content: Container(
      padding:
          EdgeInsetsDirectional.symmetric(vertical: 8.sp, horizontal: 16.sp),
      margin: EdgeInsetsDirectional.all(10.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.sp),
        border: Border.all(
          color: ThemeColors.red,
        ),
        color: ThemeColors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextWidget(
            title: input.message ?? '',
            color: ThemeColors.black,
            size: 13,
            fontWeight: FontWeight.w400,
          )
        ],
      ),
    )));
  }
}
