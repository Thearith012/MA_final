import 'dart:async'; // To use Timer for auto-scrolling
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Detail',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
      home: const ProductDetailPage(), // Start the app with ProductDetailPage
    );
  }
}

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> _images = [
    'PIC/shoes.png', // Replace with your image paths
    'PIC/shoes_1.png',
    'PIC/shoes_4.png',
    'PIC/shoes_2.png',
    'PIC/shoes_3.png',
    'PIC/shoes_5.png',
  ];

  @override
  void initState() {
    super.initState();
    _autoScroll();
  }

  void _autoScroll() {
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < _images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Back navigation
          },
        ),
        title: const Text('Product Detail'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image slider with PageView
            Center(
              child: SizedBox(
                height: 320,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _images.length,
                  onPageChanged: (int index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Image.asset(
                      _images[index],
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Dots Indicator
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_images.length, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 12 : 8,
                    height: _currentPage == index ? 12 : 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == index
                          ? Colors.blue
                          : Colors.grey,
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 10),
            Text(
              'Nike',
              style: GoogleFonts.roboto(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Flutter: Bubble tab indicator for TabBar. Using a Stack Widget and then adding elements to stack on different levels (stacking components like Tabs).',
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Amount',
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$25.00',
                      style: GoogleFonts.roboto(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    // Action for removing from the cart
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  child: const Text(
                    'REMOVE CART',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
