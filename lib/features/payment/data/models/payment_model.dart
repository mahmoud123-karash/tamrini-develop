class PaymentModel {
  final String status;
  final String msg;

  PaymentModel({
    required this.status,
    required this.msg,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        status: json['status'] ?? '',
        msg: json['due'] ?? '',
      );
}
