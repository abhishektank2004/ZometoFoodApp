import 'package:flutter/material.dart';
import 'payment_page.dart'; // Import the new file for payment page

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const CartPage({Key? key, required this.cartItems}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void _removeItem(int index) {
    setState(() {
      widget.cartItems.removeAt(index);
    });
  }

  // Method to calculate total price
  double _calculateTotalPrice() {
    double total = 0.0;
    for (var item in widget.cartItems) {
      // Check if the price is properly formatted and not null
      final priceString = item['price']?.replaceAll('₹', '').trim();
      if (priceString != null && priceString.isNotEmpty) {
        final price = double.tryParse(priceString) ?? 0.0;
        total += price;
      }
    }
    return total;
  }


  // Method to handle payment
  void _proceedToPayment() {
    final totalPrice = _calculateTotalPrice();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(totalAmount: totalPrice),
      ),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    final totalPrice = _calculateTotalPrice();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: const Text(
          'Your Cart',
          style: TextStyle(fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: widget.cartItems.isEmpty
          ? const Center(
        child: Text(
          'Your cart is empty',
          style: TextStyle(fontSize: 24),
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final item = widget.cartItems[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 4.0,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      title: Text(
                        item['title'] ?? 'No Title',
                        style: const TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(
                        item['subtitle'] ?? 'No Subtitle',
                        style: const TextStyle(fontSize: 16),
                      ),
                      trailing: Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        alignment: WrapAlignment.end,
                        children: [
                          Text(
                            item['price'] ?? 'No Price',
                            style: const TextStyle(fontSize: 18),
                          ),
                          ElevatedButton(
                            onPressed: () => _removeItem(index),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text(
                              'Remove',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Price:',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '₹${totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: ElevatedButton(
              onPressed: _proceedToPayment,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // Background color
                foregroundColor: Colors.white, // Text color
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text(
                'Proceed to Payment',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
