import 'package:thrivve_assignment/features/withdraw/data/models/payment_model.dart';
import 'package:thrivve_assignment/features/withdraw/data/models/withdraw_confirm_model.dart';

abstract class IWithdrawDataSource {
  Future<List<PaymentModel>> listPayment();
  Future<WithdrawConfirmModel> confirmWithDraw();
}
