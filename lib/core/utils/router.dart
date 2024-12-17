import 'package:flutter/material.dart';
import 'package:thrivve_assignment/features/splash/presentation/views/pages/splash_page.dart';
import 'package:thrivve_assignment/features/withdraw/presentation/views/pages/withdraw_page.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings? settings) {
    switch (settings!.name) {
      case SplashPage.routeName:
        return MaterialPageRoute(
          settings: RouteSettings(
            arguments: settings.arguments,
            name: SplashPage.routeName,
          ),
          builder: (_) => SplashPage(),
        );
      case WithdrawPage.routeName:
        return MaterialPageRoute(
          settings: RouteSettings(
            arguments: settings.arguments,
            name: WithdrawPage.routeName,
          ),
          builder: (_) => WithdrawPage(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
