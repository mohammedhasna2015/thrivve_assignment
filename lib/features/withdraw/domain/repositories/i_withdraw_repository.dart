import 'package:thrivve_assignment/features/withdraw/domain/entities/payment_entity.dart';
import 'package:thrivve_assignment/features/withdraw/domain/entities/withdraw_confirm_entity.dart';

abstract class IWithDrawRepository {
  Future<List<PaymentEntity>> listPayment();
  Future<WithdrawConfirmEntity> confirmWithDraw();
}
