class TransactionModel {
  final int? id;
  final int? amount;
  final DateTime? createdAt;
  final PaymentMethodModel? paymentMethod;
  final TransactionTypeModel? transcationType;

  TransactionModel({
    this.id,
    this.amount,
    this.createdAt,
    this.paymentMethod,
    this.transcationType,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json['id'],
        amount: json['amount'],
        createdAt: DateTime.tryParse(json['created_at']),
        paymentMethod: json['payment_method'] == null
            ? null
            : PaymentMethodModel.fromJson(
                json['payment_method'],
              ),
        transcationType: json['transaction_type'] == null
            ? null
            : TransactionTypeModel.fromJson(
                json['transaction_type'],
              ),
      );
}

class PaymentMethodModel {
  final int? id;
  final String? name;
  final String? code;
  final String? thumbnail;

  PaymentMethodModel({
    this.id,
    this.name,
    this.code,
    this.thumbnail,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      PaymentMethodModel(
        id: json['id'],
        name: json['name'],
        code: json['code'],
        thumbnail: json['thumbnail'],
      );
}

class TransactionTypeModel {
  final int? id;
  final String? name;
  final String? code;
  final String? action;
  final String? thumbnail;

  TransactionTypeModel({
    this.id,
    this.name,
    this.code,
    this.action,
    this.thumbnail,
  });

  factory TransactionTypeModel.fromJson(Map<String, dynamic> json) =>
      TransactionTypeModel(
        id: json['id'],
        name: json['name'],
        code: json['code'],
        action: json['action'],
        thumbnail: json['thumbnail'],
      );
}
