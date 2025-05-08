// class Transactions {
//   final int id;
//   final int userId;
//   final int coinId;
//   final double quantity;
//   final double pricePerCoin;
//   final double totalAmount;
//   final String transactionType; // "buy" or "sell"
//   final DateTime transactionDate;
//   final String notes;

//   Transactions({
//     required this.id,
//     required this.userId,
//     required this.coinId,
//     required this.quantity,
//     required this.pricePerCoin,
//     required this.totalAmount,
//     required this.transactionType,
//     required this.transactionDate,
//     required this.notes,
//   });

//   factory Transactions.fromJson(Map<String, dynamic> json) {
//     return Transactions(
//       id: json['id'] as int,
//       userId: json['user_id'] as int,
//       coinId: json['coin_id'] as int,
//       quantity: double.tryParse(json['quantity'] as String) ?? 0.0,
//       pricePerCoin: double.tryParse(json['price_per_coin'] as String) ?? 0.0,
//       totalAmount: double.tryParse(json['total_amount'] as String) ?? 0.0,
//       transactionType: json['transaction_type'] as String,
//       transactionDate: DateTime.parse(json['transaction_date'] as String),
//       notes: json['notes'] as String? ?? 'No notes available',
//     );
//   }
// }
