import 'package:json_annotation/json_annotation.dart';

part 'balance.g.dart';

@JsonSerializable()
class BalanceResponse {
  final List<Balance> balances;
  @JsonKey(name: 'total_idr')
  final String totalIdr;

  BalanceResponse({
    required this.balances,
    required this.totalIdr,
  });

  factory BalanceResponse.fromJson(Map<String, dynamic> json) =>
      _$BalanceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BalanceResponseToJson(this);
}

@JsonSerializable()
class Balance {
  final String asset;
  final String balance;
  @JsonKey(name: 'current_price')
  final String currentPrice;
  @JsonKey(name: 'idr_value')
  final String idrValue;

  Balance({
    required this.asset,
    required this.balance,
    required this.currentPrice,
    required this.idrValue,
  });

  factory Balance.fromJson(Map<String, dynamic> json) =>
      _$BalanceFromJson(json);

  Map<String, dynamic> toJson() => _$BalanceToJson(this);
}
