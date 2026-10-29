import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'bakery_widgets.dart';
import 'products_data.dart';
// import 'details_page.dart';

class ProductsPage extends StatefulWidget {
  final String username;

  const ProductsPage({super.key, required this.username});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  int favorites = 0;
  double screenWidth = 0;
  String cartMessage = "";

  @override
  void initState() {
    super.initState();
    print("ProductsPage: initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final size = MediaQuery.sizeOf(context);
    screenWidth = size.width;
    print(
        "ProductsPage: didChangeDependencies -> width: ${size.width}, height: ${size.height}");
  }

  void addFavorite() {
    setState(() {
      favorites++;
    });
  }

  Future<void> openDetails(int index) async {
    // final result = await Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => DetailsPage(
    //       name: products[index]["name"],
    //       price: products[index]["price"],
    //     ),
    //   ),
    // );

    final name = Uri.encodeComponent(products[index]["name"]);
    final price = products[index]["price"];
    final result = await context.push<String>('/details/$name/$price');

    if (!mounted) return;

    if (result != null) {
      setState(() {
        cartMessage = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("ProductsPage: build");
    return Scaffold(
      appBar: AppBar(title: const Text("Sweet Crumbs")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome, ${widget.username}",
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.favorite, color: Colors.red, size: 18),
                    const SizedBox(width: 4),
                    Text("Favorites: $favorites"),
                    const Spacer(),
                    Text("Screen width: ${screenWidth.toStringAsFixed(0)}"),
                  ],
                ),
              ],
            ),
          ),
          if (cartMessage.isNotEmpty)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.brown.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.brown.shade700),
                  const SizedBox(width: 8),
                  Expanded(child: Text(cartMessage)),
                ],
              ),
            ),
          Expanded(
            child: screenWidth < 600
                ? ProductsListView(
              products: products,
              onFavoritePressed: addFavorite,
              onProductTap: openDetails,
            )
                : ProductsGridView(
              products: products,
              onFavoritePressed: addFavorite,
              onProductTap: openDetails,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void deactivate() {
    print("ProductsPage: deactivate");
    super.deactivate();
  }

  @override
  void dispose() {
    print("ProductsPage: dispose");
    super.dispose();
  }
}