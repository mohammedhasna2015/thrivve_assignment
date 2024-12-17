import 'package:flutter/material.dart';

class ShowDialogInput {
  const ShowDialogInput({
    this.context,
    required this.builder,
    this.barrierDismissible = true,
    this.barrierColor = Colors.black54,
    this.barrierLabel,
    this.useSafeArea = true,
    this.useRootNavigator = true,
    this.routeSettings,
    this.anchorPoint,
  });
  final BuildContext? context;
  final Widget Function(BuildContext) builder;
  final bool barrierDismissible;
  final Color barrierColor;
  final String? barrierLabel;
  final bool useSafeArea;
  final bool useRootNavigator;
  final RouteSettings? routeSettings;
  final Offset? anchorPoint;
}
