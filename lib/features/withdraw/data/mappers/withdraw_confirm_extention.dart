import 'package:thrivve_assignment/features/withdraw/data/models/withdraw_confirm_model.dart';
import 'package:thrivve_assignment/features/withdraw/domain/entities/withdraw_confirm_entity.dart';

extension WithdrawConfirmModelToEntity on WithdrawConfirmModel {
  WithdrawConfirmEntity toEntity() {
    return WithdrawConfirmEntity(
      title: title,
      message: message,
    );
  }
}
