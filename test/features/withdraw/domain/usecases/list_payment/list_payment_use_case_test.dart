import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:thrivve_assignment/features/withdraw/domain/entities/payment_entity.dart';
import 'package:thrivve_assignment/features/withdraw/domain/repositories/i_withdraw_repository.dart';
import 'package:thrivve_assignment/features/withdraw/domain/use_cases/list_payment_use_case.dart';

import 'list_payment_use_case_test.mocks.dart';

@GenerateMocks([IWithDrawRepository])
void main() {
  late MockIWithDrawRepository mockIWithDrawRepository;
  late IGetPaymentListUseCase getPaymentListUseCase;

  setUp(() {
    mockIWithDrawRepository = MockIWithDrawRepository();
    getPaymentListUseCase = GetPaymentListUseCase(mockIWithDrawRepository);
  });

  group('GetWithDrawUseCase', () {
    final result = [
      PaymentEntity(
        status: 'in review',
        bankId: 1,
        bankImage: '4',
        bankName: 'test1',
      ),
      PaymentEntity(
        status: null,
        bankId: 2,
        bankImage: '3',
        bankName: 'test2',
      ),
    ];

    test('with draw confirm', () async {
      when(mockIWithDrawRepository.listPayment())
          .thenAnswer((_) async => result);

      final data = await getPaymentListUseCase.execute();

      expect(data, isA<List<PaymentEntity>>());
      expect(data.length, 2);
      expect(data[0].bankId, 1);
    });

    test('with draw confirm error ', () async {
      when(mockIWithDrawRepository.listPayment())
          .thenThrow(Exception('network error '));
      expect(
        () async => await getPaymentListUseCase.execute(),
        throwsA(isA<Exception>()),
      );

      verify(mockIWithDrawRepository.listPayment());
      verifyNoMoreInteractions(mockIWithDrawRepository);
    });
  });
}
