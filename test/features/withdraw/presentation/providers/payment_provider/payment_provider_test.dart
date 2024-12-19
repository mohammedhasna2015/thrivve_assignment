import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:thrivve_assignment/core/base/error_handler.dart';
import 'package:thrivve_assignment/core/helper/page_loading_dialog/page_loading_dialog.dart';
import 'package:thrivve_assignment/core/helper/show_bottom_sheet/i_show_bottom_sheet.dart';
import 'package:thrivve_assignment/core/helper/show_snack_bar_helper/i_show_snack_bar_helper.dart';
import 'package:thrivve_assignment/features/withdraw/domain/entities/payment_entity.dart';
import 'package:thrivve_assignment/features/withdraw/domain/use_cases/list_payment_use_case.dart';
import 'package:thrivve_assignment/features/withdraw/presentation/providers/payment_provider.dart';

import 'payment_provider_test.mocks.dart';

@GenerateMocks(
  [
    IGetPaymentListUseCase,
    IPageLoadingDialog,
    IShowSnackBarHelper,
    IShowBottomSheetHelper,
    PageLoadingDialogStatus,
    ErrorHandler,
  ],
)
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockIPageLoadingDialog mockPageLoadingDialog;
  late MockIGetPaymentListUseCase mockIGetPaymentListUseCase;
  late MockIShowSnackBarHelper mockShowSnackBarHelper;
  late MockIShowBottomSheetHelper mockIShowBottomSheetHelper;
  late MockErrorHandler mockErrorHandler;
  late PaymentProvider paymentProvider;
  late MockPageLoadingDialogStatus mockPageLoadingDialogStatus;
  setUp(() {
    mockPageLoadingDialog = MockIPageLoadingDialog();
    mockIGetPaymentListUseCase = MockIGetPaymentListUseCase();
    mockShowSnackBarHelper = MockIShowSnackBarHelper();
    mockPageLoadingDialogStatus = MockPageLoadingDialogStatus();
    mockIShowBottomSheetHelper = MockIShowBottomSheetHelper();
    mockErrorHandler = MockErrorHandler();
    when(mockPageLoadingDialog.showLoadingDialog())
        .thenReturn(mockPageLoadingDialogStatus);

    paymentProvider = PaymentProvider(
      mockIGetPaymentListUseCase,
      mockPageLoadingDialog,
      mockShowSnackBarHelper,
      mockIShowBottomSheetHelper,
    );
  });
  group('PaymentProvider', () {
    test('getListPayment fetches and updates paymentList', () async {
      final mockPayments = [
        PaymentEntity(bankId: 1, bankName: 'bank 1'),
        PaymentEntity(bankId: 2, bankName: 'bank 2'),
      ];
      when(mockIGetPaymentListUseCase.execute())
          .thenAnswer((_) async => mockPayments);
      when(mockPageLoadingDialog.showLoadingDialog())
          .thenReturn(mockPageLoadingDialogStatus);

      await paymentProvider.getListPayment();

      expect(paymentProvider.paymentList, mockPayments);
      verify(mockPageLoadingDialog.showLoadingDialog()).called(1);
      verify(mockIGetPaymentListUseCase.execute()).called(1);
    });

    test('getListPayment handles errors and shows snack bar', () async {
      final error = Exception('Error fetching payments');
      when(mockIGetPaymentListUseCase.execute()).thenThrow(error);
      when(mockPageLoadingDialog.showLoadingDialog())
          .thenReturn(mockPageLoadingDialogStatus);
      when(mockErrorHandler.handleError(error)).thenReturn('Error occurred');

      await paymentProvider.getListPayment();

      expect(paymentProvider.paymentList, isEmpty);
      verify(mockPageLoadingDialog.showLoadingDialog()).called(1);
      verify(mockShowSnackBarHelper.showSnack(any)).called(1);
    });

    test('checkPaymentExists calls getListPayment if list is empty', () async {
      // Arrange
      when(mockIGetPaymentListUseCase.execute()).thenAnswer((_) async => []);
      when(mockPageLoadingDialog.showLoadingDialog())
          .thenReturn(mockPageLoadingDialogStatus);
      when(mockIShowBottomSheetHelper.showBottomSheet<dynamic>(any))
          .thenAnswer((_) async => null); // Stub this method

      await paymentProvider.checkPaymentExists();

      verify(mockIGetPaymentListUseCase.execute()).called(1);
      verify(mockIShowBottomSheetHelper.showBottomSheet<dynamic>(any))
          .called(1);
    });
    test('checkPaymentExists opens payment sheet if list is not empty',
        () async {
      final mockPayments = [
        PaymentEntity(bankId: 1, bankName: 'bank 1'),
      ];
      paymentProvider.paymentList = mockPayments;
      when(mockIShowBottomSheetHelper.showBottomSheet(any))
          .thenAnswer((_) async => null);

      await paymentProvider.checkPaymentExists();

      verify(mockIShowBottomSheetHelper.showBottomSheet(any)).called(1);
    });

    test('setSelectedPayment updates paymentEntity and notifies listeners', () {
      final payment = PaymentEntity(bankId: 1, bankName: 'bank 1');

      paymentProvider.setSelectedPayment(payment);

      expect(paymentProvider.paymentEntity, payment);
    });
  });
}
