import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:thrivve_assignment/features/withdraw/domain/entities/withdraw_confirm_entity.dart';
import 'package:thrivve_assignment/features/withdraw/domain/repositories/i_withdraw_repository.dart';
import 'package:thrivve_assignment/features/withdraw/domain/use_cases/withdraw_confrim_use_case.dart';

import 'withdraw_confirm_use_case_test.mocks.dart';

@GenerateMocks([IWithDrawRepository])
void main() {
  late MockIWithDrawRepository mockIWithDrawRepository;
  late IGetWithDrawUseCase getWithDrawUseCase;

  setUp(() {
    mockIWithDrawRepository = MockIWithDrawRepository();
    getWithDrawUseCase = GetWithDrawUseCase(mockIWithDrawRepository);
  });

  group('GetWithDrawUseCase', () {
    final result = WithdrawConfirmEntity(
      title: "Confirmed successfully",
      message: "Your payment request has been placed successfully.",
    );

    test('with draw confirm', () async {
      when(mockIWithDrawRepository.confirmWithDraw())
          .thenAnswer((_) async => result);

      final data = await getWithDrawUseCase.execute();

      expect(data, isA<WithdrawConfirmEntity>());
      expect(data.title, 'Confirmed successfully');
    });

    test('with draw confirm error ', () async {
      when(mockIWithDrawRepository.confirmWithDraw())
          .thenThrow(Exception('network error '));
      expect(
        () async => await getWithDrawUseCase.execute(),
        throwsA(isA<Exception>()),
      );

      verify(mockIWithDrawRepository.confirmWithDraw());
      verifyNoMoreInteractions(mockIWithDrawRepository);
    });
  });
}
