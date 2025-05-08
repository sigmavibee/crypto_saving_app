import 'package:crypto_saving_app/models/transactions.dart';
import 'package:crypto_saving_app/services/transactions_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user.dart';
import '../../services/auth_services.dart';
import '../../styles/colors.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  String _selectedOption = 'Buy';
  bool _isLoading = true;
  List<Transactions> _transactions = [];
  String _errorMessage = '';
  User? _user;
  int get userId => _user?.id ?? 0;

  // Cache for both buy and sell transactions
  final Map<String, List<Transactions>> _transactionCache = {
    'buy': [],
    'sell': [],
  };

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _fetchUser();
    if (userId != 0) {
      await _fetchAllTransactions();
    }
  }

  Future<void> _fetchUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('id');

      if (userId != null) {
        final user = await AuthService().getUser(int.parse(userId));
        setState(() {
          _user = user;
        });
      }
    } catch (e) {
      print('Error fetching user: $e');
    }
  }

  Future<void> _fetchAllTransactions() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      // Fetch all transactions at once
      final allTransactions =
          await TransactionsService().fetchTransactionsByUserId(userId);

      // Cache both buy and sell transactions
      _transactionCache['buy'] = allTransactions
          .where((t) => t.transactionType.toLowerCase() == 'buy')
          .toList();

      _transactionCache['sell'] = allTransactions
          .where((t) => t.transactionType.toLowerCase() == 'sell')
          .toList();

      // Set initial transactions based on selected option
      setState(() {
        _transactions = _transactionCache[_selectedOption.toLowerCase()] ?? [];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load transactions: $e';
      });
      print('Failed to fetch transactions: $e');
    }
  }

  void _updateTransactionType(String newValue) {
    setState(() {
      _selectedOption = newValue;
      _transactions = _transactionCache[newValue.toLowerCase()] ?? [];
    });
  }

  Future<void> _refreshData() async {
    if (userId != 0) {
      await _fetchAllTransactions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Orders'),
        backgroundColor: kBgColor.withOpacity(0.5),
      ),
      body: Column(
        children: [
          // Transaction type selector
          CupertinoSlidingSegmentedControl<String>(
            groupValue: _selectedOption,
            backgroundColor: kBgColor.withOpacity(0.5),
            children: {
              'Buy': const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Text('Buy'),
              ),
              'Sell': const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Text('Sell'),
              ),
            },
            onValueChanged: (String? newValue) {
              if (newValue != null) {
                _updateTransactionType(newValue);
              }
            },
            padding: const EdgeInsets.all(8.0),
          ),

          // Content area
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _errorMessage.isNotEmpty
                    ? Center(child: Text(_errorMessage))
                    : _transactions.isEmpty
                        ? const Center(child: Text('No transactions found'))
                        : RefreshIndicator(
                            onRefresh: _refreshData,
                            child: GridView.builder(
                              padding: const EdgeInsets.all(16.0),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16.0,
                                mainAxisSpacing: 16.0,
                                childAspectRatio: 2 / 3,
                              ),
                              itemCount: _transactions.length,
                              itemBuilder: (context, index) {
                                final transaction = _transactions[index];
                                return _buildTransactionCard(transaction);
                              },
                            ),
                          ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionCard(Transactions transaction) {
    return Container(
      decoration: BoxDecoration(
        color: transaction.transactionType.toLowerCase() == 'buy'
            ? Colors.green[700]
            : Colors.red[700],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  transaction.transactionDate,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            CircleAvatar(
              radius: 30.0,
              backgroundColor: Colors.white,
              child: Text(
                'ID: ${transaction.coinId}',
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              'Qty: ${transaction.quantity.toStringAsFixed(4)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Price: \$${transaction.pricePerCoin.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14.0,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              'Total: \$${transaction.totalAmount.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.greenAccent,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: () => _showTransactionDetails(transaction),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: const Text(
                'Details',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTransactionDetails(Transactions transaction) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Transaction #${transaction.id}'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Type: ${transaction.transactionType}'),
              Text('Coin ID: ${transaction.coinId}'),
              Text('Quantity: ${transaction.quantity.toStringAsFixed(8)}'),
              Text(
                  'Price per coin: \$${transaction.pricePerCoin.toStringAsFixed(2)}'),
              Text(
                  'Total amount: \$${transaction.totalAmount.toStringAsFixed(2)}'),
              Text('Date: ${transaction.transactionDate}'),
              if (transaction.notes.isNotEmpty)
                Text('Notes: ${transaction.notes}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
