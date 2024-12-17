import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thrivve_assignment/core/themes/colors.dart';
import 'package:thrivve_assignment/core/themes/images.dart';
import 'package:thrivve_assignment/core/utils/static_var.dart';
import 'package:thrivve_assignment/core/utils/storage.dart';
import 'package:thrivve_assignment/di.dart';

class SplashPage extends StatefulWidget {
  static const routeName = '/';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    _checkAndNavigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.color1A5798,
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      padding: EdgeInsetsDirectional.only(
        start: 50.sp,
        end: 50.sp,
      ),
      alignment: Alignment.center,
      child: SvgPicture.asset(
        Images.splashIcon,
      ),
    );
  }

  void _checkAndNavigate() {
    Timer(Duration(seconds: 2), () {
      final accessToken = getIt<Storage>().accessToken;
      if (accessToken.isNotEmpty) {
        StaticVar.accessToken = accessToken;
      } else {}
    });
  }
}
