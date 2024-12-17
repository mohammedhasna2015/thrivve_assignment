import 'package:thrivve_assignment/features/withdraw/data/data_soruces/i_withdraw_datasource.dart';
import 'package:thrivve_assignment/features/withdraw/data/models/payment_model.dart';
import 'package:thrivve_assignment/features/withdraw/data/models/withdraw_confirm_model.dart';
import 'package:thrivve_assignment/features/withdraw/data/services/withdraw_service.dart';

class WithdrawDatawSource extends IWithdrawDataSource {
  final WithdrawService _withdrawService;

  WithdrawDatawSource(this._withdrawService);

  @override
  Future<WithdrawConfirmModel> confirmWithDraw() async {
    final result = await _withdrawService.confirmWithDraw();
    return WithdrawConfirmModel.fromJson(result.body);
  }

  @override
  Future<List<PaymentModel>> listPayment() async {
    final result = await _withdrawService.listPayment();
    return ListPaymentModel(result.body);
  }
}
