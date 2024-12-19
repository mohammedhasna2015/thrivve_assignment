// Mocks generated by Mockito 5.4.4 from annotations
// in thrivve_assignment/test/features/withdraw/presentation/providers/withdraw_provider/withdraw_provider_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:ui' as _i10;

import 'package:mockito/mockito.dart' as _i1;
import 'package:thrivve_assignment/core/helper/page_loading_dialog/page_loading_dialog.dart'
    as _i3;
import 'package:thrivve_assignment/core/helper/show_snack_bar_helper/i_show_snack_bar_helper.dart'
    as _i6;
import 'package:thrivve_assignment/core/helper/show_snack_bar_helper/show_snack_bar_input.dart'
    as _i7;
import 'package:thrivve_assignment/features/withdraw/domain/entities/payment_entity.dart'
    as _i9;
import 'package:thrivve_assignment/features/withdraw/domain/entities/withdraw_confirm_entity.dart'
    as _i2;
import 'package:thrivve_assignment/features/withdraw/domain/use_cases/withdraw_confrim_use_case.dart'
    as _i4;
import 'package:thrivve_assignment/features/withdraw/presentation/providers/payment_provider.dart'
    as _i8;

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

class _FakeWithdrawConfirmEntity_0 extends _i1.SmartFake
    implements _i2.WithdrawConfirmEntity {
  _FakeWithdrawConfirmEntity_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakePageLoadingDialogStatus_1 extends _i1.SmartFake
    implements _i3.PageLoadingDialogStatus {
  _FakePageLoadingDialogStatus_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeIPageLoadingDialog_2 extends _i1.SmartFake
    implements _i3.IPageLoadingDialog {
  _FakeIPageLoadingDialog_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [IGetWithDrawUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockIGetWithDrawUseCase extends _i1.Mock
    implements _i4.IGetWithDrawUseCase {
  MockIGetWithDrawUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.WithdrawConfirmEntity> execute() => (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue: _i5.Future<_i2.WithdrawConfirmEntity>.value(
            _FakeWithdrawConfirmEntity_0(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i5.Future<_i2.WithdrawConfirmEntity>);
}

/// A class which mocks [IPageLoadingDialog].
///
/// See the documentation for Mockito's code generation for more information.
class MockIPageLoadingDialog extends _i1.Mock
    implements _i3.IPageLoadingDialog {
  MockIPageLoadingDialog() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.PageLoadingDialogStatus showLoadingDialog() => (super.noSuchMethod(
        Invocation.method(
          #showLoadingDialog,
          [],
        ),
        returnValue: _FakePageLoadingDialogStatus_1(
          this,
          Invocation.method(
            #showLoadingDialog,
            [],
          ),
        ),
      ) as _i3.PageLoadingDialogStatus);
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

/// A class which mocks [PaymentProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockPaymentProvider extends _i1.Mock implements _i8.PaymentProvider {
  MockPaymentProvider() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.IPageLoadingDialog get iPageLoadingDialog => (super.noSuchMethod(
        Invocation.getter(#iPageLoadingDialog),
        returnValue: _FakeIPageLoadingDialog_2(
          this,
          Invocation.getter(#iPageLoadingDialog),
        ),
      ) as _i3.IPageLoadingDialog);

  @override
  List<_i9.PaymentEntity> get paymentList => (super.noSuchMethod(
        Invocation.getter(#paymentList),
        returnValue: <_i9.PaymentEntity>[],
      ) as List<_i9.PaymentEntity>);

  @override
  set paymentList(List<_i9.PaymentEntity>? _paymentList) => super.noSuchMethod(
        Invocation.setter(
          #paymentList,
          _paymentList,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set paymentEntity(_i9.PaymentEntity? _paymentEntity) => super.noSuchMethod(
        Invocation.setter(
          #paymentEntity,
          _paymentEntity,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);

  @override
  _i5.Future<void> getListPayment() => (super.noSuchMethod(
        Invocation.method(
          #getListPayment,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> checkPaymentExists() => (super.noSuchMethod(
        Invocation.method(
          #checkPaymentExists,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> openPaymentSheet() => (super.noSuchMethod(
        Invocation.method(
          #openPaymentSheet,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  void setSelectedPayment(_i9.PaymentEntity? payment) => super.noSuchMethod(
        Invocation.method(
          #setSelectedPayment,
          [payment],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addListener(_i10.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(_i10.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [PageLoadingDialogStatus].
///
/// See the documentation for Mockito's code generation for more information.
class MockPageLoadingDialogStatus extends _i1.Mock
    implements _i3.PageLoadingDialogStatus {
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
