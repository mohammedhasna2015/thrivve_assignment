import 'package:thrivve_assignment/features/withdraw/data/models/payment_model.dart';
import 'package:thrivve_assignment/features/withdraw/domain/entities/payment_entity.dart';

extension PaymentModelToEntity on PaymentModel {
  PaymentEntity toEntity() {
    return PaymentEntity(
      status: status,
      beneficiaryIban: beneficiaryIban,
      bankImage: bankImage,
      bankId: bankId,
      bankName: bankName,
    );
  }
}
