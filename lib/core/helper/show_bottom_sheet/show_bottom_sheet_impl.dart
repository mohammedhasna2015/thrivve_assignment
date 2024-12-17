import 'package:flutter/material.dart';
import 'package:thrivve_assignment/core/themes/colors.dart';
import 'package:thrivve_assignment/core/utils/static_var.dart';

import 'i_show_bottom_sheet.dart';
import 'show_bottom_sheet_input.dart';

class ShowBottomSheetHelperImpl implements IShowBottomSheetHelper {
  bool _isBottomSheetOpen = false;

  @override
  bool isBottomSheetOpen() => _isBottomSheetOpen;

  @override
  Future<T?> showBottomSheet<T>(ShowBottomSheetInput input) async {
    if (_isBottomSheetOpen) {
      return null; // Or handle already open state as needed
    }

    _isBottomSheetOpen = true;

    try {
      final result = await showModalBottomSheet(
        context: StaticVar.context,
        backgroundColor: ThemeColors.primaryColor,
        shape: input.shape,
        builder: (_) => input.bottomsheet,
        elevation: input.elevation,
        clipBehavior: input.clipBehavior,
        barrierColor: input.barrierColor,
        useSafeArea: input.ignoreSafeArea ?? false,
        isScrollControlled: input.isScrollControlled,
        useRootNavigator: input.useRootNavigator,
        isDismissible: input.isDismissible,
        enableDrag: input.enableDrag,
      );

      _isBottomSheetOpen = false;
      return result as T?;
    } catch (e) {
      _isBottomSheetOpen = false;
      rethrow;
    }
  }
}
