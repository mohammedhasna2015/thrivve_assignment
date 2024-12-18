import 'package:thrivve_assignment/core/base/base_response_parser.dart';
import 'package:thrivve_assignment/features/withdraw/data/data_soruces/i_withdraw_datasource.dart';
import 'package:thrivve_assignment/features/withdraw/data/models/payment_model.dart';
import 'package:thrivve_assignment/features/withdraw/data/models/withdraw_confirm_model.dart';
import 'package:thrivve_assignment/features/withdraw/data/services/withdraw_service.dart';

class WithdrawDataSource extends BaseDataSource implements IWithdrawDataSource {
  final WithdrawService _withdrawService;

  WithdrawDataSource(this._withdrawService);

  @override
  Future<WithdrawConfirmModel> confirmWithDraw() async {
    return await executeRequest<WithdrawConfirmModel>(
      request: _withdrawService.confirmWithDraw,
      parser: (json) =>
          WithdrawConfirmModel.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<List<PaymentModel>> listPayment() async {
    return await executeRequest<List<PaymentModel>>(
      request: _withdrawService.listPayment,
      parser: (json) => ListPaymentModel(json as List<dynamic>),
    );
  }
}
