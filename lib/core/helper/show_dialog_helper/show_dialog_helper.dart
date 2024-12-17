import 'package:flutter/material.dart' as material;
import 'package:thrivve_assignment/core/utils/static_var.dart';

import 'i_show_dialog_helper.dart';
import 'show_dialog_input.dart';

class ShowDialogHelperImpl implements IShowDialogHelper {
  @override
  Future<T?> showDialog<T>(ShowDialogInput input) {
    return material.showDialog(
      context: input.context ?? StaticVar.context,
      builder: input.builder,
      barrierDismissible: input.barrierDismissible,
      barrierColor: input.barrierColor,
      barrierLabel: input.barrierLabel,
      useSafeArea: input.useSafeArea,
      useRootNavigator: input.useRootNavigator,
      routeSettings: input.routeSettings,
      anchorPoint: input.anchorPoint,
    );
  }
}
