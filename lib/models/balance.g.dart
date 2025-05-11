// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BalanceResponse _$BalanceResponseFromJson(Map<String, dynamic> json) =>
    BalanceResponse(
      balances: (json['balances'] as List<dynamic>)
          .map((e) => Balance.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalIdr: json['total_idr'] as String,
    );

Map<String, dynamic> _$BalanceResponseToJson(BalanceResponse instance) =>
    <String, dynamic>{
      'balances': instance.balances,
      'total_idr': instance.totalIdr,
    };

Balance _$BalanceFromJson(Map<String, dynamic> json) => Balance(
      asset: json['asset'] as String,
      balance: json['balance'] as String,
      currentPrice: json['current_price'] as String,
      idrValue: json['idr_value'] as String,
    );

Map<String, dynamic> _$BalanceToJson(Balance instance) => <String, dynamic>{
      'asset': instance.asset,
      'balance': instance.balance,
      'current_price': instance.currentPrice,
      'idr_value': instance.idrValue,
    };
