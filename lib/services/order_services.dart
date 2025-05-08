// import 'dart:convert';

// import 'package:crypto_saving_app/models/orders.dart';
// import 'package:http/http.dart' as http;

// class OrderService {
//   Future<List<Transactions>> fetchOrders() async {
//     try {
//       final response = await http.get(Uri.parse('http://10.0.2.2:3000/coins'));

//       print('Response status: ${response.statusCode}');
//       print('Response body: ${response.body}');

//       if (response.statusCode == 200) {
//         final List<dynamic> data = jsonDecode(response.body);

//         // Parse the response into a list of Transactions
//         return data.map((coin) => Transactions.fromJson(coin)).toList();
//       } else {
//         throw Exception('Failed to fetch Transactions: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error in fetchTransactions: $e');
//       throw Exception('Failed to fetch Transactions: $e');
//     }
//   }

//   Future<List<Transactions>> fetchCoinsById(int id) async {
//     try {
//       final response =
//           await http.get(Uri.parse('http://10.0.2.2:3000/coins/$id'));

//       if (response.statusCode == 200) {
//         final dynamic data = jsonDecode(response.body);

//         // Handle both array and single object responses
//         if (data is List) {
//           return data.map((coin) => Transactions.fromJson(coin)).toList();
//         } else if (data is Map) {
//           return [Transactions.fromJson(data.cast<String, dynamic>())];
//         } else {
//           throw Exception('Unexpected response format');
//         }
//       } else {
//         throw Exception('Failed to fetch coins: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error in fetchCoinsById: $e');
//       throw Exception('Failed to fetch coins: $e');
//     }
//   }
// }
