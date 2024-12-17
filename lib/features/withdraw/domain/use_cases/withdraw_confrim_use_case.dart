import 'package:thrivve_assignment/core/base/usecase/i_usecase.dart';
import 'package:thrivve_assignment/features/withdraw/domain/entities/withdraw_confirm_entity.dart';
import 'package:thrivve_assignment/features/withdraw/domain/repositories/i_withdraw_repository.dart';

abstract class IGetWithDrawUseCase extends IUseCase<WithdrawConfirmEntity> {}

class GetWithDrawUseCase extends IGetWithDrawUseCase {
  GetWithDrawUseCase(this._repository);
  final IWithDrawRepository _repository;

  @override
  Future<WithdrawConfirmEntity> execute() async {
    return await _repository.confirmWithDraw();
  }
}
