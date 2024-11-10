
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

import 'detail.dart';
import 'product_list.dart';

void main() {
  runApp( const HomeScreen());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Dashboard(),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(onPressed:(){}, icon: const Icon(Icons.point_of_sale_outlined)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 10, top: 10),
              child: badges.Badge(
                badgeContent: const Text(
                  "50",
                  style: TextStyle(fontSize: 10, color: Colors.yellow),
                ),
                badgeStyle: badges.BadgeStyle(
                  badgeColor: Colors.purple,
                  padding: const EdgeInsets.all(5),
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white, width: 1),
                  elevation: 10,
                ),
                onTap: () {
                },
                child: const Icon(Icons.notifications),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: [
              const UserAccountsDrawerHeader(
                  accountName: Text(
                    "Thearith",
                  ),
                  accountEmail: Text("rith@gmail.com"),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                        "https://portfolio-blue-eight-13.vercel.app/davuth.jpg"),
                  )),
              ListTile(
                leading: const Icon(
                  Icons.line_style,
                  size: 50,
                ),
                title:
                const Text("Product List", style: TextStyle(fontSize: 18)),
                subtitle: const Text("display all product item..."),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const ProductList()));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.manage_accounts,
                  size: 50,
                ),
                title: const Text("Profile", style: TextStyle(fontSize: 18)),
                subtitle: const Text("view or edit your profile"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DetailScreen(data: 1)));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.contact_page,
                  size: 50,
                ),
                title: const Text(
                  "Contact Us",
                  style: TextStyle(fontSize: 18),
                ),
                subtitle: const Text("contact our team while issue"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DetailScreen(data: 1)));
                },
              ),
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Version 1.0",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: const Card(
                        child: SizedBox(
                          height: 100,
                          child: Column(
                            children: [
                              Icon(
                                Icons.point_of_sale,
                                size: 70,
                                color: Colors.greenAccent,
                              ),
                              Text(
                                "POINT OF SALE",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProductList()),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InkWell(
                      child: const Card(
                        child: SizedBox(
                          height: 100,
                          child: Column(
                            children: [
                              Icon(
                                Icons.list_alt,
                                size: 70,
                                color: Colors.lightBlue,
                              ),
                              Text(
                                "Product List",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductList()));
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}
