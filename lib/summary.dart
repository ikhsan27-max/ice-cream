import 'package:flutter/material.dart';

class Summary extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final int totalQuantity;
  final int totalPrice;

  // Constructor untuk menerima data dari main.dart
  const Summary({
    super.key,
    required this.cartItems,
    required this.totalQuantity,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Summary"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  var item = cartItems[index];

                  return Card(
                    child: ListTile(
                      leading: (item['image'] != null && item['image'].isNotEmpty)
                          ? Image.asset(item['image'], width: 50, height: 50, fit: BoxFit.cover)
                          : const Icon(Icons.image_not_supported, size: 50),
                      title: Text(item['name'] ?? "Unknown Item"),
                      subtitle: Text("Quantity: ${item['quantity']}"),
                      trailing: Text("\$${(item['quantity'] ?? 0) * (item['price'] ?? 0)}"),
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            Text(
              "Total Items: $totalQuantity",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "Total Price: \$$totalPrice",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Back"),
            ),
          ],
        ),
      ),
    );
  }
}
