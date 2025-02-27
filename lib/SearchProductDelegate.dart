import 'package:flutter/material.dart';

class SearchProductDelegate extends SearchDelegate<String> {
  final List<Map<String, String>> products = [
    {'name': 'Pistachio Chocolate Vanilla', 'image': 'assets/ice cream.png', 'price': 'Rp 20.000'},
    {'name': 'Cherry Strawberry', 'image': 'assets/ice_cream_pink.png', 'price': 'Rp 20.000'},
    {'name': 'Double Choc Hazelnut', 'image': 'assets/ice_cream_brown.png', 'price': 'Rp 23.000'},
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
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
    final filteredProducts = products.where((product) {
      return product['name']!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final product = filteredProducts[index];

        return ListTile(
          leading: Image.asset(product['image']!, width: 50, height: 50),
          title: Text(product['name']!),
          subtitle: Text(product['price']!),
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
        );
      },
    );
  }
}
