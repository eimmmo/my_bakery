import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String path;

  const ProductImage({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.brown.shade100,
          child: const Center(
            child: Icon(Icons.bakery_dining, size: 40, color: Colors.brown),
          ),
        );
      },
    );
  }
}

class ProductsListView extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final void Function() onFavoritePressed;
  final void Function(int index) onProductTap;

  const ProductsListView({
    super.key,
    required this.products,
    required this.onFavoritePressed,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductListCard(
          product: products[index],
          onFavoritePressed: onFavoritePressed,
          onTap: () {
            onProductTap(index);
          },
        );
      },
    );
  }
}

class ProductsGridView extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final void Function() onFavoritePressed;
  final void Function(int index) onProductTap;

  const ProductsGridView({
    super.key,
    required this.products,
    required this.onFavoritePressed,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    int columns = (width / 260).floor();
    if (columns < 2) {
      columns = 2;
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        childAspectRatio: 0.78,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        return ProductGridCard(
          product: products[index],
          onFavoritePressed: onFavoritePressed,
          onTap: () {
            onProductTap(index);
          },
        );
      },
    );
  }
}

class ProductGridCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final void Function() onFavoritePressed;
  final void Function() onTap;

  const ProductGridCard({
    super.key,
    required this.product,
    required this.onFavoritePressed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ProductImage(path: product["image"]),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Material(
                      color: Colors.white70,
                      shape: const CircleBorder(),
                      child: IconButton(
                        icon: const Icon(Icons.favorite),
                        color: Colors.red,
                        onPressed: onFavoritePressed,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product["name"],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'EGP ${product["price"]}',
                    style: TextStyle(
                      color: Colors.brown.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductListCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final void Function() onFavoritePressed;
  final void Function() onTap;

  const ProductListCard({
    super.key,
    required this.product,
    required this.onFavoritePressed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 100,
          child: Row(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: ProductImage(path: product["image"]),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product["name"],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'EGP ${product["price"]}',
                        style: TextStyle(
                          color: Colors.brown.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.favorite),
                color: Colors.red,
                onPressed: onFavoritePressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}