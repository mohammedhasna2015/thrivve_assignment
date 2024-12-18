import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:thrivve_assignment/features/withdraw/data/data_soruces/i_withdraw_datasource.dart';
import 'package:thrivve_assignment/features/withdraw/data/models/payment_model.dart';
import 'package:thrivve_assignment/features/withdraw/data/models/withdraw_confirm_model.dart';
import 'package:thrivve_assignment/features/withdraw/domain/entities/payment_entity.dart';
import 'package:thrivve_assignment/features/withdraw/domain/entities/withdraw_confirm_entity.dart';
import 'package:thrivve_assignment/features/withdraw/domain/repositories/withdraw_repository.dart';

import 'withdraw_repository_test.mocks.dart';

// Generate mocks for the IWithdrawDataSource class
@GenerateMocks([
  IWithdrawDataSource,
])
Future<void> main() async {
  late MockIWithdrawDataSource mockWithdrawDataSource;
  late WithdrawRepository repository;

  setUp(() {
    mockWithdrawDataSource = MockIWithdrawDataSource();
    repository = WithdrawRepository(mockWithdrawDataSource);
  });

  group('WithdrawRepository', () {
    group('withdrawConfirm', () {
      test(
          'should return WithdrawConfirmEntity when execute withdraw successfully',
          () async {
        final resultModel = WithdrawConfirmModel(
          title: "Confirmed successfully",
          message: "Your payment request has been placed successfully.",
        );

        // Correctly setting up the mock using 'when' on the method
        when(mockWithdrawDataSource.confirmWithDraw()).thenAnswer(
          (_) async => resultModel, // Simulate the Future return
        );

        // Act: Call the repository method
        final value = await repository.confirmWithDraw();

        // Assert: Check that the returned value is a WithdrawConfirmEntity
        expect(value, isA<WithdrawConfirmEntity>());
        expect(value, isNotNull);
        expect(value.title, 'Confirmed successfully');

        // Verify that confirmWithDraw was called once
        verify(mockWithdrawDataSource.confirmWithDraw()).called(1);
        verifyNoMoreInteractions(mockWithdrawDataSource);
      });

      test(
        'should throw ApiException when remote data source fails with ApiException',
        () async {
          when(mockWithdrawDataSource.confirmWithDraw())
              .thenThrow(Exception('unknown error'));

          expect(
            () async => await repository.confirmWithDraw(),
            throwsA(isA<Exception>()),
          );

          verify(mockWithdrawDataSource.confirmWithDraw());
          verifyNoMoreInteractions(mockWithdrawDataSource);
        },
      );
    });

    group('list payment', () {
      test(
          'should return WithdrawConfirmEntity when execute withdraw successfully',
          () async {
        final resultJson = [
          {
            "status": "In-Review",
            "beneficiary_iban": "GB29NWBK60161331926819",
            "bank_image":
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRn_bhPgvIrnWNmBgZz5YYe5rjflSYjf9WhEDa_Ia0&s",
            "bank_id": 4,
            "bank_name": "Al Rajhi"
          },
          {
            "status": null,
            "beneficiary_iban": "AR29NWBK60161331926820",
            "bank_image":
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRn_bhPgvIrnWNmBgZz5YYe5rjflSYjf9WhEDa_Ia0&s",
            "bank_id": 4,
            "bank_name": "Al Arabi"
          }
        ];

        // Correctly setting up the mock using 'when' on the method
        when(mockWithdrawDataSource.listPayment()).thenAnswer(
          (_) async =>
              ListPaymentModel(resultJson), // Simulate the Future return
        );

        // Act: Call the repository method
        final value = await repository.listPayment();

        // Assert: Check that the returned value is a WithdrawConfirmEntity
        expect(value, isA<List<PaymentEntity>>());
        expect(value, isNotEmpty);
        expect(value.length, 2);
        expect(value[0].bankId, 4);
        expect(value[1].bankName, 'Al Arabi');

        // Verify that confirmWithDraw was called once
        verify(mockWithdrawDataSource.listPayment()).called(1);
        verifyNoMoreInteractions(mockWithdrawDataSource);
      });

      test(
        'should throw ApiException when remote data source fails with ApiException',
        () async {
          when(mockWithdrawDataSource.confirmWithDraw())
              .thenThrow(Exception('unknown error'));

          expect(
            () async => await repository.confirmWithDraw(),
            throwsA(isA<Exception>()),
          );

          verify(mockWithdrawDataSource.confirmWithDraw());
          verifyNoMoreInteractions(mockWithdrawDataSource);
        },
      );
    });
  });
}
