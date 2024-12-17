import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:thrivve_assignment/core/themes/colors.dart';
import 'package:thrivve_assignment/core/utils/navigation_service.dart';
import 'package:thrivve_assignment/core/utils/router.dart';
import 'package:thrivve_assignment/di.dart';
import 'package:thrivve_assignment/features/splash/presentation/views/pages/splash_page.dart';
import 'package:thrivve_assignment/features/withdraw/presentation/providers/withdraw_provider.dart';

import 'widgets/dismiss_keyboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(MultiProvider(providers: _providers(), child: MyApp()));
}

_providers() {
  return [
    ChangeNotifierProvider(create: (_) => getIt<WithdrawProvider>()),
  ];
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: ScreenUtilInit(
        designSize: const Size(375, 647),
        minTextAdapt: true,
        useInheritedMediaQuery: false,
        splitScreenMode: true,
        builder: (_, __) {
          return MaterialApp(
            navigatorKey: getIt<NavigationService>().navigationKey,
            title: 'Thrivve',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: false,
              dialogTheme:
                  const DialogTheme(backgroundColor: ThemeColors.white),
              primarySwatch: Colors.red,
              primaryColor: ThemeColors.primaryColor,
              scaffoldBackgroundColor: ThemeColors.primaryColor,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              fontFamily: 'Cairo',
              colorScheme: ColorScheme.fromSwatch()
                  .copyWith(secondary: ThemeColors.primaryColor),
            ),
            builder: (BuildContext context, Widget? child) {
              return _buildDirectionality(child);
            },
            navigatorObservers: [
              NavigationService.instance.routeObserver,
            ],
            initialRoute: SplashPage.routeName,
            onGenerateRoute: Routers.generateRoute,
          );
        },
      ),
    );
  }

  Widget _buildDirectionality(
    Widget? child,
  ) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: child ?? Container(),
      ),
    );
  }
}
