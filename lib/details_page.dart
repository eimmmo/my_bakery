import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'bakery_widgets.dart';
import 'products_data.dart';

class DetailsPage extends StatefulWidget {
  final String name;
  final int price;

  const DetailsPage({super.key, required this.name, required this.price});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();
    print("DetailsPage: initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("DetailsPage: didChangeDependencies");
  }

  @override
  Widget build(BuildContext context) {
    print("DetailsPage: build");

    Map<String, dynamic> product = products.firstWhere(
          (p) => p["name"] == widget.name,
      orElse: () => {"image": "", "description": ""},
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Product Details")),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    height: 280,
                    width: double.infinity,
                    child: ProductImage(path: product["image"]),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.name,
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  'EGP ${widget.price}',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.brown.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  product["description"],
                  style: const TextStyle(fontSize: 15, height: 1.5),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text("Add to Cart"),
                    onPressed: () {
                      // Navigator.pop(context, "${widget.name} added to cart");

                      context.pop("${widget.name} added to cart");
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void deactivate() {
    print("DetailsPage: deactivate");
    super.deactivate();
  }

  @override
  void dispose() {
    print("DetailsPage: dispose");
    super.dispose();
  }
}