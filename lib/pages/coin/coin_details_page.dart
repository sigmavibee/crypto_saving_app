import 'package:auto_route/auto_route.dart';
import 'package:crypto_saving_app/styles/colors.dart';
import 'package:flutter/material.dart';
import '../../models/coins.dart';
import '../../services/coin_services.dart';

@RoutePage()
class CoinDetailsPage extends StatefulWidget {
  final int coinId; // Add this parameter

  const CoinDetailsPage({
    super.key,
    required this.coinId, // Make it required
  });

  @override
  State<CoinDetailsPage> createState() => _CoinDetailsPageState();
}

class _CoinDetailsPageState extends State<CoinDetailsPage> {
  bool _isLoading = true;
  Coins? _coin; // Change from List<Coins> to single Coins

  @override
  void initState() {
    super.initState();
    _fetchCoinsById();
  }

  Future<void> _fetchCoinsById() async {
    try {
      _coin = (await CoinService().fetchCoinsById(widget.coinId))
          .first; // Get first coin from list
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to fetch coin details: $e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      print('Failed to fetch coin details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_coin == null) {
      return Center(child: Text('Coin not found'));
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: kBgColor.withOpacity(0.5),
        title: Text(
          'Coin Details',
          style: TextStyle(color: kBlack, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: kBgColor.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.monetization_on,
                    size: 60,
                    color: kBlack.withOpacity(0.8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  '${_coin?.name} ', // Add symbol if you have it
                  style: TextStyle(
                    color: kBlack,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _coin?.description ?? 'No description available',
                style: TextStyle(
                  color: kBlack.withOpacity(0.7),
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Current Price:',
                    style: TextStyle(
                      color: kBlack,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '\$${_coin?.price.toString() ?? '0.00'}',
                    style: TextStyle(
                      color: kBlack,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24),
              // Simple Calculator
              Text(
                'Buy Calculator',
                style: TextStyle(
                  color: kBlack,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: kBlack),
                      decoration: InputDecoration(
                        hintText: 'Enter amount',
                        hintStyle: TextStyle(color: kBlack.withOpacity(0.5)),
                        filled: true,
                        fillColor: kBgColor.withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        // Handle input change
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      // Handle buy action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kTreeGreen,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                    ),
                    child: Text(
                      'Buy',
                      style: TextStyle(
                        color: kBlack,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
