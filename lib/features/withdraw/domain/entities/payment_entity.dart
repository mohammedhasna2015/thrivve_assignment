class PaymentEntity {
  final String? status;
  final String? beneficiaryIban;
  final String? bankImage;
  final int? bankId;
  final String? bankName;

  PaymentEntity({
    this.status,
    this.beneficiaryIban,
    this.bankImage,
    this.bankId,
    this.bankName,
  });
}
