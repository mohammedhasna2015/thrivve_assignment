import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:thrivve_assignment/core/helper/page_loading_dialog/page_loading_dialog.dart';
import 'package:thrivve_assignment/core/helper/show_snack_bar_helper/i_show_snack_bar_helper.dart';
import 'package:thrivve_assignment/features/withdraw/domain/entities/payment_entity.dart';
import 'package:thrivve_assignment/features/withdraw/domain/entities/withdraw_confirm_entity.dart';
import 'package:thrivve_assignment/features/withdraw/domain/use_cases/withdraw_confrim_use_case.dart';
import 'package:thrivve_assignment/features/withdraw/presentation/providers/payment_provider.dart';
import 'package:thrivve_assignment/features/withdraw/presentation/providers/withdraw_provider.dart';

import 'withdraw_provider_test.mocks.dart';

@GenerateMocks([
  IGetWithDrawUseCase,
  IPageLoadingDialog,
  IShowSnackBarHelper,
  PaymentProvider,
  PageLoadingDialogStatus,
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockIPageLoadingDialog mockPageLoadingDialog;
  late MockIGetWithDrawUseCase mockWithDrawUseCase;
  late MockIShowSnackBarHelper mockShowSnackBarHelper;
  late MockPaymentProvider mockPaymentProvider;
  late WithdrawProvider withdrawProvider;
  late MockPageLoadingDialogStatus mockPageLoadingDialogStatus;
  setUp(() {
    mockPageLoadingDialog = MockIPageLoadingDialog();
    mockWithDrawUseCase = MockIGetWithDrawUseCase();
    mockShowSnackBarHelper = MockIShowSnackBarHelper();
    mockPaymentProvider = MockPaymentProvider();
    mockPageLoadingDialogStatus = MockPageLoadingDialogStatus();

    when(mockPageLoadingDialog.showLoadingDialog())
        .thenReturn(mockPageLoadingDialogStatus);

    withdrawProvider = WithdrawProvider(
      mockShowSnackBarHelper,
      mockPageLoadingDialog,
      mockWithDrawUseCase,
      mockPaymentProvider,
    );
  });

  group('WithdrawProvider Tests', () {
    group('Amount Handling', () {
      test('setAmount should update controller text and notify listeners', () {
        withdrawProvider.setAmount(100);
        expect(withdrawProvider.inputWithDrawController.text, '100.00');
      });

      test('test suggested with available balance', () async {
        withdrawProvider.availableBalance = 400;
        await withdrawProvider.getSuggestedAmounts();
        expect(withdrawProvider.amounts, [50, 150, 250, 400]);
      });

      test('setIndexSelectionSuggested should update amount if valid index',
          () {
        withdrawProvider.amounts = [50, 100, 150, 200];
        withdrawProvider.setIndexSelectionSuggested(1);
        expect(withdrawProvider.inputWithDrawController.text, '100.00');
        expect(withdrawProvider.indexSelectionSuggested, 1);
      });

      test('resetController should clear input text', () {
        withdrawProvider.setAmount(100);
        withdrawProvider.resetController();
        expect(withdrawProvider.inputWithDrawController.text, '');
      });
    });

    group('Payment Method', () {
      test('setSelectedPayment should update payment entity', () {
        final payment = PaymentEntity(bankId: 1, bankName: 'Test Payment');
        withdrawProvider.setSelectedPayment(payment);
        expect(withdrawProvider.paymentEntity, payment);
      });

      test('openPaymentMethod should call checkPaymentExists', () {
        withdrawProvider.openPaymentMethod();
        verify(mockPaymentProvider.checkPaymentExists()).called(1);
      });
    });

    group('Suggested Amounts', () {
      test('getSuggestedAmounts should generate correct values', () async {
        await withdrawProvider.getSuggestedAmounts();
        expect(withdrawProvider.amounts.length, 4);
        expect(withdrawProvider.amounts.first, 50);
        expect(withdrawProvider.amounts.last,
            (withdrawProvider.availableBalance ~/ 50) * 50);
      });

      test('generateWithdrawalSuggestions should handle balance less than 50',
          () {
        final suggestions = withdrawProvider.generateWithdrawalSuggestions(40);
        expect(suggestions, isEmpty);
      });
    });

    group('Input Validation', () {
      test('checkInputUser should fail with empty input', () {
        withdrawProvider.inputWithDrawController.text = '';
        expect(withdrawProvider.checkInputUser(), false);
        verify(mockShowSnackBarHelper.showSnack(any)).called(1);
      });

      test('checkInputUser should fail when amount exceeds balance', () {
        withdrawProvider.inputWithDrawController.text = '10000';
        expect(withdrawProvider.checkInputUser(), false);
        verify(mockShowSnackBarHelper.showSnack(any)).called(1);
      });

      test('checkInputUser should fail when no payment method selected', () {
        withdrawProvider.inputWithDrawController.text = '100';
        withdrawProvider.paymentEntity = null;
        expect(withdrawProvider.checkInputUser(), false);
        verify(mockShowSnackBarHelper.showSnack(any)).called(1);
      });
    });

    group('Withdraw Request', () {
      final successResult = WithdrawConfirmEntity(
        title: "Confirmed successfully",
        message: "Your payment request has been placed successfully.",
      );

      test('successful withdraw should update loading state', () async {
        when(mockWithDrawUseCase.execute())
            .thenAnswer((_) async => successResult);

        withdrawProvider.inputWithDrawController.text = '100';
        withdrawProvider.paymentEntity =
            PaymentEntity(bankId: 1, bankName: 'Test');

        expect(withdrawProvider.isLoadingConfirm, false);
        await withdrawProvider.withdrawRequest();
        expect(withdrawProvider.isLoadingConfirm, true);

        verify(mockPageLoadingDialogStatus.hide()).called(1);
      });

      test('failed withdraw should show error message', () async {
        when(mockWithDrawUseCase.execute()).thenThrow(Exception('Test error'));

        withdrawProvider.inputWithDrawController.text = '100';
        withdrawProvider.paymentEntity =
            PaymentEntity(bankId: 1, bankName: 'Test');

        await withdrawProvider.withdrawRequest();
        expect(withdrawProvider.isLoadingConfirm, false);

        verify(mockShowSnackBarHelper.showSnack(any)).called(1);
        verify(mockPageLoadingDialogStatus.hide()).called(1);
      });
    });
  });
}
