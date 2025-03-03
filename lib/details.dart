import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:ui';

import 'package:taxi_booking/widgets/color.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> with SingleTickerProviderStateMixin {
  int quantity = 1;
  double pricePerItem = 20000;
  double totalPrice = 20000;
  String productName = "Pistachio Chocolate Vanilla";
  String imageAsset = 'assets/ice_cream.png';
  bool isFavorite = false;
  bool showNutrition = false;

  // Animation controller
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animations
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      setState(() {
        productName = args['name'] ?? productName;
        imageAsset = args['image'] ?? imageAsset;
        pricePerItem =
            double.tryParse(args['price'].toString()) ?? pricePerItem;
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

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite
              ? 'Added $productName to favorites!'
              : 'Removed $productName from favorites',
        ),
        backgroundColor: isFavorite ? Colors.pink[300] : Colors.grey[600],
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void addToCart() {
    // Add animation for button press
    _controller.reset();
    _controller.forward();

    // Show a success message
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              const Icon(Icons.check_circle, color: MyColor.primary),
              const SizedBox(width: 10),
              Text(
                "Added to Cart",
                style: GoogleFonts.lora(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$quantity x $productName", style: GoogleFonts.lora()),
              Text(
                "Total: ${formatCurrency(totalPrice)}",
                style: GoogleFonts.lora(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate to summary page
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
                      },
                    ],
                    'totalQuantity': quantity,
                    'totalPrice': totalPrice,
                  },
                );
              },
              child: const Text("View Cart"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Continue Shopping",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  String formatCurrency(double value) {
    return NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.black,
              ),
              onPressed: toggleFavorite,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background design
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.45,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imageAsset),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Main content
          SingleChildScrollView(
            child: Column(
              children: [
                // Empty space to account for the background image
                SizedBox(height: MediaQuery.of(context).size.height * 0.35),

                // Content card
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product name with animation
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.2),
                            end: Offset.zero,
                          ).animate(_controller),
                          child: Text(
                            productName,
                            style: GoogleFonts.poppins(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 5),

                      // Rating bar
                      Row(
                        children: [
                          ...List.generate(
                            5,
                            (index) => Icon(
                              index < 4 ? Icons.star : Icons.star_half,
                              color: Colors.amber,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "4.5",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "(128 reviews)",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Description
                      Text(
                        "Description",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        "Premium ice cream with a perfect blend of flavors. Thanks to its refreshing delicate taste and melt-in-your-mouth texture, it will appeal to big and small gourmets alike. Made with natural ingredients and no artificial preservatives.",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          height: 1.5,
                          color: Colors.black,
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Nutrition facts expandable section
                      InkWell(
                        onTap: () {
                          setState(() {
                            showNutrition = !showNutrition;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Nutrition Facts",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Icon(
                                showNutrition
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Expandable nutrition content
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: showNutrition ? 120 : 0,
                        padding: EdgeInsets.all(showNutrition ? 10 : 0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildNutritionItem("Calories", "240 kcal"),
                              _buildNutritionItem("Fat", "10g"),
                              _buildNutritionItem("Sugar", "24g"),
                              _buildNutritionItem("Protein", "4g"),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      // Price section with quantity controls
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Price",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                formatCurrency(pricePerItem),
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),

                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                _buildQuantityButton(
                                  Icons.remove,
                                  () => updateQuantity(false),
                                  quantity <= 1,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Text(
                                    "$quantity",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                _buildQuantityButton(
                                  Icons.add,
                                  () => updateQuantity(true),
                                  false,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      // Total price and add to cart button
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Price",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Text(
                                  formatCurrency(totalPrice),
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: ScaleTransition(
                              scale: _scaleAnimation,
                              child: ElevatedButton.icon(
                                onPressed: addToCart,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.pinkAccent,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 3,
                                ),
                                icon: const Icon(Icons.shopping_cart),
                                label: Text(
                                  "Add to Cart",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Floating ice cream image
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            left: 0,
            right: 0,
            child: Hero(
              tag: 'product_${productName.replaceAll(" ", "_")}',
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Center(
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 15,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(imageAsset),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionItem(String name, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700]),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(
    IconData icon,
    VoidCallback onPressed,
    bool disabled,
  ) {
    return GestureDetector(
      onTap: disabled ? null : onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: disabled ? Colors.grey[200] : Colors.pinkAccent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: disabled ? Colors.grey[400] : Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
