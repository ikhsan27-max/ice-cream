import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int quantity = 1;
  double pricePerItem = 20000;
  double totalPrice = 20000;
  String productName = "Pistachio Chocolate Vanilla";
  String imageAsset = 'assets/ice_cream.png';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      setState(() {
        productName = args['name'] ?? productName;
        imageAsset = args['image'] ?? imageAsset;
        pricePerItem = double.tryParse(args['price'].toString()) ?? pricePerItem;
        totalPrice = pricePerItem * quantity;
      });
    }
  }

  void updateQuantity(bool increase) {
    setState(() {
      if (increase) {
        quantity++;
      } else if (quantity > 1) {
        quantity--;
      }
      totalPrice = quantity * pricePerItem;
    });
  }

  void addToCart() {
    Navigator.pushNamed(
      context,
      '/summary',
      arguments: {
        'cartItems': [
          {
            'name': productName,
            'image': imageAsset,
            'quantity': quantity,
            'price': pricePerItem,
          }
        ],
        'totalQuantity': quantity,
        'totalPrice': totalPrice,
      },
    );
  }

  String formatCurrency(double value) {
    return NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 350,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imageAsset),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 10,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black, size: 25),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: GoogleFonts.lora(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Image.asset(imageAsset, height: 100),
                  const SizedBox(height: 5),
                  Text(
                    productName,
                    style: GoogleFonts.lora(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Thanks to its refreshing delicate taste and melt-in-your-mouth texture, it will appeal to big and small gourmets.",
                    style: GoogleFonts.lora(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    formatCurrency(totalPrice),
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      IconButton(icon: const Icon(Icons.remove), onPressed: () => updateQuantity(false)),
                      Text("$quantity", style: const TextStyle(fontSize: 18)),
                      IconButton(icon: const Icon(Icons.add), onPressed: () => updateQuantity(true)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: addToCart,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text("Add to Cart", style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
