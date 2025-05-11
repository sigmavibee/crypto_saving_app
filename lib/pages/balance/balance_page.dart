import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class BalancePage extends StatefulWidget {
  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  final List<Map<String, String>> balances = [
    {
      "asset": "Bitcoin",
      "balance": "1.00",
      "current_price": "45000.00",
      "idr_value": "45000.0000"
    },
    {
      "asset": "Ethereum",
      "balance": "5.00",
      "current_price": "3000.50",
      "idr_value": "15002.5000"
    },
    {
      "asset": "Indonesian Rupiah (IDR)",
      "balance": "4000000.00",
      "current_price": "1.00",
      "idr_value": "4000000.0000"
    }
  ];

  final String totalIdr = "4060002.50";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Balance Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total IDR: Rp $totalIdr',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: balances.length,
                itemBuilder: (context, index) {
                  final balance = balances[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            balance['asset']!,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text('Balance: ${balance['balance']}'),
                          Text('Current Price: Rp ${balance['current_price']}'),
                          Text('IDR Value: Rp ${balance['idr_value']}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
