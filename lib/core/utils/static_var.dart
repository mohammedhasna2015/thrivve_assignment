import 'package:flutter/cupertino.dart';
import 'package:thrivve_assignment/core/utils/navigation_service.dart';
import 'package:thrivve_assignment/di.dart';

class StaticVar {
  static BuildContext context =
      getIt<NavigationService>().navigationKey.currentContext!;
  static String accessToken = '';
}
