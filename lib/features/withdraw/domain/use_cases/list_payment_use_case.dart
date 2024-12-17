import 'package:thrivve_assignment/core/base/usecase/i_usecase.dart';
import 'package:thrivve_assignment/features/withdraw/domain/entities/payment_entity.dart';
import 'package:thrivve_assignment/features/withdraw/domain/repositories/i_withdraw_repository.dart';

abstract class IGetPaymentListUseCase extends IUseCase<List<PaymentEntity>> {}

class GetPaymentListUseCase extends IGetPaymentListUseCase {
  GetPaymentListUseCase(this._repository);
  final IWithDrawRepository _repository;

  @override
  Future<List<PaymentEntity>> execute() async {
    return await _repository.listPayment();
  }
}
