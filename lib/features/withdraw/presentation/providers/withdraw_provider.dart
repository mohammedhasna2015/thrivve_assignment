import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:thrivve_assignment/core/helper/optional_mapper.dart';
import 'package:thrivve_assignment/core/helper/page_loading_dialog/page_loading_dialog.dart';
import 'package:thrivve_assignment/core/helper/show_snack_bar_helper/i_show_snack_bar_helper.dart';
import 'package:thrivve_assignment/core/helper/show_snack_bar_helper/show_snack_bar_input.dart';
import 'package:thrivve_assignment/core/utils/api_exception.dart';
import 'package:thrivve_assignment/core/utils/navigation_service.dart';
import 'package:thrivve_assignment/core/utils/shard.dart';
import 'package:thrivve_assignment/features/sucess/presentation/views/arguments/success_page_arguments.dart';
import 'package:thrivve_assignment/features/sucess/presentation/views/pages/success_page.dart';
import 'package:thrivve_assignment/features/withdraw/domain/entities/payment_entity.dart';
import 'package:thrivve_assignment/features/withdraw/domain/entities/withdraw_confirm_entity.dart';
import 'package:thrivve_assignment/features/withdraw/domain/use_cases/withdraw_confrim_use_case.dart';
import 'package:thrivve_assignment/features/withdraw/presentation/providers/payment_provider.dart';

class WithdrawProvider extends ChangeNotifier {
  final IGetWithDrawUseCase _getWithDrawUseCase;
  final IPageLoadingDialog iPageLoadingDialog;
  final IShowSnackBarHelper _showSnackBarHelper;
  final PaymentProvider _paymentProvider;

  WithdrawProvider(
    this._showSnackBarHelper,
    this.iPageLoadingDialog,
    this._getWithDrawUseCase,
    this._paymentProvider,
  );

  final inputWithDrawController = TextEditingController();
  int availableBalance = 9000;
  int indexSelectionSuggested = -1;
  PaymentEntity? paymentEntity;
  List<int> amounts = [];
  void setIndexSelectionSuggested(int index) {
    if (index != -1) {
      setAmount(amounts[index]);
    }
    indexSelectionSuggested = index;
    notifyListeners();
  }

  void setAmount(int amount) {
    inputWithDrawController.text = amount.toStringAsFixed(2);
    notifyListeners();
  }

  Future<void> withdrawRequest() async {
    if (checkInputUser().inverted) return;
    final loader = iPageLoadingDialog.showLoadingDialog();
    try {
      final result = await _getWithDrawUseCase.execute();
      loader.hide();
      _goToSuccessPage(result);
    } catch (error) {
      loader.hide();
      final apiError = ApiErrorHandler.handle(error);
      _showSnackBarHelper
          .showSnack(ShowSnackBarInput(message: apiError.getDisplayMessage()));
      log('An unexpected error occurred: ${apiError.technicalDetails.toString()}');
    }
  }

  void openPaymentMethod() {
    _paymentProvider.checkPaymentExists();
  }

  void setSelectedPayment(PaymentEntity payment) {
    paymentEntity = payment;
    notifyListeners();
  }

  Future<void> getSuggestedAmounts() async {
    final result = generateWithdrawalSuggestions(availableBalance);
    amounts = result;
    notifyListeners();
  }

  void resetController() {
    inputWithDrawController.text = '';
  }

  @override
  void dispose() {
    inputWithDrawController.dispose();
    super.dispose();
  }

  List<int> generateWithdrawalSuggestions(int currentBalance) {
    // Ensure the current balance is at least 50
    if (currentBalance < 50) {
      return [];
    }

    // The minimum suggested value is 50
    int minSuggestion = 50;

    // The maximum suggested value is the current balance
    int maxSuggestion = currentBalance;

    // Ensure the max suggestion is a multiple of 50
    maxSuggestion = (maxSuggestion ~/ 50) * 50;

    // Calculate two additional suggested values between min and max
    List<int> suggestions = [minSuggestion];

    // First additional suggestion: approximately 1/3 of the way between min and max
    int firstAdditional =
        minSuggestion + ((maxSuggestion - minSuggestion) ~/ 3);
    firstAdditional = (firstAdditional ~/ 50) * 50;
    suggestions.add(firstAdditional);

    // Second additional suggestion: approximately 2/3 of the way between min and max
    int secondAdditional =
        minSuggestion + (2 * (maxSuggestion - minSuggestion) ~/ 3);
    secondAdditional = (secondAdditional ~/ 50) * 50;
    suggestions.add(secondAdditional);

    // Add the maximum suggestion
    suggestions.add(maxSuggestion);

    return suggestions;
  }

  bool checkInputUser() {
    bool enabled = true;
    if (inputWithDrawController.text.isEmpty) {
      enabled = false;
      _showSnackBarHelper.showSnack(
        ShowSnackBarInput(
            duration: Duration(milliseconds: 700),
            message:
                'Please enter value to withdraw or select from suggested values'),
      );
    } else if (Shard().parseAmount(inputWithDrawController.text.toString()) >
        availableBalance) {
      enabled = false;
      _showSnackBarHelper.showSnack(
        ShowSnackBarInput(
            duration: Duration(milliseconds: 700),
            message: 'Please enter amount less than $availableBalance sar'),
      );
    } else if (paymentEntity == -1) {
      _showSnackBarHelper.showSnack(
        ShowSnackBarInput(
            duration: Duration(milliseconds: 700),
            message: 'Please select your payment method or add new one'),
      );
      enabled = false;
    }
    return enabled;
  }

  void onChangeInput(String value) {
    setIndexSelectionSuggested(-1);
    notifyListeners();
  }

  void _goToSuccessPage(WithdrawConfirmEntity result) {
    final args = SuccessPageArguments(
      result.title ?? '',
      result.message ?? '',
    );
    NavigationService.instance.navigateToAndRemove(
      SuccessPage.routeName,
      args: args,
    );
  }
}
