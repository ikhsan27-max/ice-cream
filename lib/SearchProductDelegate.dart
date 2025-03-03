import 'package:flutter/material.dart';

class SearchProductDelegate extends SearchDelegate<String> {
  // Data produk dengan format yang lebih konsisten
  final List<Map<String, String>> products = [
    {
      'name': 'Pistachio Chocolate Vanilla',
      'image': 'assets/ice cream.png',
      'price': 'Rp 20.000',
    },
    {
      'name': 'Cherry Strawberry',
      'image': 'assets/ice_cream_pink.png',
      'price': 'Rp 20.000',
    },
    {
      'name': 'Double Choc Hazelnut',
      'image': 'assets/ice_cream_brown.png',
      'price': 'Rp 23.000',
    },
  ];

  // Mengubah tema pencarian
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.pink[100],
        iconTheme: const IconThemeData(color: Colors.brown),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.brown),
      ),
      textTheme: theme.textTheme.copyWith(
        titleLarge: const TextStyle(
          color: Colors.brown,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  String get searchFieldLabel => 'Cari es krim favoritmu...';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildProductList(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildProductList(context);
  }

  Widget _buildProductList(BuildContext context) {
    final filteredProducts =
        products.where((product) {
          return product['name']!.toLowerCase().contains(query.toLowerCase());
        }).toList();

    if (filteredProducts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.icecream, size: 80, color: Colors.pink[200]),
            const SizedBox(height: 16),
            const Text(
              'Es krim tidak ditemukan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Coba kata kunci lain',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) {
          final product = filteredProducts[index];

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                "/details",
                arguments: {
                  'name': product['name'],
                  'image': product['image'],
                  'price': product['price'],
                },
              );
            },
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Container(
                        color: Colors.pink[50],
                        width: double.infinity,
                        child: Image.asset(
                          product['image']!,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['name']!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          product['price']!,
                          style: TextStyle(
                            color: Colors.pink[400],
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
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
