import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String selectedSize = "Medium";
  Color selectedColor = Colors.pink;
  String imageAsset = 'assets/ice_cream_pink.png';
  int quantity = 1;
  double pricePerItem = 4.99;
  double totalPrice = 4.99;

  void updateColor(Color color, String asset) {
    setState(() {
      selectedColor = color;
      imageAsset = asset;
    });
  }

  void updateQuantity(bool increase) {
    setState(() {
      if (increase) {
        quantity++;
      } else {
        if (quantity > 1) {
          quantity--;
        }
      }
      totalPrice = quantity * pricePerItem;
    });
  }

  void addToCart() {
    // Data yang akan dikirim ke Summary
    List<Map<String, dynamic>> cartItems = [
      {
        'name': 'Ice Cream',
        'image': imageAsset,
        'quantity': quantity,
        'price': pricePerItem,
      }
    ];

    // Navigasi ke halaman Summary dengan membawa data
    Navigator.pushNamed(
      context,
      '/summary',
      arguments: {
        'cartItems': cartItems,
        'totalQuantity': quantity,
        'totalPrice': totalPrice.toInt(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pink.shade400,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Ice Cream",
          style: GoogleFonts.lora(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: selectedSize == "Small"
                        ? 120
                        : selectedSize == "Medium"
                            ? 180
                            : 240,
                    child: Image.asset(imageAsset),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.circle, color: Colors.grey, size: 10),
                      Icon(Icons.circle, color: selectedColor, size: 10),
                      const Icon(Icons.circle, color: Colors.grey, size: 10),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Delicious Ice Cream",
              style: GoogleFonts.lora(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Row(
              children: const [
                Icon(Icons.star, color: Colors.orange, size: 18),
                Text(" 4.8", style: TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "Enjoy the creamy, smooth, and delightful taste of our signature ice cream. Made with the finest ingredients for the perfect treat!",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            const Text("Size:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              children: [
                for (var size in ["Small", "Medium", "Large"])
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ChoiceChip(
                      label: Text(size),
                      selected: size == selectedSize,
                      onSelected: (selected) {
                        setState(() {
                          selectedSize = size;
                        });
                      },
                      selectedColor: Colors.pink,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            const Text("Flavor:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              children: [
                GestureDetector(
                  onTap: () => updateColor(Colors.brown, 'assets/ice_cream_brown.png'),
                  child: const CircleAvatar(backgroundColor: Colors.brown, radius: 10),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => updateColor(Colors.pink, 'assets/ice_cream_pink.png'),
                  child: const CircleAvatar(backgroundColor: Colors.pink, radius: 10),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => updateColor(Colors.grey, 'assets/ice cream.png'),
                  child: const CircleAvatar(backgroundColor: Colors.grey, radius: 10),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text("Quantity:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => updateQuantity(false),
                ),
                Text("$quantity", style: const TextStyle(fontSize: 18)),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => updateQuantity(true),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("\$${totalPrice.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.pink)),
                ElevatedButton(
                  onPressed: addToCart,
                  child: const Text("Add to Cart", style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
