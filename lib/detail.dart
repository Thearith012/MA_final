import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailScreen extends StatelessWidget {
  final int data; // Product ID passed from the product list

  // Constructor to accept data (Product ID)
  const DetailScreen({super.key, required this.data});

  // Fetch product details based on the provided product ID
  Future<Map> _getProductDetail() async {
    // API call to get the product detail by ID
    var url = Uri.parse("https://fakestoreapi.com/products/$data");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      // Successfully fetched product data
      final productData = jsonDecode(response.body);
      return productData;
    } else {
      // Throw error if the API call fails
      throw Exception('Failed to load product details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<Map>(
              future: _getProductDetail(), // Fetch the data asynchronously
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                      strokeWidth: 5,
                    ),
                  ); // Loading spinner while fetching data
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(fontSize: 18, color: Colors.red),
                    ),
                  ); // Error handling
                } else if (snapshot.hasData && snapshot.data != null) {
                  // Display fetched product data
                  final product = snapshot.data!;
                  return SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          // Product Image
                          Image.network(
                            product['image'],
                            width: 300,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                      null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          // Product Title
                          Text(
                            product['title'],
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          // Product Description
                          Text(
                            product['description'],
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          // Product Price and Checkout Button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Total: ",
                                style: TextStyle(fontSize: 25),
                              ),
                              Text(
                                "\$${product['price']}",
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Checkout button action
                                  print("checkout");
                                },
                                child: const Text(
                                  "CheckOut",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  // Handle case where no data is available
                  return const Center(
                    child: Text("No product details available"),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
