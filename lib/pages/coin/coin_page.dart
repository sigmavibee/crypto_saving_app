import 'package:auto_route/auto_route.dart';
import 'package:crypto_saving_app/app_router.dart';
import 'package:crypto_saving_app/services/coin_services.dart';
import 'package:crypto_saving_app/styles/colors.dart';
import 'package:flutter/material.dart';

import '../../models/coins.dart';

class CoinPage extends StatefulWidget {
  const CoinPage({super.key});

  @override
  State<CoinPage> createState() => _CoinPageState();
}

class _CoinPageState extends State<CoinPage> {
  bool _isLoading = true;
  List<Coins>? _coins;
  List<Coins>? _filteredCoins; // For search results
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _fetchCoins();
    _filteredCoins = _coins;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchCoins() async {
    try {
      // Simulate a network call
      _coins = await CoinService().fetchCoins();
      await Future.delayed(Duration(seconds: 2));
      _filteredCoins = _coins;
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

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        _filteredCoins = _coins; // Reset to show all coins
      }
    });
  }

  void _filterCoins(String query) {
    if (_coins == null) return;

    setState(() {
      _filteredCoins = _coins!.where((coin) {
        return coin.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
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
            onPressed: _toggleSearch,
          ),
        ],
      ),
      body: Column(
        children: [
          if (_isSearching)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search coins...',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      _filterCoins('');
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: _filterCoins,
              ),
            ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : (_filteredCoins == null || _filteredCoins!.isEmpty)
                    ? Center(
                        child: Text(_isSearching
                            ? 'No results found'
                            : 'No coins available'))
                    : ListView.builder(
                        itemCount: _filteredCoins!.length,
                        itemBuilder: (context, index) {
                          final coin = _filteredCoins![index];
                          return Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: ListTile(
                              title: Text(coin.name),
                              subtitle: Text(
                                  'Price: \$${coin.price.toStringAsFixed(2)}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      context.router.push(
                                          CoinBuyDetailsRoute(coinId: coin.id));
                                    },
                                    child: Text('Buy'),
                                  ),
                                  SizedBox(width: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      context.router.push(CoinSellDetailsRoute(
                                          coinId: coin.id));
                                    },
                                    child: Text('Sell'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
