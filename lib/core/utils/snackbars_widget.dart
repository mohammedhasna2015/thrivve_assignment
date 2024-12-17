import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thrivve_assignment/core/themes/colors.dart';

class SnackBars {
  static const DANGER_COLOR = Color(0xFFFF5A5F);
  static const SUCCESS_COLOR = Color(0xFF34C759);
  static const DURATION = Duration(seconds: 3);

  static const BAR_MARGIN = 8.0;
  static const BAR_CORNERS_RADIUS = 8.0;
  static const MESSAGE_KEY = 'Message';

  static danger(BuildContext context, String? message) {
    _dismissKeyboard(context);
    message = message ?? 'null';
    final messageBody =
        message.contains('{') ? _parseMessage(message) : message;
    late Flushbar flush;
    flush = Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.all(BAR_MARGIN),
      borderRadius: BorderRadius.circular(BAR_CORNERS_RADIUS),
      message: messageBody,
      backgroundColor: DANGER_COLOR,
      duration: DURATION,
      isDismissible: true,
      mainButton: IconButton(
        icon: const Icon(CupertinoIcons.clear_thick, color: Colors.white),
        onPressed: () => flush.dismiss(),
      ),
    )..show(context);
  }

  static dangerBottom(BuildContext context, String? message) {
    _dismissKeyboard(context);
    late Flushbar flush;
    flush = Flushbar(
      flushbarPosition: FlushbarPosition.BOTTOM,
      padding: EdgeInsets.only(
        right: 8.w,
        left: 8.w,
        top: 5.sp,
        bottom: 5.sp,
      ),
      margin: EdgeInsets.only(
        right: 16.w,
        left: 16.w,
        bottom: 90.sp,
      ),
      borderRadius: BorderRadius.circular(10),
      message: message,
      messageColor: ThemeColors.white,
      messageSize: 13.sp,
      backgroundColor: ThemeColors.primaryColor,
      duration: DURATION,
      isDismissible: true,
      mainButton: Container(
        margin: EdgeInsetsDirectional.only(
          end: 16.w,
        ),
        width: 22.sp,
        height: 26.sp,
        child: CircleAvatar(
          backgroundColor: ThemeColors.white,
          child: IconButton(
            icon: Icon(
              CupertinoIcons.clear_thick,
              color: Colors.black,
              size: 13.w,
            ),
            onPressed: () => flush.dismiss(),
          ),
        ),
      ),
    )..show(context);
  }

  static successTop(BuildContext context, String? message, {Widget? icon}) {
    _dismissKeyboard(context);

    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      borderRadius: BorderRadius.circular(12.0),
      borderColor: ThemeColors.color13B537,
      padding: EdgeInsets.all(10.sp),
      message: message ?? '',
      messageColor: ThemeColors.white,
      backgroundColor: ThemeColors.white,
      duration: DURATION,
      isDismissible: true,
      icon: icon,
    ).show(context);
  }

  static String? _parseMessage(String message) {
    try {
      Map jsonMessage = json.decode(message);
      if (jsonMessage.containsKey(MESSAGE_KEY)) return jsonMessage[MESSAGE_KEY];
      return 'ERROR!';
    } catch (error) {
      debugPrint(error.toString());
      rethrow;
    }
  }

  static void _dismissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
