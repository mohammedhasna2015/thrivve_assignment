import 'dart:convert';

/// status : "In-Review"
/// beneficiary_iban : "GB29NWBK60161331926819"
/// bank_image : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRn_bhPgvIrnWNmBgZz5YYe5rjflSYjf9WhEDa_Ia0&s"
/// bank_id : 4
/// bank_name : "Al Rajhi"

List<PaymentModel> ListPaymentModel(List json) =>
    List<PaymentModel>.from(json.map((x) => PaymentModel.fromJson(x)));

PaymentModel PaymentModelFromJson(String str) =>
    PaymentModel.fromJson(json.decode(str));
String listPaymentModelToJson(PaymentModel data) => json.encode(data.toJson());

class PaymentModel {
  PaymentModel({
    String? status,
    String? beneficiaryIban,
    String? bankImage,
    int? bankId,
    String? bankName,
  }) {
    _status = status;
    _beneficiaryIban = beneficiaryIban;
    _bankImage = bankImage;
    _bankId = bankId;
    _bankName = bankName;
  }

  PaymentModel.fromJson(dynamic json) {
    _status = json['status'];
    _beneficiaryIban = json['beneficiary_iban'];
    _bankImage = json['bank_image'];
    _bankId = json['bank_id'];
    _bankName = json['bank_name'];
  }
  String? _status;
  String? _beneficiaryIban;
  String? _bankImage;
  int? _bankId;
  String? _bankName;
  PaymentModel copyWith({
    String? status,
    String? beneficiaryIban,
    String? bankImage,
    int? bankId,
    String? bankName,
  }) =>
      PaymentModel(
        status: status ?? _status,
        beneficiaryIban: beneficiaryIban ?? _beneficiaryIban,
        bankImage: bankImage ?? _bankImage,
        bankId: bankId ?? _bankId,
        bankName: bankName ?? _bankName,
      );
  String? get status => _status;
  String? get beneficiaryIban => _beneficiaryIban;
  String? get bankImage => _bankImage;
  int? get bankId => _bankId;
  String? get bankName => _bankName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['beneficiary_iban'] = _beneficiaryIban;
    map['bank_image'] = _bankImage;
    map['bank_id'] = _bankId;
    map['bank_name'] = _bankName;
    return map;
  }
}
