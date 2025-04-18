import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  String _selectedOption = 'Buy';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: Column(
        children: [
          // Dropdown button to select between "Buy" and "NFT"
          DropdownButton<String>(
            value: _selectedOption,
            items: <String>['Buy', 'Sell'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedOption = newValue!;
              });
            },
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 16.0, // Spacing between columns
                mainAxisSpacing: 16.0, // Spacing between rows
                childAspectRatio: 2 / 3, // Aspect ratio of each container
              ),
              itemCount: 50, // Number of items
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: _selectedOption == 'Buy'
                        ? Colors.green[700]
                        : Colors.red[
                            700], // Background color changes based on dropdown
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${DateTime.now().toLocal().toString().split(' ')[0]}', // Current date
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12.0,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.white,
                          child: Text(
                            'BTC',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          'Quantity: ${index + 1}', // Example quantity
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Total: \$${(index + 1) * 100}', // Example total price
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12.0),
                        ElevatedButton(
                          onPressed: () {
                            // Add action for button
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: Text(
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
