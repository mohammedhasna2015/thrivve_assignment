// Mocks generated by Mockito 5.4.4 from annotations
// in thrivve_assignment/test/features/withdraw/presentation/providers/payment_provider/payment_provider_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i11;
import 'package:thrivve_assignment/core/base/error_handler.dart' as _i10;
import 'package:thrivve_assignment/core/helper/page_loading_dialog/page_loading_dialog.dart'
    as _i2;
import 'package:thrivve_assignment/core/helper/show_bottom_sheet/i_show_bottom_sheet.dart'
    as _i8;
import 'package:thrivve_assignment/core/helper/show_bottom_sheet/show_bottom_sheet_input.dart'
    as _i9;
import 'package:thrivve_assignment/core/helper/show_snack_bar_helper/i_show_snack_bar_helper.dart'
    as _i6;
import 'package:thrivve_assignment/core/helper/show_snack_bar_helper/show_snack_bar_input.dart'
    as _i7;
import 'package:thrivve_assignment/features/withdraw/domain/entities/payment_entity.dart'
    as _i5;
import 'package:thrivve_assignment/features/withdraw/domain/use_cases/list_payment_use_case.dart'
    as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakePageLoadingDialogStatus_0 extends _i1.SmartFake
    implements _i2.PageLoadingDialogStatus {
  _FakePageLoadingDialogStatus_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [IGetPaymentListUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockIGetPaymentListUseCase extends _i1.Mock
    implements _i3.IGetPaymentListUseCase {
  MockIGetPaymentListUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i5.PaymentEntity>> execute() => (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue:
            _i4.Future<List<_i5.PaymentEntity>>.value(<_i5.PaymentEntity>[]),
      ) as _i4.Future<List<_i5.PaymentEntity>>);
}

/// A class which mocks [IPageLoadingDialog].
///
/// See the documentation for Mockito's code generation for more information.
class MockIPageLoadingDialog extends _i1.Mock
    implements _i2.IPageLoadingDialog {
  MockIPageLoadingDialog() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.PageLoadingDialogStatus showLoadingDialog() => (super.noSuchMethod(
        Invocation.method(
          #showLoadingDialog,
          [],
        ),
        returnValue: _FakePageLoadingDialogStatus_0(
          this,
          Invocation.method(
            #showLoadingDialog,
            [],
          ),
        ),
      ) as _i2.PageLoadingDialogStatus);
}

/// A class which mocks [IShowSnackBarHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockIShowSnackBarHelper extends _i1.Mock
    implements _i6.IShowSnackBarHelper {
  MockIShowSnackBarHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void showSnack(_i7.ShowSnackBarInput? input) => super.noSuchMethod(
        Invocation.method(
          #showSnack,
          [input],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [IShowBottomSheetHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockIShowBottomSheetHelper extends _i1.Mock
    implements _i8.IShowBottomSheetHelper {
  MockIShowBottomSheetHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<T?> showBottomSheet<T>(_i9.ShowBottomSheetInput? input) =>
      (super.noSuchMethod(
        Invocation.method(
          #showBottomSheet,
          [input],
        ),
        returnValue: _i4.Future<T?>.value(),
      ) as _i4.Future<T?>);

  @override
  bool isBottomSheetOpen() => (super.noSuchMethod(
        Invocation.method(
          #isBottomSheetOpen,
          [],
        ),
        returnValue: false,
      ) as bool);
}

/// A class which mocks [PageLoadingDialogStatus].
///
/// See the documentation for Mockito's code generation for more information.
class MockPageLoadingDialogStatus extends _i1.Mock
    implements _i2.PageLoadingDialogStatus {
  MockPageLoadingDialogStatus() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get isLoading => (super.noSuchMethod(
        Invocation.getter(#isLoading),
        returnValue: false,
      ) as bool);

  @override
  void hide() => super.noSuchMethod(
        Invocation.method(
          #hide,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [ErrorHandler].
///
/// See the documentation for Mockito's code generation for more information.
class MockErrorHandler extends _i1.Mock implements _i10.ErrorHandler {
  MockErrorHandler() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String handleError(dynamic exception) => (super.noSuchMethod(
        Invocation.method(
          #handleError,
          [exception],
        ),
        returnValue: _i11.dummyValue<String>(
          this,
          Invocation.method(
            #handleError,
            [exception],
          ),
        ),
      ) as String);
}
