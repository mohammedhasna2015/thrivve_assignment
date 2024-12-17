import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thrivve_assignment/core/utils/static_var.dart';

abstract class IPageLoadingDialog {
  PageLoadingDialogStatus showLoadingDialog();
}

class PageLoadingDialog implements IPageLoadingDialog {
  @override
  PageLoadingDialogStatus showLoadingDialog() {
    final Future<void> future = showDialog(
      context: StaticVar.context,
      builder: (_) => WillPopScope(
        child: loadingIndicator(),
        onWillPop: () async => false,
      ),
      barrierDismissible: true,
    );

    return PageLoadingDialogStatus(future);
  }

  static const DIALOG_SIDE_LENGTH = 70.0;
  static const DIALOG_BORDER_RADIUS = 5.0;
  static const DIALOG_INDICATOR_RADIUS = 17.5;
  static const DIALOG_COLOR_OPACITY = 0.7;

  static loadingIndicator() {
    return Center(
      child: Container(
        width: DIALOG_SIDE_LENGTH,
        height: DIALOG_SIDE_LENGTH,
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(DIALOG_COLOR_OPACITY),
            borderRadius: BorderRadius.circular(DIALOG_BORDER_RADIUS)),
        child: Theme(
          data: ThemeData(
              cupertinoOverrideTheme:
                  const CupertinoThemeData(brightness: Brightness.dark)),
          child: Platform.isIOS
              ? const CupertinoActivityIndicator(
                  radius: DIALOG_INDICATOR_RADIUS,
                )
              : const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: DIALOG_INDICATOR_RADIUS * 2,
                        height: DIALOG_INDICATOR_RADIUS * 2,
                        child: CircularProgressIndicator()),
                  ],
                ),
        ),
      ),
    );
  }
}

class PageLoadingDialogStatus {
  PageLoadingDialogStatus(this._future) {
    _future.whenComplete(() => _isCompleted = true);
  }

  final Future<void> _future;
  bool _isCompleted = false;
  bool get isLoading => !_isCompleted;
  void hide() {
    if (_isCompleted) {
      return;
    }
    _isCompleted = true;
    Navigator.pop(StaticVar.context);
  }
}
