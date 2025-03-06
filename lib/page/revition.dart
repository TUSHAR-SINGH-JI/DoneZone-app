import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Shopping App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ProductOverviewScreen(),

    );
  }
}

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final Color color;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.color,
  });
}

class Cart {
  final Map<String, int> _items = {};

  Map<String, int> get items => _items;

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items[product.id] = _items[product.id]! + 1;
    } else {
      _items[product.id] = 1;
    }
  }

  int get itemCount {
    return _items.values.fold(0, (sum, item) => sum + item);
  }

  void clear() {
    _items.clear();
  }
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  final List<Product> products = [
    Product(id: 'p1', title: 'Red Shirt', description: 'A red shirt - it is pretty red!', price: 29.99, color: Colors.red),
    Product(id: 'p2', title: 'Blue Pants', description: 'A nice pair of blue pants.', price: 59.99, color: Colors.blue),
    Product(id: 'p3', title: 'Green Hat', description: 'A stylish green hat.', price: 19.99, color: Colors.green),
    Product(id: 'p4', title: 'Yellow Scarf', description: 'A warm yellow scarf.', price: 15.99, color: Colors.yellow),
    Product(id: 'p5', title: 'Purple Shoes', description: 'Trendy purple shoes.', price: 79.99, color: Colors.purple),
  ];

  final Cart cart = Cart();

  void _showCart() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Cart'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: cart.items.entries.map((entry) {
            return ListTile(
              title: Text(entry.key),
              trailing: Text('x${entry.value}'),
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('Close'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                cart.clear();
              });
              Navigator.of(ctx).pop();
            },
            child: Text('Clear Cart'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: _showCart,
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
        itemBuilder: (ctx, i) => ProductItem(
          product: products[i],
          onAddToCart: (product) {
            setState(() {
              cart.addItem(product);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${product.title} added to cart!'),
                duration: Duration(seconds: 2),
              ),
            );
          },
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  final void Function(Product product) onAddToCart;

  ProductItem({required this.product, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                product.color.withOpacity(0.7),
                product.color,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Text(
              product.title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(product.title),
          trailing: IconButton(
            icon: Icon(Icons.add_shopping_cart),
            onPressed: () => onAddToCart(product),
            color: Colors.yellow,
          ),
        ),
      ),
    );
  }
}
