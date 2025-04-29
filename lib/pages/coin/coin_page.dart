import 'package:auto_route/auto_route.dart';
import 'package:crypto_saving_app/services/coin_services.dart';
import 'package:crypto_saving_app/styles/colors.dart';
import 'package:flutter/material.dart';

import '../../app_router.dart';
import '../../models/coins.dart';

class CoinPage extends StatefulWidget {
  const CoinPage({super.key});

  @override
  State<CoinPage> createState() => _CoinPageState();
}

class _CoinPageState extends State<CoinPage> {
  bool _isLoading = true;
  List<Coins>? _coins;

  @override
  void initState() {
    super.initState();
    _fetchCoins();
  }

  Future<void> _fetchCoins() async {
    try {
      // Simulate a network call
      _coins = await CoinService().fetchCoins();
      await Future.delayed(Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to fetch coins: $e'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          });
      print('Failed to fetch coins: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Coin'),
        centerTitle: true,
        backgroundColor: kBgColor.withOpacity(0.5),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Add your search action here
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _coins?.length ?? 0,
              itemBuilder: (context, index) {
                final coin = _coins?[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(coin?.name ?? 'Unknown Coin'),
                    subtitle: Text(
                        'Price: \$${coin?.price.toStringAsFixed(2) ?? '0.00'}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            context.router
                                .push(CoinDetailsRoute(coinId: coin?.id ?? 0));
                          },
                          child: Text('Buy'),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            // Add sell action here
                          },
                          child: Text('Sell'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
