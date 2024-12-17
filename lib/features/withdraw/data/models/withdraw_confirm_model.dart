import 'dart:convert';

/// title : "Confirmed successfully"
/// message : "Your payment request has been placed successfully. We will notify you once the payment has been sent to your account."

WithdrawConfirmModel withdrawConfirmModelFromJson(String str) =>
    WithdrawConfirmModel.fromJson(json.decode(str));
String withdrawConfirmModelToJson(WithdrawConfirmModel data) =>
    json.encode(data.toJson());

class WithdrawConfirmModel {
  WithdrawConfirmModel({
    String? title,
    String? message,
  }) {
    _title = title;
    _message = message;
  }

  WithdrawConfirmModel.fromJson(dynamic json) {
    _title = json['title'];
    _message = json['message'];
  }
  String? _title;
  String? _message;
  WithdrawConfirmModel copyWith({
    String? title,
    String? message,
  }) =>
      WithdrawConfirmModel(
        title: title ?? _title,
        message: message ?? _message,
      );
  String? get title => _title;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['message'] = _message;
    return map;
  }
}
