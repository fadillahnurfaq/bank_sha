// ignore_for_file: public_member_api_docs, sort_constructors_first
class OperatorCardModel {
  final int? id;
  final String? name;
  final String? status;
  final String? thumbnail;
  final List<DataPlanModel>? dataPlans;

  OperatorCardModel({
    this.id,
    this.name,
    this.status,
    this.thumbnail,
    this.dataPlans,
  });

  factory OperatorCardModel.fromJson(Map<String, dynamic> json) =>
      OperatorCardModel(
        id: json['id'],
        name: json['name'],
        status: json['status'],
        thumbnail: json['thumbnail'],
        dataPlans: json['data_plans'].isEmpty
            ? null
            : (json['data_plans'] as List)
                .map(
                  (dataPlan) => DataPlanModel.fromJson(dataPlan),
                )
                .toList(),
      );

  @override
  String toString() {
    return 'OperatorCardModel(id: $id, name: $name, status: $status, thumbnail: $thumbnail, dataPlans: $dataPlans)';
  }
}

class DataPlanModel {
  final int? id;
  final String? name;
  final int? price;
  final int? operatorCardId;

  DataPlanModel({
    this.id,
    this.name,
    this.price,
    this.operatorCardId,
  });

  factory DataPlanModel.fromJson(Map<String, dynamic> json) => DataPlanModel(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        operatorCardId: json['operator_card_id'],
      );

  @override
  String toString() {
    return 'DataPlanModel(id: $id, name: $name, price: $price, operatorCardId: $operatorCardId)';
  }
}
