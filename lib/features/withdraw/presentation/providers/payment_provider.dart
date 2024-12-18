import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thrivve_assignment/core/base/error_handler.dart';
import 'package:thrivve_assignment/core/helper/page_loading_dialog/page_loading_dialog.dart';
import 'package:thrivve_assignment/core/helper/show_bottom_sheet/i_show_bottom_sheet.dart';
import 'package:thrivve_assignment/core/helper/show_bottom_sheet/show_bottom_sheet_input.dart';
import 'package:thrivve_assignment/core/helper/show_snack_bar_helper/i_show_snack_bar_helper.dart';
import 'package:thrivve_assignment/core/helper/show_snack_bar_helper/show_snack_bar_input.dart';
import 'package:thrivve_assignment/di.dart';
import 'package:thrivve_assignment/features/withdraw/domain/entities/payment_entity.dart';
import 'package:thrivve_assignment/features/withdraw/domain/use_cases/list_payment_use_case.dart';
import 'package:thrivve_assignment/features/withdraw/presentation/providers/withdraw_provider.dart';
import 'package:thrivve_assignment/features/withdraw/presentation/views/widgets/payment_method_sheet_widget.dart';

class PaymentProvider extends ChangeNotifier {
  PaymentProvider(
    this._getPaymentListUseCase,
    this.iPageLoadingDialog,
    this._showSnackBarHelper,
    this._showBottomSheetHelper,
  );
  final IGetPaymentListUseCase _getPaymentListUseCase;
  final IPageLoadingDialog iPageLoadingDialog;
  final IShowSnackBarHelper _showSnackBarHelper;
  final IShowBottomSheetHelper _showBottomSheetHelper;

  List<PaymentEntity> paymentList = [];
  PaymentEntity? paymentEntity;
  Future<void> getListPayment() async {
    final loader = iPageLoadingDialog.showLoadingDialog();
    try {
      final result = await _getPaymentListUseCase.execute();
      loader.hide();
      paymentList = result;
      openPaymentSheet();
      notifyListeners();
    } catch (error) {
      loader.hide();
      final message = ErrorHandler.handleError(error);
      _showSnackBarHelper.showSnack(ShowSnackBarInput(message: message));
      log('$message');
    }
  }

  void checkPaymentExists() {
    if (paymentList.isEmpty) {
      getListPayment();
    } else {
      openPaymentSheet();
    }
  }

  Future<void> openPaymentSheet() async {
    final dynamic result =
        await _showBottomSheetHelper.showBottomSheet<dynamic>(
      ShowBottomSheetInput(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.sp),
            topRight: Radius.circular(12.sp),
          ),
        ),
        PaymentMethodSheetWidget(
          selectedPayment: paymentEntity,
          listPaymentMethods: paymentList,
        ),
        enableDrag: true,
        isScrollControlled: true,
      ),
    );

    if (result is PaymentEntity) {
      setSelectedPayment(result);
      getIt<WithdrawProvider>().setSelectedPayment(result);
    }
  }

  void setSelectedPayment(PaymentEntity payment) {
    paymentEntity = payment;
    notifyListeners();
  }
}
