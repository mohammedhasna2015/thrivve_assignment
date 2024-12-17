import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:thrivve_assignment/core/helper/page_loading_dialog/page_loading_dialog.dart';
import 'package:thrivve_assignment/core/helper/show_snack_bar_helper/i_show_snack_bar_helper.dart';
import 'package:thrivve_assignment/core/helper/show_snack_bar_helper/show_snack_bar_input.dart';
import 'package:thrivve_assignment/core/utils/api_exception.dart';
import 'package:thrivve_assignment/di.dart';
import 'package:thrivve_assignment/features/withdraw/domain/use_cases/list_payment_use_case.dart';
import 'package:thrivve_assignment/features/withdraw/domain/use_cases/withdraw_confrim_use_case.dart';

class WithdrawProvider extends ChangeNotifier {
  final IGetWithDrawUseCase _getWithDrawUseCase;
  final IGetPaymentListUseCase _getPaymentListUseCase;
  final IPageLoadingDialog iPageLoadingDialog;
  final IShowSnackBarHelper showSnackBarHelper;
  WithdrawProvider(
    this.showSnackBarHelper,
    this.iPageLoadingDialog,
    this._getWithDrawUseCase,
    this._getPaymentListUseCase,
  );

  Future<void> withdrawRequest() async {
    final loader = getIt<IPageLoadingDialog>().showLoadingDialog();
    try {
      await _getWithDrawUseCase.execute();
      loader.hide();
    } catch (error) {
      loader.hide();
      final apiError = ApiErrorHandler.handle(error);
      showSnackBarHelper
          .showSnack(ShowSnackBarInput(message: apiError.getDisplayMessage()));
      log('An unexpected error occurred: ${apiError.technicalDetails.toString()}');
    }
  }

  Future<void> getListPayment() async {
    final loader = getIt<IPageLoadingDialog>().showLoadingDialog();
    try {
      await _getPaymentListUseCase.execute();
      loader.hide();
    } catch (error) {
      loader.hide();
      final apiError = ApiErrorHandler.handle(error);
      showSnackBarHelper
          .showSnack(ShowSnackBarInput(message: apiError.getDisplayMessage()));

      log('An unexpected error occurred: ${apiError.technicalDetails.toString()}');
    }
  }
}
