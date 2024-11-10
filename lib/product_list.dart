import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:badges/badges.dart' as badges;

import 'cart.dart';  // Import CartScreen
import 'detail.dart';  // Import DetailScreen
import 'sendDataToAPIServer.dart';  // Import API Screen for adding products

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  dynamic cartCount = 10; // Default cart count
  Future<List>? _myFuture;

  @override
  void initState() {
    super.initState();
    // Load data once
    _myFuture = _getProduct();
  }

  // Fetch product data from the API
  Future<List> _getProduct() async {
    var url = Uri.parse("https://fakestoreapi.com/products");  // API to fetch products
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
        actions: [
          // Add button to create a new product
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateProductScreen()),
                );
              },
              icon: const Icon(Icons.add_box),
            ),
          ),
          // Shopping cart icon with badge
          Padding(
            padding: const EdgeInsets.only(top: 16.0, right: 20, left: 20),
            child: InkWell(
              child: badges.Badge(
                badgeContent: Text(
                  "$cartCount",
                  style: const TextStyle(fontSize: 10, color: Colors.yellow),
                ),
                badgeStyle: badges.BadgeStyle(
                  shape: badges.BadgeShape.square,
                  badgeColor: Colors.purple,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.shopping_cart),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen(user_id: 1))
                );
              },
            ),
          ),
        ],
      ),
      body: FutureBuilder<List>(
          future: _myFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data == null) {
              return Center(
                child: ElevatedButton(
                  child: const Text("No record"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DetailScreen(data: 12),
                      ),
                    );
                  },
                ),
              );
            }

            if (snapshot.data != null) {
              var products = snapshot.data!;
              return GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of items per row
                  crossAxisSpacing: 10.0, // Horizontal spacing between grid items
                  mainAxisSpacing: 10.0, // Vertical spacing between grid items
                  childAspectRatio: 0.75, // Aspect ratio of grid items
                ),
                itemBuilder: (context, index) {
                  var product = products[index];

                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          // Product Image with InkWell to navigate to DetailScreen
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                        data: product['id']), // Passing product ID
                                  ),
                                );
                              },
                              child: Image.network(
                                product['image'],
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                          : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              product['title'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              "${product['price'].toString()} \$",
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Favorite icon button
                                IconButton(
                                  onPressed: () {
                                    print("Favorite");
                                  },
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.deepOrangeAccent,
                                  ),
                                ),
                                // Add to cart icon button
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      cartCount++;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.add_shopping_cart,
                                    color: Colors.orange,
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
              );
            }

            return const Text("No widget to build");
          }),
    );
  }
}
